<h1 align="center">Arduino</h1>


### Main functions

setup() and loop() functions are called automatically by the Arduino environment



### Pins

|         |     Input | Output
|-------------------------------
| Digital |
| Analog  |             `analogWrite(LED_BUILTIN, brightness); (PWM)`

To dim our built-in LED, we can use a technique called pulse width modulation (PWM). If we switch an output pin on and off extremely rapidly, the pin’s output voltage becomes a factor of the ratio between time spent in the off and on states. If the pin spends 50% of the time in each state, its output voltage will be 50% of its maxi‐ mum. If it spends 75% in the on state and 25% in the off state, its voltage will be 75% of its maximum.

