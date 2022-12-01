# Entity type manager

## Static call
```php
\Drupal::entityTypeManager();
```

## Dependency injection call

my_module.services.yml

```yml
services:
  hello.service:
    class: \Drupal\my_module\Service\Hello
    arguments:
      - '@entity_type.manager'
```

Hello.php

```php
...
use Drupal\Core\Entity\EntityTypeManagerInterface;
...
class Hello {

 /**
   * Entity type manager.
   *
   * @var \Drupal\Core\Entity\EntityTypeManagerInterface
   */
  protected $entityTypeManager;

  /**
   * {@inheritdoc}
   */
  public function __construct(EntityTypeManagerInterface $entityTypeManager,) {
    $this->entityTypeManager = $entityTypeManager;
  }
  
  /**
   * Function doing something with EntityTypeManager.
   */
  public function something() {
    /** @var \Drupal\Core\Entity\EntityStorageInterface $storage */
    $storage = $this->entityTypeManager->getStorage('node');
    $nodes = $storage->loadByProperties([
      'type' => 'article',
      'status' => 1,
    ]);
    $terms = $this->entityTypeManager->getStorage('taxonomy_term')->loadByProperties([
      'vid' => 'vocabulary_name',
    ]);
  }
}    
```
## Query

 > **Tips** : Get the entity query from storage is the best practice.

```php
$storage = $this->entityTypeManager->getStorage('node');
/** @var \Drupal\Core\Entity\Query\QueryInterface $query */
$query = $storage->getQuery();
// Condition operators are : =, <>, >, >=, <, <=, STARTS_WITH, CONTAINS, ENDS_WITH, IN, NOT IN, BETWEEN.
$query->condition('field_tags', $tag, 'IN');
// Sort parameters are : field, direction, langcode.
$query->sort('field_name', 'ASC');
// Count.
$query->count();
// Get entities IDs from request results.
$nids = $query->execute();
// Load results.
$storage->loadMultiple($nids);
```

## API links

 - [EntityTypeManagerInterface](https://api.drupal.org/api/drupal/core%21lib%21Drupal%21Core%21Entity%21EntityTypeManagerInterface.php/interface/EntityTypeManagerInterface/8.2.x)
 - [EntityStorageInterface](https://api.drupal.org/api/drupal/core%21lib%21Drupal%21Core%21Entity%21EntityStorageInterface.php/interface/EntityStorageInterface/9.0.x)
 - [QueryInterface](https://api.drupal.org/api/drupal/core%21lib%21Drupal%21Core%21Entity%21Query%21QueryInterface.php/interface/QueryInterface/9.0.x)

