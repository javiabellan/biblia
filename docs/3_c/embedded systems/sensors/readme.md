


# Sensors


## Current

5V como de 3.3V. Si tu Arduino es de 5V no debería tener ningún problema para leer la señal de senbsores de 3.3V, ya cualquier tensión que sobre pase 2.5V es leído como HIGH en Arduino.


## Kalman filter



--------------------------------


## Image

- Stereo
- Visión nocturna
- Ultrawide
- With autofocus
- Multisctrum
- Thermal Imaging


## Sound

- Microphone



## Velocity

Radar sensors using the doppler effect


## Distance

Returns an analog value with the distance.

|                             | Ultrasonic (sonar)   | IR triangulation | LiDAR    | ToF (Time of Flight) | Radar
|-----------------------------|-----------------------------------------|--------------
| Emits and recives           | High-frequency sound | Infrared light   | UV light |
| Detects tranparent surfaces |        yes 🙂        | No 🙁           | No 🙁    |
| Safe for human eyes         |        yes 🙂        |           | No 🙁    |
| Invariant to dust           |        yes 🙂
| Invariant to temperature    |        yes 🙂
| Invariant to light          |        yes 🙂
| Max range                   |        ~10m          |
| Application                 | Slow & near objects  |


https://www.terabee.com/choosing-right-distance-sensor-your-application/


| Technology | Sensor     | Range       | Angle | Voltage | Current | Price
|------------|------------|-------------|-------|---------|---------|-----
| Ultrasound | HC-SR04    | 2cm - 400cm |       | 5V      | 15mA    | 1,80 €
| Ultrasound | Grove      | 3cm – 350cm |       | 3.3V/5V | 8mA     |
| Infrared   |            | 2cm - 30cm  |  35°  |         |         |      
| Infrared   | GP2Y0A21YK | 10cm - 80cm |                           | 10€



## External Movement/Presence sensor

Returns a boolean value if the presence of an objects appears.

| Sensor                        | Emmiter  | Detector | Application            | Price |
|-------------------------------|----------|----------|------------------------|-------|
| PIR sensor (Pasive InfraRed)  | No       | Infrared | Room presence          | 0,80€ |
| IR sensor                     | Infrared | Infrared |                        |       |
| Magnetic (Reed Switch)        | Magnetic | Magnetic | The door is open/close |       |
| Magnetic (Hall effect)        | No       | Magnetic | Magnetometer           |       |
| Optical sensor (Transmissive) | Light    | Light    | Sensor puerta ascensor |       |
| Optical sensor (Reflective)   | Light    | Light    | Sensor puerta ascensor |       |


## Internal Movement sensor (aka IMU)

- Vibration sensor
- Tilt sensor
- 3-axis Accelerometer
- 3-axis Gyroscope
- 3-axis Magnetometer (aka Compass)      
- Wheel-speed sensor


| Chip              | Sensors                  | Price | Note
|-------------------|--------------------------|-------|------
| MPU-6050          | 3D Acc + 3D Gyr          | 5€    |
| HMC5883L / GY-271 | 3D Mag                   |       |
| LSM9DS1           | 3D Acc + 3D Gyr + 3D Mag | 20€   | Incluido en Arduino Nano 33 BLE Sense)


## Navigation

- GPS

## Force & Presure
- car Seat
- Sensor de peatones
- Peso (balanza)

## Manual interface

- Rotary Encoder Module
- Joystic
- Button

## Biometrics

- Muscle Sensor
- Pulse Oximeter
- Heart Rate Sensor
- Fingerprint Scanner
- car seat occupancy sensor
- PULSÍMETRO Y OXÍMETRO CON ARDUINO Y MAX30102

## Gas

| Sensor | Detects                               | Heater Voltage      |
|--------|---------------------------------------|---------------------|
| MQ-2   | Methane, Butane, LPG, smoke           | 5V
| MQ-3   | Alcohol, Ethanol, smoke               | 5V
| MQ-4   | Methane, CNG Gas                      | 5V
| MQ-5   | Natural gas, LPG                      | 5V
| MQ-6   | LPG, butane gas                       | 5V
| MQ-7   | Carbon Monoxide                       | Alternating 5V and 1.4V
| MQ-8   | Hydrogen Gas                          | 5V
| MQ-9   | Carbon Monoxide, flammable gasses.    | Alternating 5V and 1.4V
| MQ131  | Ozone                                 | 6V
| MQ135  | Air Quality (Benzene, Alcohol, smoke) | 5V
| MQ136  | Hydrogen Sulfide gas                  | 5V
| MQ137  | Ammonia                               | 5V
| MQ138  | Benzene, Toluene, Alcohol, Acetone, Propane, Formaldehyde gas, Hydrogen   | 5V
| MQ214  | Methane, Natural gas                  | 6V
| MQ216  | Natural gas, Coal gas                 | 5V
| MQ303A | Alcohol, Ethanol, smoke               | 0.9V
| MQ306A | LPG, butane gas                       | 0.9V
| MQ307A | Carbon Monoxide                       | Alternating 0.2V and 0.9V.
| MQ309A | Carbon Monoxide, flammable gasses     | Alternating 0.2V and 0.9V
| MG811  | Carbon Dioxide (CO2)                  | 6V
| AQ-104 | Air quality                           | -


## Soil

- soil moisture sensor


## Weather

- Temerature
- Humity
- pressure sensor

|            | Sensor          | Example
|------------|---------------------
| Light      | Photoresistor   |
| Temerature | Thermal sensor  | TMP36 [40°C...+125°] 0.1°C resolution
| Humidity   |                 | DHT11 
| Presure    | Barometer       | BMP180 (5€)
| Flame      | Flame IR sensor | KY-026 (detects wavelengths ranging from 760nm to 1100nm in the infrared spectrum)
| Raindrop   | Raindrop Sensor | 
| CO2 sensor
| Wind




















