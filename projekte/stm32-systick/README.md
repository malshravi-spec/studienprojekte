# STM32-Labor – SysTick und GPIO

Die erste Teilaufgabe aus Labor 6 nutzt den SysTick-Zähler für eine Millisekunden-Wartefunktion. Die LEDs werden direkt über die GPIO-Register angesteuert.

Das Projekt lässt sich in STM32CubeIDE als bestehendes Eclipse-Projekt importieren. Das Zielgerät steht in der .ioc-Datei. Der Einstiegspunkt ist **Core/Src/main.c**. Die Lizenzdateien zu den ST-Treibern liegen in **Drivers**.
