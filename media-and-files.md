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

# Files

## Static call

```php
\Drupal::service('file_url_generator')
```

## Dependencies injection

```php
use Drupal\Core\File\FileUrlGenerator;

class Something {

  /**
   * File URL generator.
   *
   * @var \Drupal\Core\File\FileUrlGenerator
   */
  protected $fileUrlGenerator;

  public function __construct(FileUrlGenerator $fileUrlGenerator) {
    $this->$fileUrlGenerator = $fileUrlGenerator;
  }

  public function getMediaImageAbsoluteUrl($media) {
    $file = File::load($media->field_media_image[0]->getValue()['target_id']);
    $fileAbsoluteUrl = $this->$fileUrlGenerator->generateAbsoluteString($file->getFileUri());
    return $fileAbsoluteUrl;
  }

}
```

 > [API FileUrlGenrator](https://api.drupal.org/api/drupal/core%21lib%21Drupal%21Core%21File%21FileUrlGenerator.php/class/FileUrlGenerator/10)
