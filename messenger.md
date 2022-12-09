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
    // Add message to queue.
    $this->messenger->addMessage(
      $this->t("Lorem ipsum @var dolor sit amet.", ['@var' => $var], ['context' => 'Custom context name']),
      $this->messenger::TYPE_STATUS // Optionnal, status message. Other types are : TYPE_WARNING, TYPE_ERROR,
      FALSE // Optional, the message won't be repeated.
    );
    // Status message.
    $this->messenger->addStatus();
    // Warning message.
    $this->messenger->addWarning();
    // Error message.
    $this->messenger->addError();
    // Delete all messages.
    $this->messenger->deleteAll();
  }
}
 ```
 
 ## API links
 
  - [MessengerInterface](https://api.drupal.org/api/drupal/core%21lib%21Drupal%21Core%21Messenger%21MessengerInterface.php/interface/MessengerInterface/8.5.x)

