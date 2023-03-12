// YOUTUBE VIDEO: https://youtu.be/9Zyp4sdSUNM

#include <avr/io.h>
#include <util/delay.h>
#include <stdbool.h>

/*

ARDUINO PINS

B0 = digital pin 8
B1 = digital pin 9
B2 = digital pin 10
B3 = digital pin 11
B4 = digital pin 12
B5 = digital pin 13
B6 = reserved for crystal, don't use
B7 = reserved for crystal, don't use

C0 = analog pin 0
C1 = analog pin 1
C2 = analog pin 2
C3 = analog pin 3
C4 = analog pin 4
C5 = analog pin 5
C6 = analog pin 6, only on Croduino Basic, Basic2 and Arduino nano
C7 = analog pin 7, only on Croduino Basic, Basic2 and Arduino nano

D0 = digital pin 0, used for serial communication, use is not recommended
D1 = digital pin 1, used for serial communication, use is not recommended
D2 = digital pin 2
D3 = digital pin 3
D4 = digital pin 4
D5 = digital pin 5
D6 = digital pin 6
D7 = digital pin 7
*/


#define BLINK_MS 150

int main()
{
	// Setup code goes here

	// Put pin 13 (= B5) into output mode
	// (We do that by writing into a control register)
	// DDBR register: Pin modes for port B
	//
	//          *
	//        BBBBBBBB
	//        76543210
	DDRB |= 0b00100000;


	while(true)
	{
		// Infinite loop code goes here

		  PORTB |= 0b00100000; // Turn on LED
		  delay(1000);
		  PORTB &= ~0b00100000; // Turn off LED
		  delay(1000);

	}
	return 0;
}