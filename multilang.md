# Multilang

## Translations

In Twig template :

```twig
{{ "Lorem ipsum @var dolor sit amet."|t({'@var': var}, {'context': 'Custom context name') }}
```

In `.module` and `.theme` files :
```php
$string = t("Lorem ipsum @var dolor sit amet.", ['@var' => $var], ['context' => 'Custom context name']);
```

In PHP class files :

```php
...
use Drupal\Core\StringTranslation\StringTranslationTrait;
...
class Hello {
  use StringTranslationTrait;
  
  public function something() {
    $string = $this->t("Lorem ipsum @var dolor sit amet.", ['@var' => $var], ['context' => 'Custom context name']);
  }
}
```

 > **Tips** : Add context filter in user interface translation (should be native in Drupal 10) :https://www.drupal.org/project/drupal/issues/2123543
 
 ## Language Manager
 
 ### Static
 
 ```php
 \Drupal::languageManager();
 ```
 
 ### Dependency injection
 
  ```yml
services:
  hello.service:
    class: \Drupal\my_module\Service\Hello
    arguments:
      - '@language_manager'
 ```
 
  ```php
...
use Drupal\Core\Language\LanguageManager;
...
class Hello {
  
  /**
   * Language manager.
   *
   * @var \Drupal\Core\Language\LanguageManager
   */
  protected $languageManager;
  
  /**
   * {@inheritdoc}
   */
  public function __construct(LanguageManager $languageManager) {
    $this->languageManager = $languageManager;
  }
  
  public function something() {
    $current_lang = $this->languageManager->getCurrentLanguage();
    $current_lang_id = $current_lang->getId();
    $current_lang_name = $current_lang->getName();
    $langs = $this->languageManager->getLanguages();
  }
}
 ```
 
 ## API links
 
 - [Drupal::languageManager](https://api.drupal.org/api/drupal/core%21lib%21Drupal.php/function/Drupal%3A%3AlanguageManager/9.3.x)
 - [LanguageManagerInterface](https://api.drupal.org/api/drupal/core%21lib%21Drupal%21Core%21Language%21LanguageManagerInterface.php/interface/LanguageManagerInterface/9.3.x)
 - [LanguageInterface](https://api.drupal.org/api/drupal/core%21lib%21Drupal%21Core%21Language%21LanguageInterface.php/interface/LanguageInterface/9.3.x)
 
