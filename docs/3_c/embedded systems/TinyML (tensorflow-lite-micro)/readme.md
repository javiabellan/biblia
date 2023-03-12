
# Introduction

TensorFlow Lite for Microcontrollers is written in **C++ 11** and requires a **32-bit platform**. It has been tested extensively with many processors based on the Arm Cortex-M Series architecture, and has been ported to other architectures including ESP32.




## STEP 1: Train a model

Train a small TensorFlow model that can fit your target device and contains supported operations.

> Note if you are going to apply post-training quantization later, you can also apply **quantization aware training** in this step.



## STEP 2: [Convert to TensorFlow Lite](https://www.tensorflow.org/lite/convert)

Convert to a TensorFlow Lite model using the TensorFlow Lite converter.

By default, the weights and biases in a model are stored as 32-bit floating-point numbers (there is no quantization)

```python
converter    = tf.lite.TFLiteConverter.from_keras_model(my_keras_model)    # OPTION A
converter    = tf.lite.TFLiteConverter.from_saved_model(saved_model_path)  # OPTION B
tflite_model = converter.convert()
open("my_model_float32.tflite", "wb").write(tflite_model) # Save the model to disk
```

Convert the model with Full integer quantization. (4x smaller, 3x+ speedup)

```python
def representative_dataset():
  for i in range(500):
    yield([x_train[i].reshape(1, 1)])

converter.optimizations             = [tf.lite.Optimize.DEFAULT] # Set the optimization flag.
converter.target_spec.supported_ops = [tf.lite.OpsSet.TFLITE_BUILTINS_INT8] 
converter.inference_input_type      = tf.int8
converter.inference_output_type     = tf.int8
converter.representative_dataset    = representative_dataset # Provide a representative dataset to ensure we quantize correctly.

tflite_model = converter.convert()
open("my_model_int8.tflite", "wb").write(tflite_model) # Save the model to disk
```


### 3. Convert to TensorFlow Micro

Convert to a C byte array using standard tools to store it in a read-only program memory on device.


```python

MODEL_TFLITE = "my_model_int8.tflite"
MODEL_MICRO  = "my_model_int8.cc"

# Convert to a C source file, i.e, a TensorFlow Lite for Microcontrollers model
#!xxd -i my_model_int8.tflite > my_model_int8.cc
!xxd -i {MODEL_TFLITE} > {MODEL_MICRO}

# Update variable names
REPLACE_TEXT = MODEL_TFLITE.replace('/', '_').replace('.', '_')
!sed -i 's/'{REPLACE_TEXT}'/g_model/g' {MODEL_MICRO}
```


## 4. Inference on c++11

Run inference on device using the C++ library and process the results.


