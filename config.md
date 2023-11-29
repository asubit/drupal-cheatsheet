# Configuration

## Static

```php
\Drupal::config('config_name');
```

## Dependency injection

```yml
services:
  hello.service:
    class: \Drupal\my_module\Service\Hello
    arguments:
      - '@config.factory'
 ```

```php
...
use Drupal\Core\Config\ConfigFactory;
use Drupal\Core\StringTranslation\StringTranslationTrait;
...
class Hello {

  use StringTranslationTrait;
  
  /**
   * Configuration factory.
   *
   * @var \Drupal\Core\Config\ConfigFactory
   */
  protected $configFactory;
  
  /**
   * {@inheritdoc}
   */
  public function __construct(ConfigFactory $configFactory) {
    $this->configFactory = $configFactory;
  }
  
  public function getConfig() {
    $this->configFactory->get('config_name')->get('field_name');
  }
  
  public function setConfig() {
    $config = $this->configFactory->getEditable('config_name');
    $config->set('field_name', 'new_value');
    $config->save();
  }
}
 ```
 
 ## API links

  - [Defining and using your own configuration in Drupal](https://www.drupal.org/docs/develop/creating-modules/defining-and-using-your-own-configuration-in-drupal)
  - [Simple Configuration API](https://www.drupal.org/docs/drupal-apis/configuration-api/simple-configuration-api)
  - [config.factory](https://api.drupal.org/api/drupal/core%21core.services.yml/service/config.factory/10)
  - [Drupal::config()](https://api.drupal.org/api/drupal/core%21lib%21Drupal.php/function/Drupal%3A%3Aconfig/10)
