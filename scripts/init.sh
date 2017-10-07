#!/bin/bash

cd /var/www/html

# Create directories
if [ ! -d "public/$WORDPRESS_CORE_DIR" ]; then
  echo "creating public/${WORDPRESS_CORE_DIR}"
  sudo mkdir public/$WORDPRESS_CORE_DIR


  # Download core files
  cd public/$WORDPRESS_CORE_DIR
  if [[ -n $WORDPRESS_VERSION ]] && [[ $WORDPRESS_VERSION != '' ]]; then
    echo "downloading WP ${WORDPRESS_VERSION} core files"
    sudo -E -u www-data wpcli core download --version=$WORDPRESS_VERSION
  else
    echo "downloading WP latest core files"
    sudo -E -u www-data wpcli core download
  fi
  if [[ -f "public/$WORDPRESS_CORE_DIR/.htaccess" ]] && [[ ! -f "public/.htaccess" ]]; then
    echo "copying .htaccess from core"
    cp public/$WORDPRESS_CORE_DIR/.htaccess public/.htaccess
  fi
else
  echo "core directory exists"
fi




cd /var/www/html

if [ ! -d "public/$WORDPRESS_CONTENT_DIR" ]; then
  echo "creating public/${WORDPRESS_CONTENT_DIR}"
  mkdir public/$WORDPRESS_CONTENT_DIR
  chown www-data:www-data public/$WORDPRESS_CONTENT_DIR
else
  echo "content directory exists"
fi

if [ ! -d "public/$WORDPRESS_CONTENT_DIR/themes" ]; then
  echo "creating public/${WORDPRESS_CONTENT_DIR}/themes"
  sudo mkdir public/$WORDPRESS_CONTENT_DIR/themes
else
  echo "themes directory exists"
fi

if [ ! -d "public/$WORDPRESS_CONTENT_DIR/plugins" ]; then
  echo "creating public/${WORDPRESS_CONTENT_DIR}/plugins"
  sudo mkdir public/$WORDPRESS_CONTENT_DIR/plugins
else
  echo "plugins directory exists"
fi

if [ ! -d "public/$WORDPRESS_CONTENT_DIR/uploads" ]; then
  echo "creating public/${WORDPRESS_CONTENT_DIR}/uploads"
  sudo mkdir public/$WORDPRESS_CONTENT_DIR/uploads
else
  echo "uploads directory exists"
fi

echo "setting permisions on public, public/$WORDPRESS_CORE_DIR and public/$WORDPRESS_CONTENT_DIR"
sudo chown root:www-data public
sudo chown -Rf root:www-data public/$WORDPRESS_CORE_DIR
sudo chown -Rf www-data:www-data public/$WORDPRESS_CONTENT_DIR
sudo chmod -Rf 755 public


if [[ $WORDPRESS_IMPORT_DB != '' ]] && [[ -f $WORDPRESS_IMPORT_DB ]]; then
  echo "importing db from ${WORDPRESS_IMPORT_DB}"
  bash scripts/restore-db.sh $WORDPRESS_IMPORT_DB
else
  echo "no import specified"
fi

if [ ! -f "secrets/salts.php" ]; then
  cp secrets/salts.sample.php secrets/salts.php
  chown www-data:www-data secrets/salts.php
  bash scripts/wp-salt-gen.sh /var/www/html/secrets salts.php
else
  echo "salts exist"
fi


# if [ "$CRON_JOBS" != '' ]; then
#   echo "adding cron job(s)"
#   (crontab -l 2>/dev/null; echo ${CRON_JOBS}) | crontab -
# fi
