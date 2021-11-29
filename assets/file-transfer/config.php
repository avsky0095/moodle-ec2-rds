<?php  // Moodle configuration file

unset($CFG);
global $CFG;
$CFG = new stdClass();

$CFG->dbtype    = getenv("DB_TYPE");
$CFG->dblibrary = 'native';
$CFG->dbhost    = getenv("DB_HOST");
$CFG->dbname    = getenv("DB_NAME");
$CFG->dbuser    = getenv("DB_USER");
$CFG->dbpass    = getenv("DB_PASS");
$CFG->prefix    = 'mdl_';
$CFG->dboptions = array (
  'dbpersist' => 0,
  'dbport' => 3306,
  'dbsocket' => '',
  'dbcollation' => 'utf8_general_ci',
  'connecttimeout' => null,
  'readonly' => [          // Set to read-only slave details, to get safe reads
                             // from there instead of the master node. Optional.
                             // Currently supported by pgsql and mysqli variety classes.
                             // If not supported silently ignored.
    'instance' => [        // Readonly slave connection parameters
      [
        'dbhost' => "rds-moodle-readreplica.c0jycdiknw8b.us-east-1.rds.amazonaws.com",
        'dbport' => getenv("DB_PORT"),    // Defaults to master port
        'dbuser' => getenv("DB_USER"),    // Defaults to master user
        'dbpass' => getenv("DB_PASS"),    // Defaults to master password
      ],
    ],
  ],
);

$CFG->wwwroot   = getenv("SITE_URL");
$CFG->dataroot  = '/var/www/moodledata/';
$CFG->admin     = 'admin';

$CFG->directorypermissions = 02777;

$CFG->disableupdatenotifications = true;
$CFG->disableupdateautodeploy = true;

require_once(__DIR__ . '/lib/setup.php');

// There is no php closing tag in this file,
// it is intentional because it prevents trailing whitespace problems!
$CFG->preventexecpath = true;
