# Drupal cheatsheet

## Useful links

 - [API DOC : Homepage](https://api.drupal.org/api/drupal/10)
 - [API DOC : Drupal class](https://api.drupal.org/api/drupal/core!lib!Drupal.php/class/Drupal/10.x)

## Install Drupal 9

Download Composer :
```shell
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
```

Make Composer available as a command in shell :
```
sudo mv composer.phar /usr/local/bin/composer
```

Install Drupal :
```
composer create-project drupal/recommended-project my_site_name_dir
```

Set permissions :
```
find . -type d -exec chmod u=rwx,g=rx,o= '{}' \;
find . -type f -exec chmod u=rw,g=r,o= '{}' \;
chown -R www-data:www-data web/sites/default/files
```

 > https://www.drupal.org/docs/security-in-drupal/securing-file-permissions-and-ownership#linux-servers

PHP config :
```shell
memory_limit=1024M
max_input_vars = 1500
```

MySQL config :
```shell
max_allowed_packet=128M
max_connections=300
thread_cache_size=16
query_cache_limit=32M
query_cache_size=128M
long_query_time=1800
net_read_timeout=1800
net_write_timeout=1800
wait_timeout=1800
key_buffer_size=128M
innodb_buffer_pool_size=256M
```

## Install Drush

```shell
composer require drush/drush
echo 'export PATH="/var/www/drupal/vendor/bin:$PATH"' >> ~/.bashrc
```

## Module management

Install :

```shell
drush en module_name
```

Uninstall :

```shell
drush pmu module_name
```

Brutal way to uninstall in case of troubles (to execute in shell) :
```php
drush eval "\$module_data = \Drupal::config('core.extension')->get('module'); unset(\$module_data['MODULE_NAME']); \Drupal::configFactory()->getEditable('core.extension')->set('module', \$module_data)->save();"
```

## Cache management

Clear Drush cache :

```shell
drush cc drush
```

Clear and rebuild all caches :

```shell
drush cr
```

Brutal way in case of troubles (to execute in MySQL) :

```sql
TRUNCATE cache_config;
TRUNCATE cache_container;
TRUNCATE cache_data;
TRUNCATE cache_default;
TRUNCATE cache_discovery;
TRUNCATE cache_dynamic_page_cache;
TRUNCATE cache_entity;
TRUNCATE cache_menu;
TRUNCATE cache_render;
TRUNCATE cache_toolbar;
```

Brutal way in case of troubles (to execute in shell) :

```shell
mysql -h mysql -u root -proot drupal -e "TRUNCATE cache_config;TRUNCATE cache_container;TRUNCATE cache_data;TRUNCATE cache_default;TRUNCATE cache_discovery;TRUNCATE cache_dynamic_page_cache;TRUNCATE cache_entity;TRUNCATE cache_menu;TRUNCATE cache_render;TRUNCATE cache_toolbar;"
```

## Configuration management

Import configuration from files :

```shell
drush cim -y
```

Export configuration in files :

```shell
drush cex -y
```

## Maintenance

Enable maintenance mode :
```shell
drush sset system.maintenance_mode TRUE
```
Disable maintenance mode :
```shell
drush sset system.maintenance_mode FALSE
```

## User management

Create a user :
```shell
drush user-create alice --mail="alice@bob.com" --password="ALICE_PASSWORD"
```
Make a existing user administrator :
```shell
drush user-add-role "administrator" alice
```
Reset a password :
```shell
drush upwd alice NEW_PASSWORD
```
