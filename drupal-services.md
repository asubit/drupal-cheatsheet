# Drupal services

## Route match

 > https://api.drupal.org/api/drupal/core!lib!Drupal.php/function/Drupal%3A%3ArouteMatch/8.2.x

```yaml
 - '@current_route_match'
```

```php
use Drupal\Core\Routing\RouteMatchInterface;

class Hello {
  /**
   * Route match.
   *
   * @var \Drupal\Core\Routing\RouteMatchInterface
   */
  protected $routeMatch;
}
```
