<?php
/*
 * Project:     MagpieRSS: a simple RSS integration tool
 * File:        rss_fetch.inc, a simple functional interface
 				to fetching and parsing RSS files, via the
				function fetch_rss()
 * Author:      Kellan Elliott-McCrea <kellan@protest.net>
 * Version:		0.3
 * License:		GPL
 *
 * The lastest version of MagpieRSS can be obtained from:
 * http://magpierss.sourceforge.net
 *
 * For questions, help, comments, discussion, etc., please join the
 * Mapgie mailing list:
 * magpierss-general@lists.sourceforge.net
 *
 */
 
// Setup MAGPIE_DIR for use on hosts that don't include
// the current path in include_path.
// with thanks to rajiv and smarty
define('DIR_SEP', DIRECTORY_SEPARATOR);

if (!defined('MAGPIE_DIR')) {
    define('MAGPIE_DIR', dirname(__FILE__) . DIR_SEP);
}

require_once( MAGPIE_DIR . 'rss_parse.inc' );
require_once( MAGPIE_DIR . 'rss_cache.inc' );

// for including 3rd party libraries
define('MAGPIE_EXTLIB', MAGPIE_DIR . 'extlib' . DIR_SEP);
require_once( MAGPIE_EXTLIB . 'Snoopy.class.inc');


/* 
 * CONSTANTS - redefine these in your script to change the
 * behaviour of fetch_rss() currently, most options effect the cache
 *
 * MAGPIE_CACHE_ON - Should Magpie cache parsed RSS objects? 
 * For me a built in cache was essential to creating a "PHP-like" 
 * feel to Magpie, see rss_cache.inc for rationale
 *
 *
 * MAGPIE_CACHE_DIR - Where should Magpie cache parsed RSS objects?
 * This should be a location that the webserver can write to.   If this 
 * directory does not already exist Mapie will try to be smart and create 
 * it.  This will often fail for permissions reasons.
 *
 *
 * MAPGIE_CACHE_AGE - How long to store cached RSS objects? In seconds.
 *
 *
 * MAGPIE_CACHE_FRESH_ONLY - If remote fetch fails, throw error
 * instead of returning stale object?
 *
 * MAGPIE_DEBUG - Display debugging notices?
 *
*/


/*=======================================================================*\
	Function: fetch_rss: 
	Purpose:  return RSS object for the give url
			  maintain the cache
	Input:	  url of RSS file
	Output:	  parsed RSS object (see rss_parse.inc)

	NOTES ON CACHEING:  
	If caching is on (MAGPIE_CACHE_ON) fetch_rss will first check the cache.
	
	NOTES ON RETRIEVING REMOTE FILES:
	If conditional gets are on (MAGPIE_CONDITIONAL_GET_ON) fetch_rss will
	return a cached object, and touch the cache object upon recieving a
	304.
	
	NOTES ON FAILED REQUESTS:
	If there is an HTTP error while fetching an RSS object, the cached
	version will be return, if it exists (and if MAGPIE_CACHE_FRESH_ONLY is off)
\*=======================================================================*/

