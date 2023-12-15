# Drupal services

The Services and Dependency Injection Container concepts have been adopted by Drupal from the Symfony DependencyInjection component. A "service" (such as accessing the database, sending email, or translating user interface text) is defined (given a name and an interface or at least a class that defines the methods that may be called), and a default class is designated to provide the service. These two steps must be done together, and can be done by Drupal Core or a module.

 > [Services and Dependency Injection Container](https://api.drupal.org/api/drupal/core%21core.api.php/group/container/10)<br>
 [All the services name](https://api.drupal.org/api/drupal/services/10)<br>
 [All the service tags](https://api.drupal.org/api/drupal/core%21core.api.php/group/service_tag/10)

## Summary

 - [Current user](#current-user)
 - [Route match](#route-match)
 - [Request stack](#request-stack)
 - [Class resolver](#class-resolver)

## Current user

Use to get the current user.

```php
\Drupal::currentUser();
```

```yml
services:
  hello:
    class: Drupal\module_name\Service\Hello
    arguments:
      - '@current_user'
```

```php
use Drupal\Core\Session\AccountProxyInterface;

    /**
     * Current user.
     *
     * @var \Drupal\Core\Session\AccountProxyInterface
     */
    protected $currentUser;

    public function __construct(
      AccountProxyInterface $accountProxy
    ) {
      $this->currentUser = $accountProxy;
    }

    public function doSomething() {
      // Returns the unaltered login name of this account. 
      $this->currentUser->getAccountName();
      // Returns the display name of this account. 
      $this->currentUser->getDisplayName();
      // Returns the email address of this account.  
      $this->currentUser->getEmail();
      // The timestamp when the account last accessed the site.  
      $this->currentUser->getLastAccessedTime();
      // Returns the preferred administrative language code of the account.  
      $this->currentUser->getPreferredAdminLangcode();
      // Returns the preferred language code of the account. 
      $this->currentUser->getPreferredLangcode();
      // Returns a list of roles.  
      $this->currentUser->getRoles();
      // Returns the timezone of this account. 
      $this->currentUser->getTimeZone();
      // Checks whether a user has a certain permission. 
      $this->currentUser->hasPermission();
      // Returns the user ID or 0 for anonymous. 
      $this->currentUser->id();
      // Returns TRUE if the account is anonymous. 
      $this->currentUser->isAnonymous();
      // Returns TRUE if the account is authenticated.
      $this->currentUser->isAuthenticated();

      // Gets the currently wrapped account. 
      $this->currentUsergetAccount();
      // Sets the currently wrapped account. 
      $this->currentUsersetAccount();
      // Sets the id of the initial account.
      $this->currentUsersetInitialAccountId();
    }
```

 - [Drupal::currentUser()](https://api.drupal.org/api/drupal/core!lib!Drupal.php/function/Drupal%3A%3AcurrentUser/8.2.x)
 - [AccountInterface](https://api.drupal.org/api/drupal/core%21lib%21Drupal%21Core%21Session%21AccountInterface.php/interface/AccountInterface/10)
 - [AccountProxyInterface](https://api.drupal.org/api/drupal/core%21lib%21Drupal%21Core%21Session%21AccountProxyInterface.php/interface/AccountProxyInterface/8.8.x)

## Route match

```yml
services:
  hello:
    class: Drupal\module_name\Service\Hello
    arguments:
      - '@current_route_match'
```

```php
use Drupal\Core\Routing\RouteMatchInterface;

  /**
   * Route match.
   *
   * @var \Drupal\Core\Routing\RouteMatchInterface
   */
  protected $routeMatch;

  public function __construct(
    RouteMatchInterface $routeMatch
  ) {
    $this->routeMatch = $routeMatch;
  }

  public function doSomething() {
    // Get current route name.
    $route = $this->routeMatch->getRouteName();
    // Get current route parameters.
    $routeParameters = $this->routeMatch->getRawParameters()->all();
    // Get current node.
    $node = $this->routeMatch->getParameter('node');
    // Get current block.
    $block = $this->routeMatch->getParameter('block_content');
    // Get current entity.
    foreach ($this->routeMatch->getParameters() as $param) {
      if ($param instanceof \Drupal\Core\Entity\EntityInterface) {
        $entity = $param;
      }
    }
  }

  public function doc() {
    // Returns the processed value of a named route parameter. 
    $this->routeMatch->getParameter();
    // Returns the bag of all processed route parameters.  
    $this->routeMatch->getParameters();
    // Returns the raw value of a named route parameter. 
    $this->routeMatch->getRawParameter();
    // Returns the bag of all raw route parameters.  
    $this->routeMatch->getRawParameters();
    // Returns the route name. 
    $this->routeMatch->getRouteName();
    // Returns the route object.
    $this->routeMatch->getRouteObject();
  }
```

 - [Drupal::routeMatch()](https://api.drupal.org/api/drupal/core!lib!Drupal.php/function/Drupal%3A%3ArouteMatch/8.2.x)
 - [RouteMatchInterface](https://api.drupal.org/api/drupal/core%21lib%21Drupal%21Core%21Routing%21RouteMatchInterface.php/interface/RouteMatchInterface/10)
 - [Routing API](https://api.drupal.org/api/drupal/core%21lib%21Drupal%21Core%21Routing%21routing.api.php/group/routing/10)

## Request stack

Get current request and cookies.

**Static call :**

```php
\Drupal::requestStack();
```

**Dependency injection :**

```yml
services:
  hello:
    class: Drupal\module_name\Service\Hello
    arguments:
      - '@request_stack'
```

```php
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\RequestStack;

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

  public function __construct(RequestStack $requestStack) {
    $this->requestStack = $requestStack;
    $this->currentRequest = $requestStack->getCurrentRequest();
  }

  public function useRequestStack() {
    // Pushes a Request on the stack.
    $this->requestStack->push($request);
    // Pops the current request from the stack.
    $this->requestStack->pop();
    // Gets the main request.
    $this->requestStack->getMainRequest();
    // Returns the parent request of the current.
    $this->requestStack->getParentRequest();
    // Gets the current session.
    $this->requestStack->getSession();
  }

  public function useCurrentRequest() {
    // Get a cookie by its name.
    $currentRequest->cookies->get('COOKIE_NAME');
  }
```

 - [Drupal::requestStack()](https://api.drupal.org/api/drupal/core!lib!Drupal.php/function/Drupal%3A%3ArequestStack/8.2.x)
 - [RequestStack](https://github.com/symfony/http-foundation/blob/7.0/RequestStack.php)
 - [Request](https://github.com/symfony/http-foundation/blob/7.0/Request.php)

## Class resolver

This is to be used in procedural code such as module files to instantiate an object of a class that implements [\Drupal\Core\DependencyInjection\ContainerInjectionInterface](https://api.drupal.org/api/drupal/core%21lib%21Drupal%21Core%21DependencyInjection%21ContainerInjectionInterface.php/interface/ContainerInjectionInterface/10).

One common usecase is to provide a class which contains the actual code of a hook implementation, without having to create a service.

**Static call :**

```php
$classResolver = \Drupal::classResolver();
$class = \Drupal::classResolver('\Drupal\module_name\Example');
```

**Dependency injection :**

```yml
services:
  hello:
    class: Drupal\module_name\Service\Hello
    arguments:
      - '@class_resolver'
```

```php
  use Drupal\Core\DependencyInjection\ClassResolverInterface;

  /**
   * Class resolver.
   *
   * @var \Drupal\Core\DependencyInjection\ClassResolverInterface
   */
  protected $classResolver;

  /**
   * Example of a class resolved with the Class Resolver.
   *
   * @var \Drupal\module_name\Example
   */
  protected $classExample;

  /**
   * {@inheritdoc}
   */
  public function __construct(ClassResolverInterface $classResolver) {
    $this->classResolver = $classResolver;
    $this->classExample = $this->classResolver->getInstanceFromDefinition('\Drupal\module_name\Example');
  }
```

 - [Drupal::classResolver()](https://api.drupal.org/api/drupal/core%21lib%21Drupal.php/function/Drupal%3A%3AclassResolver/9.2.x)
