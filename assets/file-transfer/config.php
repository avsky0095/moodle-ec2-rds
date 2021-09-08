<?php  // Moodle configuration file

unset($CFG);
global $CFG;
$CFG = new stdClass();

$CFG->dbtype    = 'mariadb';
$CFG->dblibrary = 'native';
$CFG->dbhost    = 'rds-moodle.chngnw3p2ako.us-east-1.rds.amazonaws.com';
$CFG->dbname    = 'db_moodle';
$CFG->dbuser    = 'user';
$CFG->dbpass    = 'user123!';
$CFG->prefix    = 'mdl_';
$CFG->dboptions = array (
  'dbpersist' => 0,
  'dbport' => 3306,
  'dbsocket' => '',
  'dbcollation' => 'utf8_general_ci',

  'readonly' => [
      'instance' => [        // Readonly slave connection parameters
        [
          'dbhost' => 'rds-moodle-readreplica.chngnw3p2ako.us-east-1.rds.amazonaws.com',
          'dbport' => '3306',    // Defaults to master port
          'dbuser' => 'user',    // Defaults to master user
          'dbpass' => 'user123!',    // Defaults to master password
        ],
      ],
  ]  
);

if (empty($_SERVER['HTTP_HOST'])) {
  $_SERVER['HTTP_HOST'] = '127.0.0.1:8080';
}
if (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] == 'on') {
  $CFG->wwwroot   = 'https://' . $_SERVER['HTTP_HOST'];
} else {
  $CFG->wwwroot   = 'http://' . $_SERVER['HTTP_HOST'];
}
$CFG->dataroot  = '/bitnami/moodledata';
$CFG->admin     = 'admin';

$CFG->directorypermissions = 02775;

require_once(__DIR__ . '/lib/setup.php');

// There is no php closing tag in this file,
// it is intentional because it prevents trailing whitespace problems!