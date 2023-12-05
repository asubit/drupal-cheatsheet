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

## Request stack

Get current request and cookies.

```yaml
 - '@request_stack'
```

```php
use Symfony\Component\HttpFoundation\RequestStack;

class Hello {
  /**
   * Request stack
   *
   * @var \Symfony\Component\HttpFoundation\RequestStack
   */
  protected $requestStack;

  /**
   * Current request
   *
   * @var \Symfony\Component\HttpFoundation\Request
   */
  protected $currentRequest;
  }

  /**
   * {@inheritdoc}
   */
  public function __construct(RequestStack $requestStack) {
    $this->requestStack = $requestStack;
    $this->currentRequest = $requestStack->getCurrentRequest();
  }

  /**
   * Get a cookie by its name.
   */
  public function getCookie() {
    return $currentRequest->cookies->get('COOKIE_NAME');
  }
```
