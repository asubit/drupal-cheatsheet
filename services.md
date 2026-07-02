## Route match
 > https://api.drupal.org/api/drupal/core%21lib%21Drupal.php/function/Drupal%3A%3ArouteMatch/11.x
Inline :
```php
\Drupal::routeMatch();
```
Service name : 
```yml
current_route_match
```
Dependency injection : 
```php
use Drupal\Core\Routing\RouteMatchInterface;
```
Usecase : 
```php
$this->routeMatch->getRouteName() === 'user.register';
```

## Service name
 > https://api.drupal.org/api/drupal
Inline :
```php
```
Service name : 
```yml
current_route_match
```
Dependency injection : 
```php
```
Usecase : 
```php
```
