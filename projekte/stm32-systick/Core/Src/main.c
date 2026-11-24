#include "stm32f4xx.h"
void delay_ms(uint16_t n){
	// Register LOAD wird mit 16000 Takten initialisiert (umgerechnet 1 ms) und aktueller Wert des Counters mit 0 initialisiert.
	// CTRL-Register wird bestimmt mit 0x5 also 101;CLKSOURCE auf 1 und ENABLE auf 1
	// Die while-Schleife wird so lange durchlaufen bis der LOAD-Wert 0 erreicht, dann wird COUNTFLAG vom CTRL-Register gesetzt
	// Nach Durchlaufen der for-Schleife wird abschließend der Counter deaktiviert
	int i;

	SysTick->LOAD = 16000; // LOAD-Register: Startwert, dass in den VAL-Register geladen wird

	SysTick->VAL = 0;    // VAL-Register: enthält den aktuellen Wert des Counters
	SysTick->CTRL = 0x5; // CTRL-Register: aktiviert die SysTick-Funktionen; aktiviert Counter und nimmt vom Prozessortakt

	for (i = 0; i < n; i++)
	{
		while((SysTick->CTRL & 0x10000) == 0)
	    {    }
	}

	SysTick->CTRL = 0;
}

int main(void)
{
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIOGEN;

	GPIOG->MODER &=~ GPIO_MODER_MODER10_1;
	GPIOG->MODER |= GPIO_MODER_MODER10_0;
	GPIOG->MODER &=~ GPIO_MODER_MODER7_1;
	GPIOG->MODER |= GPIO_MODER_MODER7_0;
	GPIOG->MODER &=~ GPIO_MODER_MODER6_1;
	GPIOG->MODER |= GPIO_MODER_MODER6_0;

	GPIOG->ODR |= GPIO_ODR_OD10;
	GPIOG->ODR |= GPIO_ODR_OD7;
	GPIOG->ODR |= GPIO_ODR_OD6;


	while(1)
	{
		GPIOG->ODR &=~ GPIO_ODR_OD10; // LED anschalten
		delay_ms(3000);
		GPIOG->ODR &=~ GPIO_ODR_OD7;
		delay_ms(1000);
		GPIOG->ODR |= GPIO_ODR_OD10; // LED ausschalten
		GPIOG->ODR |= GPIO_ODR_OD7;
		GPIOG->ODR &=~ GPIO_ODR_OD6; // LED anschalten
		delay_ms(3000);
		GPIOG->ODR |= GPIO_ODR_OD6;
		GPIOG->ODR &=~ GPIO_ODR_OD7;
		delay_ms(1000);
		GPIOG->ODR |= GPIO_ODR_OD7; // LED ausschalten


	}
}
