# Drupal cache

## Static call

```php
function getFromCache() {
  $cache = \Drupal::cache();
  $cid = 'thing:identifier';
  $data = NULL;

  $something_cache = $cache->get($cid);

  if ($something_cache) {
    $data = $something_cache->data;
  }
  else {
    $data = my_module_complicated_calculation();
    $cache->set($cid, $data);
  }
}

function invalidateCacheTags() {
  \Drupal::service('cache_tags.invalidator')->invalidateTags(['node_list:article']);
}
```

## Dependency injection call

my_module.services.yml

```yml
services:
  hello.service:
    class: \Drupal\my_module\Service\Hello
    arguments:
      - '@cache.default'
      - '@cache_tags.invalidator'
```

Hello.php

```php
...
use Drupal\Core\Cache\Cache;
use Drupal\Core\Cache\CacheBackendInterface;
use Drupal\Core\Cache\CacheTagsInvalidator;
...
class Hello {

 /**
   * Cache backend.
   *
   * @var Drupal\Core\Cache\CacheBackendInterface
   */
  protected $cacheBackend;

 /**
   * Cache tags invalidator.
   *
   * @var Drupal\Core\Cache\CacheTagsInvalidator
   */
  protected $cacheInvalidator;

  /**
   * {@inheritdoc}
   */
  public function __construct(
    CacheBackendInterface $cacheBackend,
    CacheTagsInvalidator $cacheInvalidator
  ) {
    $this->cacheBackend = $cacheBackend;
    $this->cacheInvalidator = $cacheInvalidator;
  }
  
  /**
   * Function getting something from cache.
   */
  public function getSomething() {
    $cid = 'thing:identifier';
    $data = NULL;

    $cache = $this->cacheBackend->get($cid);

    if ($cache) {
      $data = $cache->data;
    }
    else {
      $data = my_module_complicated_calculation();
      $this->cacheBackend->set($cid, $data, Cache::PERMANENT, ['node:5', 'user:7']);
    }
    return $data;
  }
  
  /**
   * Function invalidating a cache tag.
   */
  public function invalidateSomething() {
    $cid = 'thing:identifier';
    $this->cacheInvalidator->invalidateTags([$cid]);
    return;
  }
}    
```

## Links

 - [Cache.php](https://api.drupal.org/api/drupal/core%21lib%21Drupal%21Core%21Cache%21Cache.php/class/Cache/9.1.x)
 - [Cache tags docs](https://www.drupal.org/docs/drupal-apis/cache-api/cache-tags)
 - [Cacheability of render arrays](https://www.drupal.org/developing/api/8/render/arrays/cacheability)
 - [Cache context](https://www.drupal.org/developing/api/8/cache/contexts)
 - [Cache max-age](https://www.drupal.org/developing/api/8/cache/max-age)
