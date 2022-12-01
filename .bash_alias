# Drupal useful bash alias

Edit your `~/.bashrc` or `~/.bash_aliases` file.

```shell
# Drupal web root directory.
WEB_ROOT="/var/www/drupal/web"

# Your custom theme path.
THEME_ROOT="${WEB_ROOT}/themes/custom/my_theme"

# Custom alias.
alias cd_web="cd ${WEB_ROOT}"
alias cr="cd_web && php -d memory_limit=-1 ../vendor/bin/drush cr"
alias cc="cd_web && php -d memory_limit=-1 ../vendor/bin/drush cc drush && cr"
alias cim="cd_web && php -d memory_limit=-1 ../vendor/bin/drush cim"
alias cim-y="cd_web && php -d memory_limit=-1 ../vendor/bin/drush cim -y"
alias cex="cd_web && php -d memory_limit=-1 ../vendor/bin/drush cex"
alias cex-y="cd_web && php -d memory_limit=-1 ../vendor/bin/drush cex -y"
alias compil="cd ${THEME_ROOT} && ./node_modules/gulp/bin/gulp.js && cr"
```
