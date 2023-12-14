# Drush commands

## Database

```sh
# Export DB
drush sql-dump > ~/db.sql
# Drop DB
drush sql-drop
# Import DB
drush sql-cli < ~/db.sql
# Module updates
drush updb
```

## Maintenance
 ```sh
drush sset system.maintenance_mode TRUE
drush sset system.maintenance_mode FALSE
```

## User

```sh
drush user-create admin --mail="admin@admin.com" --password="admin"
drush user-add-role "administrator" admin
```

## Eval
```sh
# Generate UUID.
drush eval "echo \Drupal::service('uuid')->generate();"
# Force uninstall module.
drush eval "\$module_data = \Drupal::config('core.extension')->get('module'); unset(\$module_data['MODULE_NAME']); \Drupal::configFactory()->getEditable('core.extension')->set('module', \$module_data)->save();"
```