function fetch_rss ($url,$hash=false) {
	// initialize constants
	init();
	
	// if cache is disabled
	if ( !MAGPIE_CACHE_ON ) {
		// fetch file, and parse it
		$resp = _fetch_remote_file( $url );
		if ( is_success( $resp->status ) ) {
			return _response_to_rss( $resp, $hash );
		}
		else {
			trigger_error("MagpieRSS: failed to fetch $url. Cache is off");
			return false;
		}
	} 
	// else cache is ON
	else {
		// Flow
		// 1. check cache
		// 2. if there is a hit, make sure its fresh
		// 3. if cached obj fails freshness check, fetch remote
		// 4. if remote fails, return stale object, or error
		
		$cache = new RSSCache( MAGPIE_CACHE_DIR, MAGPIE_CACHE_AGE );
		
		if (MAGPIE_DEBUG and $cache->ERROR) {
			trigger_error($cache->ERROR, E_USER_WARNING);
		}
		
		
		$cache_status;				// response of check_cache
		$request_headers = array(); // HTTP headers to send with fetch
		$rss;						// parsed RSS object
		$errormsg;					// errors, if any
		
		if (!$cache->ERROR) {
			// return cache HIT, MISS, or STALE
			$cache_status = $cache->check_cache( $url );
		}
		
		// if object cached, and cache is fresh, return cached obj
		if ( $cache_status == 'HIT' ) {
			$rss = $cache->get( $url );
			if ( $rss ) {
				$rss->from_cache = 1;
				if ( MAGPIE_DEBUG > 1) {
				trigger_error("Cache HIT", E_USER_NOTICE);
			}
				return $rss;
			}
		}
		
		// else attempt a conditional get
		
		// setup headers
		if ( $cache_status == 'STALE' ) {
			$rss = $cache->get( $url );
			if ( $rss->etag and $rss->last_modified ) {
				$request_headers['If-None-Match'] = $rss->etag;
				$request_headers['If-Last-Modified'] = $rss->last_modified;
			}
		}
		
		$resp = _fetch_remote_file( $url, $request_headers );
		
		if ($resp) {
			if ($resp->status == '304' ) {
				// we have the most current copy
				if ( MAGPIE_DEBUG > 1) {
					$msg = "Got 304 for $url";
					trigger_error($msg, E_USER_NOTICE);
				}
				// TODO: not sure if I should re-set the cache here or not
				return $rss;
			}
			elseif ( is_success( $resp->status ) ) {
				$rss = _response_to_rss( $resp );
				if ( $rss ) {
					if (MAGPIE_DEBUG > 1) {
						trigger_error("Fetch successful", E_USER_NOTICE);
					}
					// add object to cache
					$cache->set( $url, $rss );
					return $rss;
				}
			}
			else {
				$errormsg = "Failed to fetch $url. ";
				if ( $resp->error ) {
					$errormsg .= "Error: " . $resp->error;
				}
				else {
					$errormsg .=  "Response: " . $resp->$response_code;
				}
			}
		}
		else {
			$errormsg = "Unable to retrieve RSS file for unknown reasons.";
		}
		
		// else fetch failed
		
		// attempt to return cached object
		if ($rss) {
			if ( MAGPIE_DEBUG ) {
				trigger_error("Returning STALE object for $url", E_USER_NOTICE);
			}
			return $rss;
		}
		
		// else we totally failed
		
		trigger_error( "MagpieRSS: " . $errormsg );	
		
		return false;
		
	} // end if ( !MAGPIE_CACHE_ON ) {
} // end fetch_rss()

/*=======================================================================*\
	Function:	_fetch_remote_files
	Purpose:	retrieve an arbitrary remote file
	Input:		url of the remote file
				headers to send along with the request (optional)
	Output:		an HTTP response object (see Snoopy.class.inc)	
\*=======================================================================*/
function _fetch_remote_file ($url, $headers) {
	// Snoopy is an HTTP client in PHP
	$client = new Snoopy();
	$client->agent = MAGPIE_USER_AGENT;
	$client->read_timeout = MAGPIE_FETCH_TIME_OUT;
	
	if (!empty($headers) ) {
		$client->rawheaders = $headers;
	}
	
	if ( $client->fetch($url) ) {
		return $client;
	}
	else {
		return false;
	}
}

