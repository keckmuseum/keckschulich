#!/bin/bash

#Get config
. scripts-config.sh

# Ask to Download WP Core
read -p "${environment} move-in: Download Core? [y/n]
" core;
if [ $core == y ]; then
  # Download WP Core
  wp core download --path=$WPPath
fi

# Ask to install plugins
read -p "${environment} move-in: Install Plugins? [y/n]
" plugins;
if [ $plugins == y ]; then
  # Download These Plugins
  wp plugin install wordpress-2-step-verification --path=$WPPath
fi

# Ask to restore latest DB
read -p "${environment} move-in: Restore DB (from db/latest)? [y/n]
" db;
if [ $db == y ]; then
  . restore-db.sh;

  # Ask to modify domain in DB
  read -p "${environment} move-in: Modify Domain in DB? [y/n]
  " db;
  if [ $db == y ]; then
    # Ask what domain to find in DB
    read -p "${environment} move-in: Find what domain? (eg. local.example.com)?
    " from;

    # Ask what domain to replace with in DB
    read -p "${environment} move-in: Replace with what domain? (eg. www.example.com)?
    " to;

    # Verify command
    read -p "${environment} move-in: About to run: \"wp search-replace ${from} ${to}  --path=${WPPath}\" Continue [y/n]?
    " verify;
      if [ $db == y ]; then
        wp search-replace ${from} ${to}  --path=${WPPath};
      fi
  fi
fi
