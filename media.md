# Media

## Get media image informations

```php
use Drupal\file\Entity\File;

$media = $node->field_media->entity;
$file = $media->field_media_image->entity;

$alt = $file->alt;
$uri = $file->fileuri;
$url = $file->createFileUrl();
```
