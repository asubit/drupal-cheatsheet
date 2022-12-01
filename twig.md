# Twig

## Node

```twig
{{ path('entity.node.canonical', {'node': node.id}) }}
{{ node.id }}
{{ node.bundle }}
{{ node.title.value }}
{{ node.title.value|clean_id }}
{{ node.field_name.value }}
{{ node.field_entity_reference.entity.field_name.value }}

```

## Term

```twig
{{ term.name.value }}
```

## Media

```twig
{% set media = node.field_media.entity %}
{{ file_url(media.field_media_image.entity.fileuri) }}
{{ media.field_media_image.entity.alt }}
```

## Translation

```twig
{% if node.hastranslation(language) %}
  {% set article = alert.translation(language) %}
```

## Address

```twig
{% for item in items %}
  <p class="address" translate="no">
  {% if item.content.given_name['#value'] or item.content.family_name['#value'] %}
    {{ item.content.given_name }} {{ item.content.family_name }} <br>
  {% endif %}
  {% if item.content.organization['#value'] %}
    {{ item.content.organization }} <br>
  {% endif %}
  {% if item.content.address_line1['#value'] %}
    {{ item.content.address_line1 }} <br>
  {% endif %}
  {% if item.content.address_line2['#value'] %}
    {{ item.content.address_line2 }} <br>
  {% endif %}
  {% if item.content.dependent_locality['#value'] %}
    {{ item.content.dependent_locality }} <br>
  {% endif %}
  {% if item.content.locality['#value'] or item.content.postal_code['#value'] or item.content.administrative_area['#value'] %}
    {{ item.content.postal_code }} {{ item.content.locality }} {{ item.content.administrative_area }} <br>
  {% endif %}
</p>
{% endfor %}
```

## Include

 > **Tips** : Wherever possible, avoid using template inclusions as this degrades performance.

```twig
{% include '@THEME_NAME/includes/header.html.twig' with {'var': var} %}
```

## Custom Twig extension

src/Twig/CountEntityExtension.php
```twig
<?php

namespace Drupal\my_module\Twig;

use Drupal\Core\Entity\EntityTypeManagerInterface;

/**
 * Class CountEntitiesExtension.
 *
 * @package Drupal\my_module\Twig
 */
class CountEntitiesExtension extends \Twig_Extension {

  /**
   * Entity type manager.
   *
   * @var \Drupal\Core\Entity\EntityTypeManagerInterface
   */
  protected $entityTypeManager;

  /**
   * ConvertExtension constructor.
   */
  public function __construct(EntityTypeManagerInterface $entityTypeManager) {
    $this->entityTypeManager = $entityTypeManager;
  }

  /**
   * {@inheritdoc}
   */
  public function getFunctions() {
    return [
      new \Twig_SimpleFunction('count_entities', [$this, 'countEntities'])
    ];
  }

  /**
   * {@inheritdoc}
   */
  public function countEntities($storage, $bundle) {
    $query = $this->entityTypeManager->getStorage($storage)->getQuery();
    return $query
      ->condition('type', $bundle)
      ->condition('status', 1)
      ->count();
  }

}
```

And then in a Twig template :

```twig
{{ count_entities('node', 'article') }}
```

 > **Tips** : The line `new \Twig_SimpleFunction('count_entities', [$this, 'countEntities'])` can use another class like a custom service instead of `$this` to call another function.