```c++
// 1. Include the library headers
#include <math.h>
#include "tensorflow/lite/micro/all_ops_resolver.h"     // provides the operations used by the interpreter to run the model.
#include "tensorflow/lite/micro/micro_error_reporter.h" // outputs debug information.
#include "tensorflow/lite/micro/micro_interpreter.h"    // contains code to load and run models.
#include "tensorflow/lite/micro/testing/micro_test.h"
#include "tensorflow/lite/schema/schema_generated.h"    // contains the schema for the TensorFlow Lite FlatBuffer model file format.

// 2. Include the model header
#include "tensorflow/lite/micro/examples/hello_world/hello_world_model_data.h"


////////////////////////////////////// 3. Include the unit test framework header
TF_LITE_MICRO_TESTS_BEGIN

TF_LITE_MICRO_TEST(LoadModelAndPerformInference) {
  // Define the input and the expected output
  float x = 0.0f;
  float y_true = sin(x);

  // Set up logging
  tflite::MicroErrorReporter micro_error_reporter;

  // Map the model into a usable data structure. This doesn't involve any
  // copying or parsing, it's a very lightweight operation.
  const tflite::Model* model = ::tflite::GetModel(g_hello_world_model_data);
  if (model->version() != TFLITE_SCHEMA_VERSION) {
    TF_LITE_REPORT_ERROR(&micro_error_reporter,
                         "Model provided is schema version %d not equal "
                         "to supported version %d.\n",
                         model->version(), TFLITE_SCHEMA_VERSION);
  }

  // This pulls in all the operation implementations we need
  tflite::AllOpsResolver resolver;

  constexpr int kTensorArenaSize = 2000;
  uint8_t tensor_arena[kTensorArenaSize];

  // Build an interpreter to run the model with
  tflite::MicroInterpreter interpreter(model, resolver, tensor_arena,
                                       kTensorArenaSize, &micro_error_reporter);
  // Allocate memory from the tensor_arena for the model's tensors
  TF_LITE_MICRO_EXPECT_EQ(interpreter.AllocateTensors(), kTfLiteOk);

  // Obtain a pointer to the model's input tensor
  TfLiteTensor* input = interpreter.input(0);

  // Make sure the input has the properties we expect
  TF_LITE_MICRO_EXPECT_NE(nullptr, input);
  // The property "dims" tells us the tensor's shape. It has one element for
  // each dimension. Our input is a 2D tensor containing 1 element, so "dims"
  // should have size 2.
  TF_LITE_MICRO_EXPECT_EQ(2, input->dims->size);
  // The value of each element gives the length of the corresponding tensor.
  // We should expect two single element tensors (one is contained within the
  // other).
  TF_LITE_MICRO_EXPECT_EQ(1, input->dims->data[0]);
  TF_LITE_MICRO_EXPECT_EQ(1, input->dims->data[1]);
  // The input is an 8 bit integer value
  TF_LITE_MICRO_EXPECT_EQ(kTfLiteInt8, input->type);

  // Get the input quantization parameters
  float input_scale = input->params.scale;
  int input_zero_point = input->params.zero_point;

  // Quantize the input from floating-point to integer
  int8_t x_quantized = x / input_scale + input_zero_point;
  // Place the quantized input in the model's input tensor
  input->data.int8[0] = x_quantized;

  // Run the model and check that it succeeds
  TfLiteStatus invoke_status = interpreter.Invoke();
  TF_LITE_MICRO_EXPECT_EQ(kTfLiteOk, invoke_status);

  // Obtain a pointer to the output tensor and make sure it has the
  // properties we expect. It should be the same as the input tensor.
  TfLiteTensor* output = interpreter.output(0);
  TF_LITE_MICRO_EXPECT_EQ(2, output->dims->size);
  TF_LITE_MICRO_EXPECT_EQ(1, output->dims->data[0]);
  TF_LITE_MICRO_EXPECT_EQ(1, output->dims->data[1]);
  TF_LITE_MICRO_EXPECT_EQ(kTfLiteInt8, output->type);

  // Get the output quantization parameters
  float output_scale = output->params.scale;
  int output_zero_point = output->params.zero_point;

  // Obtain the quantized output from model's output tensor
  int8_t y_pred_quantized = output->data.int8[0];
  // Dequantize the output from integer to floating-point
  float y_pred = (y_pred_quantized - output_zero_point) * output_scale;

  // Check if the output is within a small range of the expected output
  float epsilon = 0.05f;
  TF_LITE_MICRO_EXPECT_NEAR(y_true, y_pred, epsilon);

  // Run inference on several more values and confirm the expected outputs
  x = 1.f;
  y_true = sin(x);
  input->data.int8[0] = x / input_scale + input_zero_point;
  interpreter.Invoke();
  y_pred = (output->data.int8[0] - output_zero_point) * output_scale;
  TF_LITE_MICRO_EXPECT_NEAR(y_true, y_pred, epsilon);

  x = 3.f;
  y_true = sin(x);
  input->data.int8[0] = x / input_scale + input_zero_point;
  interpreter.Invoke();
  y_pred = (output->data.int8[0] - output_zero_point) * output_scale;
  TF_LITE_MICRO_EXPECT_NEAR(y_true, y_pred, epsilon);

  x = 5.f;
  y_true = sin(x);
  input->data.int8[0] = x / input_scale + input_zero_point;
  interpreter.Invoke();
  y_pred = (output->data.int8[0] - output_zero_point) * output_scale;
  TF_LITE_MICRO_EXPECT_NEAR(y_true, y_pred, epsilon);
}

TF_LITE_MICRO_TESTS_END
```

## Reference

- https://www.tensorflow.org/lite/microcontrollers/get_started_low_level
- https://github.com/Benja1972/TinyML_arduino