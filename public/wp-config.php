<?php
ini_set( 'display_errors', 0 );

// ===================================================
// Load database info and local development parameters
// ===================================================
define( 'DB_NAME', getenv('WORDPRESS_DB_NAME') );
define( 'DB_USER',  getenv('WORDPRESS_DB_USER') );
define( 'DB_PASSWORD', getenv('WORDPRESS_DB_PASSWORD') );
define( 'DB_HOST', getenv('WORDPRESS_DB_HOST') );

define( 'WP_CONTENT_URL', getenv('WORDPRESS_PROTOCOL').'://'.getenv('WORDPRESS_DOMAIN').'/'.getenv('WORDPRESS_CONTENT_DIR'));

//define('FS_METHOD', 'direct');
if(getenv('WORDPRESS_DEBUG')==true){
  ini_set( 'display_errors', E_ALL );
  define( 'WP_DEBUG_DISPLAY', true );
  define( 'WP_DEBUG', true );
}

require(../salts.php);

// ========================
// Custom Content Directory
// ========================
define( 'WP_CONTENT_DIR', dirname( __FILE__ ) . '/content' );
if(isset($_SERVER['HTTP_HOST'])) {
  define( 'WP_CONTENT_URL', 'http://' . $_SERVER['HTTP_HOST'] . '/content' );
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
define( 'WPLANG', '' );

// ======================
// Hide errors by default
// ======================
//define( 'WP_DEBUG_DISPLAY', false );
//define( 'WP_DEBUG', false );

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
