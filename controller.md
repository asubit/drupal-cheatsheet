# Drupal custom controller

## Route definition

my_module.routing.yml

```yml
my_module.custom_page:
  path: '/custom-page'
  defaults:
    _controller: '\Drupal\my_module\Controller\DefaultController::page'
    _title: 'Web browser tab title'
  requirements:
    _permission: 'access content'
```

## Controller definition

src/Controller/DefaultController.php

```php
<?php

namespace Drupal\my_module\Controller;

use Drupal\my_module\Dependency;
use Drupal\Core\Controller\ControllerBase;
use Drupal\Core\StringTranslation\StringTranslationTrait;
use Symfony\Component\DependencyInjection\ContainerInterface;

/**
 * Default controller.
 */
class DefaultController extends ControllerBase {
    
  use StringTranslationTrait;

  /**
   * Dependency.
   *
   * @var \Drupal\my_module\Dependency
   */
  protected $dependency;

  /**
   * Constructor.
   */
  public function __construct(Dependency $dependency) {
    $this->dependency = $dependency;
  }

  /**
   * Dependencies injection.
   */
  public static function create(ContainerInterface $container) {
    return new static($container->get('my_module.service_name'));
  }

  /**
   * Custom page.
   */
  public function page() {
    return array(
      '#theme' => 'page_theme',// Define in my_module.module file
      '#var_1' => $var_1,
      '#var_2' => $var_2,
    );
  }
```

## Template definition

my_module.module

```php
/**
 * Implements hook_theme().
 */
function my_module_theme($existing, $type, $theme, $path) {

  return [
    'page_theme' => [
      'template' => 'page',
      'path' => $path . '/templates',
      'variables' => [
        'var_1' => NULL,
        'var_2' => NULL,
      ],
    ],
```

templates/page.html.twig
```twig
<h1>{{ var_1 }}</h1>
<p>{{ "Lorem ipsum @var_2"|t({'@var_2' => var_2}, {'context' => 'My module context'}) }}</p>
```
