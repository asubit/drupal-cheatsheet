# Messenger

## Static

```php
\Drupal::messenger();
```

## Dependency injection

```yml
services:
  hello.service:
    class: \Drupal\my_module\Service\Hello
    arguments:
      - '@messenger'
 ```
 
```php
...
use Drupal\Core\Messenger\MessengerInterface;
use Drupal\Core\StringTranslation\StringTranslationTrait;
...
class Hello {

  use StringTranslationTrait;
  
  /**
   * Messenger interface.
   *
   * @var \Drupal\Core\Messenger\MessengerInterface
   */
  protected $messenger;
  
  /**
   * {@inheritdoc}
   */
  public function __construct(MessengerInterface $messenger) {
    $this->messenger = $messenger;
  }
  
  public function something() {
    $this->messenger->addMessage(
      $this->t("Lorem ipsum @var dolor sit amet.", ['@var' => $var], ['context' => 'Custom context name'])
      $this->messenger::TYPE_STATUS
    );
  }
}
 ```
 
 ## API links
 
  - [MessengerInterface](https://api.drupal.org/api/drupal/core%21lib%21Drupal%21Core%21Messenger%21MessengerInterface.php/interface/MessengerInterface/8.5.x)