/*=======================================================================*\
	Function:	_response_to_rss
	Purpose:	parse an HTTP response object into an RSS object
	Input:		an HTTP response object (see Snoopy)
	Output:		parsed RSS object (see rss_parse)
\*=======================================================================*/
function _response_to_rss ($resp,$hash=false) {
	
	if (md5($resp->results)==$hash) {
		echo "zadne nove data";
		return false;
	}

	$rss = new MagpieRSS( $resp->results );
	// if RSS parsed successfully		
	if ( $rss and !$rss->ERROR) {
		
		// find Etag, and Last-Modified
		foreach($resp->headers as $h) {
			list($field, $val) = explode(": ", $h, 2);
			if ( $field == 'ETag' ) {
				$rss->etag = $val;
			}
			
			if ( $field == 'Last-Modified' ) {
				$rss->last_modified = $val;
			}
		}
		
		return $rss;	
	} // else construct error message
	else {
		$errormsg = "MagpieRSS: failed to parse $url.";
		
		if ($rss) {
			$errormsg .= " " . $rss->ERROR;
		}
		trigger_error($errormsg);
		
		return false;
	} // end if ($rss and !$rss->error)
}

/*=======================================================================*\
	Function:	init
	Purpose:	setup constants with default values
				check for user overrides
\*=======================================================================*/
function init () {
	if ( defined('MAGPIE_INITALIZED') ) {
		return;
	}
	else {
		define('MAGPIE_INITALIZED', 1);
	}
	
	if ( !defined('MAGPIE_CACHE_ON') ) {
		define('MAGPIE_CACHE_ON', 1);
	}

	if ( !defined('MAGPIE_CACHE_DIR') ) {
		define('MAGPIE_CACHE_DIR', './cache');
	}

	if ( !defined('MAGPIE_CACHE_AGE') ) {
		define('MAGPIE_CACHE_AGE', 60*60); // one hour
	}

	if ( !defined('MAGPIE_CACHE_FRESH_ONLY') ) {
		define('MAGPIE_CACHE_FRESH_ONLY', 0);
	}

	if ( !defined('MAGPIE_DEBUG') ) {
		define('MAGPIE_DEBUG', 0);
	}
	
	if ( !defined('MAGPIE_USER_AGENT') ) {
		define('MAGPIE_USER_AGENT', 'MagpieRSS/0.3 (+http://magpierss.sf.net)' );
	}
	
	if ( !defined('MAGPIE_FETCH_TIME_OUT') ) {
		define('MAGPIE_FETCH_TIME_OUT', 5);	// 2 second timeout
	}
}

// NOTE: the following code should really be in Snoopy, or at least
// somewhere other then rss_fetch!

/*=======================================================================*\
	HTTP STATUS CODE PREDICATES
	These functions attempt to classify an HTTP status code
	based on RFC 2616 and RFC 2518.
	
	All of them take an HTTP status code as input, and return true or false

	All this code is adapted from LWP's HTTP::Status.
\*=======================================================================*/


/*=======================================================================*\
	Function:	is_info
	Purpose:	return true if Informational status code
\*=======================================================================*/
function is_info ($sc) { 
	return $sc >= 100 && $sc < 200; 
}

/*=======================================================================*\
	Function:	is_success
	Purpose:	return true if Successful status code
\*=======================================================================*/
function is_success ($sc) { 
	return $sc >= 200 && $sc < 300; 
}

/*=======================================================================*\
	Function:	is_redirect
	Purpose:	return true if Redirection status code
\*=======================================================================*/
function is_redirect ($sc) { 
	return $sc >= 300 && $sc < 400; 
}

/*=======================================================================*\
	Function:	is_error
	Purpose:	return true if Error status code
\*=======================================================================*/
function is_error ($sc) { 
	return $sc >= 400 && $sc < 600; 
}

/*=======================================================================*\
	Function:	is_client_error
	Purpose:	return true if Error status code, and its a client error
\*=======================================================================*/
function is_client_error ($sc) { 
	return $sc >= 400 && $sc < 500; 
}

/*=======================================================================*\
	Function:	is_client_error
	Purpose:	return true if Error status code, and its a server error
\*=======================================================================*/
function is_server_error ($sc) { 
	return $sc >= 500 && $sc < 600; 
}

?>
