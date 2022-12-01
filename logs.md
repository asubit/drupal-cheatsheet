# Logs

## Read

See logs in shell :

```shell
drush ws --tail
```

See logs in admin (/admin/reports/dblog):

```shell
drush en dblog
```

See logs in docker :
```shell
docker logs container_apache_name --tail 100
```

## Write

Fast and ugly way [public static function Drupal::logger](https://api.drupal.org/api/drupal/core%21lib%21Drupal.php/function/Drupal%3A%3Alogger/8.2.x) :
```php
\Drupal::logger('my_module')->notice('<pre><code>' . print_r($variables['items'], TRUE) . '</code></pre>' );
```

Good way, using dependency injection and [LoggerInterface](https://api.drupal.org/api/drupal/vendor%21psr%21log%21Psr%21Log%21LoggerInterface.php/interface/LoggerInterface/8.2.x) :

my_module.services.yml
```yml
services:
  hello.service:
    class: \Drupal\my_module\Service\Hello
    arguments:
      - '@logger.factory'
```

Hello.php
```php
...
use Drupal\Core\Logger\LoggerChannelFactoryInterface;
...
class Hello {

  /**
   * Logger factory.
   *
   * @var \Drupal\Core\Logger\LoggerChannelFactoryInterface
   */
  protected $loggerFactory;

  /**
   * {@inheritdoc}
   */
  public function __construct(LoggerChannelFactoryInterface $loggerFactory) {
    $this->loggerFactory = $loggerFactory;
  }
  
  /**
   * Function doing something with Logger.
   */
  public function something() {
    /** @var \Psr\Log\LoggerInterface $logger */
    $logger = $this->loggerFactory->get('my_module');
    // Action must be taken immediately.
    $logger->alert('...');
    // Critical conditions.
    $logger->critical('...');
    // Detailed debug information.
    $logger->debug('...');
    // System is unusable.
    $logger->emergency('...');
    // Runtime errors that do not require immediate action but should typically be logged and monitored.
    $logger->error('...');
    // Interesting events.
    $logger->info('...');
    // Logs with an arbitrary level.
    $logger->log('...');
    // Normal but significant events.
    $logger->notice('...');
    // Exceptional occurrences that are not errors.
    $logger->warning('...');
  }
}
```
