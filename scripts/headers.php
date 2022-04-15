#!/usr/bin/php
<?php

$SOURCES_DIR = getenv('SOURCES_DIR');

$VERSION     = getenv('VERSION');

$COM_NAME    = getenv('COM_NAME');
$PLG_NAME    = getenv('PLG_NAME');
$PKG_NAME    = getenv('PKG_NAME');

$META_CREATION_DATE         = getenv('META_CREATION_DATE');
$META_COPYRIGHT             = getenv('META_COPYRIGHT');
$META_LICENSE               = getenv('META_LICENSE');
$META_URL                   = getenv('META_URL');
$META_HEADER_COPYRIGHT_TEXT = getenv('META_HEADER_COPYRIGHT_TEXT');

if (!$SOURCES_DIR || !file_exists($SOURCES_DIR) || !is_dir(($SOURCES_DIR))) {
    echo PHP_EOL . "\n- Error: ${SOURCES_DIR} directory does not exist.";
    echo PHP_EOL . "-----------------------------";
    echo PHP_EOL;
    exit(1);
}

function recursive_glob($pattern, $flags = 0)
{
    $files = glob($pattern, $flags);
    foreach (glob(dirname($pattern).'/*', GLOB_ONLYDIR|GLOB_NOSORT) as $dir) {
        $files = array_merge(
            [],
            ...[$files, recursive_glob($dir."/".basename($pattern), $flags)]
        );
    }
    return $files;
}

function ask_for_consent()
{
    global $SOURCES_DIR;
    echo PHP_EOL . "Are you sure you want to continue?";
    echo PHP_EOL . "The files in the ${SOURCES_DIR} directory will be modified.";
    echo PHP_EOL . "Type 'yes' to continue: ";
    $handle = fopen ("php://stdin","r");
    $line = fgets($handle);
    if(trim($line) != 'yes'){
        echo PHP_EOL . "Aborting!";
        echo PHP_EOL;
        exit;
    }
    fclose($handle);
    echo PHP_EOL;
}

function update_php_files($php_files)
{
    global $META_HEADER_COPYRIGHT_TEXT;

    foreach ($php_files as $php_file) {
        echo PHP_EOL . " - Updating/modifying ${php_file}";

        $php_str = file_get_contents($php_file);

        $php_str_new = preg_replace(
            '/\/\*\*\n( \* @(version|package|copyright|license|link) .*\n)+ \*\//',
            $META_HEADER_COPYRIGHT_TEXT,
            $php_str
        );

        file_put_contents($php_file, $php_str_new);
    }
    echo PHP_EOL;
}

function update_xml_files($xml_files)
{
    global $SOURCES_DIR, $VERSION, $COM_NAME, $PLG_NAME, $PKG_NAME,
           $META_CREATION_DATE, $META_COPYRIGHT, $META_LICENSE, $META_URL;

    $accepted_xml_files = array(
		"${SOURCES_DIR}/${COM_NAME}/papermanager.xml" => true,
		"${SOURCES_DIR}/${PLG_NAME}/papermanager.xml" => true,
        "${SOURCES_DIR}/${PKG_NAME}.xml" => true
    );
    foreach ($xml_files as $xml_file) {
        if (!array_key_exists($xml_file, $accepted_xml_files)) {
            continue;
        }
        echo PHP_EOL . " - Updating/modifying ${xml_file}";

        $xml_str = file_get_contents($xml_file);
        $xml = new SimpleXMLElement($xml_str);

        if (isset($xml->version)) {
            echo PHP_EOL . "   Changing version from '" . $xml->version . "' to '${VERSION}'";
            $xml->version = $VERSION;
        }
        if (isset($xml->creationDate)) {
            echo PHP_EOL . "   Changing creationDate from '" . $xml->creationDate . "' to '${META_CREATION_DATE}'";
            $xml->creationDate = $META_CREATION_DATE;
        }
        if (isset($xml->copyright)) {
            echo PHP_EOL . "   Changing copyright from '" . $xml->copyright . "' to '${META_COPYRIGHT}'";
            $xml->copyright = $META_COPYRIGHT;
        }
        if (isset($xml->license)) {
            echo PHP_EOL . "   Changing license from '" . $xml->license . "' to '${META_LICENSE}'";
            $xml->license = $META_LICENSE;
        }
        if (isset($xml->url)) {
            echo PHP_EOL . "   Changing url from '" . $xml->url . "' to '${META_URL}'";
            $xml->url = $META_URL;
        }

        $output = $xml->asXML($xml_file);
    }
    echo PHP_EOL;
}

$php_files  = recursive_glob("${SOURCES_DIR}/*.php");
$html_files = recursive_glob("${SOURCES_DIR}/*.html");
$js_files   = recursive_glob("${SOURCES_DIR}/*.js");
$xml_files  = recursive_glob("${SOURCES_DIR}/*.xml");

//var_dump($php_files);
//var_dump($html_files);
//var_dump($js_files);
//var_dump($xml_files);
echo PHP_EOL . " - Found " . count($php_files)  . " php files";
echo PHP_EOL . " - Found " . count($html_files) . " html files";
echo PHP_EOL . " - Found " . count($js_files)   . " js files";
echo PHP_EOL . " - Found " . count($xml_files)  . " xml files";

ask_for_consent();

update_php_files($php_files);

update_xml_files($xml_files);

echo PHP_EOL;
