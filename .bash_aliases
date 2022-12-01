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
alias en='f(){ cd_web && php -d memory_limit=-1 ../vendor/bin/drush en "$@";  unset -f f; }; f'
alias pmu='f(){ cd_web && php -d memory_limit=-1 ../vendor/bin/drush pmu "$@";  unset -f f; }; f'
alias ws='cd_web && php -d memory_limit=-1 ../vendor/bin/drush ws --tail'
alias compil="cd ${THEME_ROOT} && ./node_modules/gulp/bin/gulp.js && cr"

# Make all vendor binaries available as command.
export PATH="/var/www/drupal/vendor/bin:$PATH"
```
