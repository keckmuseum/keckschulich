<?php
ini_set( 'display_errors', 0 );

// ===================================================
// Load database info and local development parameters
// ===================================================
define( 'DB_NAME', getenv('WORDPRESS_DB_NAME') );
define( 'DB_USER',  getenv('WORDPRESS_DB_USER') );
define( 'DB_PASSWORD', getenv('WORDPRESS_DB_PASSWORD') );
define( 'DB_HOST', getenv('WORDPRESS_DB_HOST') );

//define( 'WP_CONTENT_URL', getenv('WORDPRESS_PROTOCOL').'://'.getenv('WORDPRESS_DOMAIN').'/'.getenv('WORDPRESS_CONTENT_DIR'));

//define('FS_METHOD', 'direct');

require('/var/www/html/secrets/salts.php');

// ========================
// Custom Content Directory
// ========================
define( 'WP_CONTENT_DIR', dirname( __FILE__ ) . '/' . getenv('WORDPRESS_CONTENT_DIR') );
if(isset($_SERVER['HTTP_HOST'])) {
  define( 'WP_CONTENT_URL', getenv('WORDPRESS_PROTOCOL') . $_SERVER['HTTP_HOST'] . '/' . getenv('WORDPRESS_CONTENT_DIR') );
}

// ================================================
// You almost certainly do not want to change these
// ================================================
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );

// ================================
// Language
// Leave blank for American English
// ================================

if(getenv('WORDPRESS_LANG')) {
  define( 'WPLANG', WORDPRESS_LANG );
}

if(getenv('WORDPRESS_MEMORY_LIMIT')) {
  define( 'WP_MEMORY_LIMIT', WORDPRESS_MEMORY_LIMIT );
}

if(getenv('WORDPRESS_DISALLOW_FILE_MODS')) {
  define( 'DISALLOW_FILE_MODS', WORDPRESS_DISALLOW_FILE_MODS );
}

if(getenv('WORDPRESS_FORCE_SSL_ADMIN')) {
  define( 'FORCE_SSL_ADMIN', WORDPRESS_FORCE_SSL_ADMIN );
}


// ======================
// Hide errors by default
// ======================
if(getenv('WORDPRESS_DEBUG')==true || (getenv('WORDPRESS_DEBUG')==NULL && getenv('WORDPRESS_ENV')=='development')){
  ini_set( 'display_errors', E_ALL );
  define( 'WP_DEBUG',         true );
  define( 'WP_DEBUG_LOG',     true );
  define( 'WP_DEBUG_DISPLAY', false );
  define( 'SCRIPT_DEBUG',     true );
}

if(getenv('WORDPRESS_SAVEQUERIES')) {
  define( 'SAVEQUERIES',      WORDPRESS_SAVEQUERIES );
}

// =========================
// Disable automatic updates
// =========================
define( 'AUTOMATIC_UPDATER_DISABLED', false );

// =======================
// Load WordPress Settings
// =======================
$table_prefix  = 'wp_';

if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', dirname( __FILE__ ) . '/' . getenv('WORDPRESS_CORE_DIR') . '/' );
}
require_once( ABSPATH . 'wp-settings.php' );
