#!/bin/bash
sudo su - root

# update ubuntu

apt update
apt -y upgrade

# Apache, php, mysql

apt -y install apache2 libapache2-mod-php php-mysql
echo "<h1> My web server!! </h1>" > /var/www/html/index.html

# Wordpress

curl https://wordpress.org/latest.tar.gz | tar zx -C /var/www/html


cat > /var/www/html/wordpress/wp-config.php <<EOF
<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'wordpress' );

/** MySQL database password */
define( 'DB_PASSWORD', 'wordpress' );

/** MySQL hostname */
define( 'DB_HOST', '${db_host}' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'G@I7#|rwpU]B9+DFrurr>k?/MM3kN`7v[GNT9&<~7?);q/q23vSrFJuMs~Ybe</]' );
define( 'SECURE_AUTH_KEY',  'c1eXj_Ym[qHc[YY)4Ty6l8r}m6Nl:J_25-Y^CbC{Ln (=~-J!4[HehJ5C%=_bR$n' );
define( 'LOGGED_IN_KEY',    'L1ez`Vw|~|[/=zFZdD^V(1eVsmF!:wPL%|GgbW@NZd{_VAfL)`o0dMf[yC>}D$,)' );
define( 'NONCE_KEY',        'CgxQMY#d2MvE]59DQp$5?:u~--X3Az/noM?$_gP^J+V,pWL+:i$A5k<hI`,2FV-/' );
define( 'AUTH_SALT',        'Jc7~|)xC,Ua*VHA xg7rTpI$mk423nm1Y]N[TrQ?|CC~C4nrf%5;ap>=10c({Wpr' );
define( 'SECURE_AUTH_SALT', 'mTg$F-4gqRWEoYFh];)ypyuyaw_sp[s$MWdNw1W;m/oD/8T7z%>|kEm=e k3`%Qd' );
define( 'LOGGED_IN_SALT',   '(&*-~@5F/<WaG.^=A$pyc:~B441`#{[[3*O4<t0oRGyU0p+Cl}PoetfKWOf7UVVU' );
define( 'NONCE_SALT',       'VV={2= jh)m%2R MF2_Nq$>q9BrYTzUtT!Em:1UcYn3]SDBzh?r/L65*-7+[+8;K' );

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
EOF

