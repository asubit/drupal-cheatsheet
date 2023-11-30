# HTTP Client

my_module.services.yml
```yml
services:
  hello.service:
    class: \Drupal\my_module\Service\Hello
    arguments:
      - '@http_client'
```

Hello.php
```php
...
use GuzzleHttp\ClientInterface;
use GuzzleHttp\Exception\RequestException;
...
class Hello {
  
  /**
   * Client interface.
   *
   * @var \GuzzleHttp\ClientInterface
   */
  protected $httpClient;
  
  /**
   * {@inheritdoc}
   */
  public function __construct(ClientInterface $httpClient) {
    $this->httpClient = $httpClient;
  }
  
  public function something() {
    try {
      $response = $this->httpClient->get(
        'https://api.domain.com',
        [
          'headers' => [
            'Accept' => 'application/json',
            'Content-Type' => 'application/json',
          ]
        ]
      );
      return json_decode((string)$response->getBody(), TRUE);
    } catch (RequestException $e) {
      $logger = $this->loggerFactory->get('my_module');
      $logger->error($e->getMessage());
      $logger->error($e->getTraceAsString());
      return [];
    }
  }
}
```

## API links

 - [Client](https://github.com/guzzle/guzzle/blob/master/src/Client.php)
 - [ClientInterface](https://github.com/guzzle/guzzle/blob/master/src/ClientInterface.php)
 - [ClientTrait](https://github.com/guzzle/guzzle/blob/master/src/ClientTrait.php)
