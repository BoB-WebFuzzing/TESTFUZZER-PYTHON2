--TEST--
Filtered tracing: path exclude [1]
--INI--
xdebug.mode=trace
xdebug.start_with_request=0
xdebug.collect_return=1
xdebug.collect_assignments=0
xdebug.trace_format=0
--FILE--
<?php
$cwd = __DIR__; $s = DIRECTORY_SEPARATOR; $includeDir = realpath( $cwd . '/..' );
xdebug_set_filter(XDEBUG_FILTER_TRACING, XDEBUG_PATH_EXCLUDE, [ "{$includeDir}{$s}filter{$s}xdebug" ] );

include "{$includeDir}/filter/foobar/foobar.php";
include "{$includeDir}/filter/xdebug/xdebug.php";

$tf = xdebug_start_trace(sys_get_temp_dir() . '/'. uniqid('xdt', TRUE));

Foobar::foo("hi");
Xdebug::foo("hi");
	
xdebug_stop_trace();
echo file_get_contents($tf);
unlink($tf);
?>
--EXPECTF--
ello!
ello!
TRACE START [%d-%d-%d %d:%d:%d.%d]
%w%f %w%d     -> Foobar::foo($s = 'hi') %strace-filter-path-exclude-001.php:10
%w%f %w%d       -> strstr($haystack = 'Hello!\n', $needle = 'e') %sfilter%efoobar%efoobar.php:6
%w%f %w%d        >=> 'ello!\n'
%w%f %w%d     -> Xdebug::foo($s = 'hi') %strace-filter-path-exclude-001.php:11
%w%f %w%d     -> xdebug_stop_trace() %strace-filter-path-exclude-001.php:13
%w%f %w%d
TRACE END   [%d-%d-%d %d:%d:%d.%d]
