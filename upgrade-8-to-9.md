
## Upgrade to Drupal 9

### Install Upgrade Status

https://www.drupal.org/project/upgrade_status

```shell
composer show drupal/core | grep versions
composer require --dev drupal/core-dev:[copy version above] --update-with-all-dependencies
composer require drupal/upgrade_status
drush en upgrade_status
drush cc drush && drush cr
```

Go to /admin/reports/upgrade-status to see all problems. Fix all problems.

### Do the upgrade

https://www.drupal.org/docs/upgrading-drupal/upgrading-from-drupal-8-to-drupal-9-or-later

```shell
composer outdated "drupal/*"
```

Perform the following steps from your Drupal 8 site's root (where `composer.json` lives).

1. Temporarily add write access to protected files and directories:

   ```php
   chmod 777 web/sites/default
   chmod 666 web/sites/default/*settings.php
   chmod 666 web/sites/default/*services.yml
   ```

2. Next, you'll need to pull in both the Drupal 9 version of `core-recommended` and `dev-dependencies` packages as dependencies. We use `--no-update` to avoid a chicken-and-egg problem with mutual dependencies:

   ```php
   composer require 'drupal/core-recommended:^9' 'drupal/core-composer-scaffold:^9' 'drupal/core-project-message:^9' --update-with-dependencies --no-update
   ```

   If you have `drupal/core-dev` installed:

   ```php
   composer require 'drupal/core-dev:^9' --dev --update-with-dependencies --no-update
   ```

3. Now, actually perform the update to the code itself:

   ```php
   composer update drupal/core --with-dependencies
       or
   composer update --with-dependencies
   ```

Rollback permissions

```php
chmod 755 web/sites/default
chmod 644 web/sites/default/*settings.php
chmod 644 web/sites/default/*services.yml
```
