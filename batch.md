# Create a Drupal Batch

```php
<?php

namespace Drupal\my_module\Form;

use Drupal\Core\Form\FormBase;
use Drupal\Core\Form\FormStateInterface;
use Drupal\my_module\Service\MyService;
use Symfony\Component\DependencyInjection\ContainerInterface;

/**
 * Batch form.
 */
class BatchForm extends FormBase {

  /**
   * My custom service.
   *
   * @var \Drupal\my_module\Service\MyService
   */
  protected $myService;

  /**
   * Constructor.
   */
  public function __construct(
    MyService $myService,
  ) {
    $this->myService = $myService;
  }

  /**
   * {@inheritdoc}
   */
  public static function create(ContainerInterface $container) {
    return new static(
      $container->get('my_module.my_service'),
    );
  }

  /**
   * {@inheritdoc}
   */
  public function getFormId() {
    return 'my_module_batch_form';
  }

  /**
   * {@inheritdoc}
   */
  public function buildForm(array $form, FormStateInterface $form_state) {

    // Fieldset.
    $form['force'] = [
      '#type' => 'fieldset',
      '#title' => $this->t('Fieldset', [], ['context' => 'My module custom']),
    ];

    $form['force']['is_force'] = [
      '#type' => 'checkbox',
      '#title' => $this->t('Force mode', [], ['context' => 'My module custom']),
      '#default_value' => $form_state->getValue('is_force'),
    ];

    // Submit.
    $form['actions']['submit'] = [
      '#type' => 'submit',
      '#value' => $this->t('Start Batch Process', [], ['context' => 'My module custom']),
      '#button_type' => 'primary',
    ];

    return $form;
  }

  /**
   * {@inheritdoc}
   */
  public function validateForm(array &$form, FormStateInterface $form_state) {
    // Force mode.
    if ((bool) $form_state->getValue('is_force') === TRUE) {
      $form_state->setErrorByName(
        'is_force',
        $this->t('Uncheck the "Force mode" to start the batch.', [], ['context' => 'My module custom'])
      );
    }
  }

  /**
   * {@inheritdoc}
   */
  public function submitForm(array &$form, FormStateInterface $form_state) {
    // Get nodes to process.
    $nodes = $this->myService->getNodes($form_state);

    // Build a batch.
    $operations = [];
    foreach ($nodes as $node) {
      if (
        $node instanceof NodeInterface === FALSE
      ) {
        continue;
      }
      $operations[] = [
        [self::class, 'processItem'],
        [
          $node, $this->myService
        ],
      ];
    }
    $batch = [
      'title' => $this->t('Updating nodes...', [], ['context' => 'My module custom']),
      'operations' => $operations,
      'finished' => [self::class, 'batchFinished'],
      'init_message' => $this->t('Batch is starting...', [], ['context' => 'My module custom']),
      'progress_message' => $this->t('Processed @current out of @total.', [], ['context' => 'My module custom']),
      'error_message' => $this->t('The batch has encountered an error.', [], ['context' => 'My module custom']),
    ];

    // Start the batch process.
    batch_set($batch);
  }

  /**
   * Process batch item.
   */
  public static function processItem($node, $myService, array &$context) {
    // Batch context update.
    $nid = $node->id();
    $context['results'][] = $nid;

    $message = sprintf('Update "%s" (%s)', $node->getTitle(), $nid);
    $context['message'] = $message;

    // Update the node.
    try {
      if ($myService->isNodeUpdateNeeded($node) === TRUE) {
        \Drupal::logger('my_module')->notice($message);

        $node = $myService->updateNode($node);
        $node->save();
      }
    }
    catch (Exception $e) {
      $context['message'] = sprintf(
        'Error while updating node %s : %s',
        $node->id(),
        $e->getMessage()
      );
    }
  }

  /**
   * Batch callback.
   *
   * @param bool $success
   *   Flag for success.
   * @param array $results
   *   Batch results.
   * @param array $operations
   *   Batch operations.
   */
  public static function batchFinished($success, array $results, array $operations) {
    $messenger = \Drupal::messenger();
    if ($success) {
      $messenger->addStatus(
        t('Batch completed successfully.', [], ['context' => 'My module custom'])
      );
    }
    else {
      $messenger->addError(
        t('Batch encountered errors.', [], ['context' => 'My module custom'])
      );
    }
  }

}

```
