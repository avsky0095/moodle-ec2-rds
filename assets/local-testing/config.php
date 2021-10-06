<?php  // Moodle configuration file

unset($CFG);
global $CFG;
$CFG = new stdClass();

$CFG->dbtype    = 'mariadb';
$CFG->dblibrary = 'native';
$CFG->dbhost    = 'mariadb_master';
$CFG->dbname    = 'db';
$CFG->dbuser    = 'user';
$CFG->dbpass    = '';
$CFG->prefix    = 'mdl_';
$CFG->dboptions = array(
    'dbpersist' => false,
    'dbsocket'  => false,
    'dbport'    => '3306',
    'dbhandlesoptions' => false,
    'dbcollation' => 'utf8mb4_unicode_ci',
    'connecttimeout' => null,
    'readonly' => [          
        'instance' => getenv('MOODLE_DATABASE_READREPLICA_HOST'),
        'connecttimeout' => 2,
        'latency' => 0.5,
    ]
);

if (empty($_SERVER['HTTP_HOST'])) {
  $_SERVER['HTTP_HOST'] = '127.0.0.1';
}
if (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] == 'on') {
  $CFG->wwwroot   = 'https://' . $_SERVER['HTTP_HOST'];
} else {
  $CFG->wwwroot   = 'http://' . $_SERVER['HTTP_HOST'];
}
$CFG->dataroot  = '/bitnami/moodledata';
$CFG->admin     = 'admin';

$CFG->directorypermissions = 02775;

$CFG->pathtophp = '/opt/bitnami/php/bin/php';

$CFG->disableupdatenotifications = true;
$CFG->disableupdateautodeploy = true;

date_default_timezone_set('Asia/Jakarta');

require_once(__DIR__ . '/lib/setup.php');

// There is no php closing tag in this file,
// it is intentional because it prevents trailing whitespace problems!
