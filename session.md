# Store data in session

## Static

```php
$session = \Drupal::service('user.private_tempstore')->get('module_name');
$session->set('variable', $value);
```

## Dependency injection

```yml
services:
  hello.service:
    class: \Drupal\my_module\Service\Hello
    arguments:
      - '@tempstore.private'
 ```
 
```php
...
use Drupal\Core\TempStore\PrivateTempStoreFactory;
...
class Hello {
  
  /**
   * User private temporary session storage.
   *
   * @var \Drupal\Core\TempStore\PrivateTempStore
   */
  protected $session;
  
  /**
   * {@inheritdoc}
   */
  public function __construct(PrivateTempStoreFactory $session_factory) {
    $this->session = $session_factory->get('module_name');
  }
  
  /**
   * Doing something wild with user session.
   */
  public function something() {
    // Add data in user temp storage session.
    $this->session->set('variable', $value);
  }
}
 ```
 
 ## API links
 
  - [tempstore.private](https://api.drupal.org/api/drupal/core%21core.services.yml/service/tempstore.private/8.8.x)
  - [PrivateTempStoreFactory](https://api.drupal.org/api/drupal/core%21modules%21user%21src%21PrivateTempStoreFactory.php/class/PrivateTempStoreFactory/8.9.x)
  - [PrivateTempStore](https://api.drupal.org/api/drupal/core%21modules%21user%21src%21PrivateTempStore.php/class/PrivateTempStore/8.9.x)
  - [UserSession](https://api.drupal.org/api/drupal/core%21lib%21Drupal%21Core%21Session%21UserSession.php/class/UserSession/8.8.x)
  - [AccountInterface](https://api.drupal.org/api/drupal/core%21lib%21Drupal%21Core%21Session%21AccountInterface.php/interface/AccountInterface/8.6.x)
