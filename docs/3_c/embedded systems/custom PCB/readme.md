<h1 align="center">Custom PCB</h1>


You not use Arduino (or other development board) as a final product. You need something more compact and solid to use in production. Thats the motivation to design your own PCB (Printed Circuit Board).


## Steps


1. Pick up the program
   - **gEDA**: es una suite de programas de código abierto para el diseño de esquemas eléctricos y circuitos impresos.
     - **gschem**: un editor gráfico para el diseño de los esquemas eléctricos;
     - **pcb**: la herramienta para el enrutamiento de las pistas y para el diseño del
circuito impreso;
     - **gerbv**: un visor para analizar los archivos de producción (standard
gerber);
     - **xgsch2pcb**: una interfaz gráfica para la gestión de los proyectos;
     - **Icarus y gtkwave**: dos programas para llevar a cabo simulaciones sobre
circuitos y visualizar los resultados.
   - **Eagle**: Similar to gEDA. free or cheap $ (Used by Jacob Sorber) [Eagle tutorials on sparkfun](https://www.sparkfun.com/search/results?term=eagle#tutorials)
     - La versión gratuita tiene un área de trabajo limitada a 10 x 15 cm.
   - **KiCad**: Open source (Used by @info_libertas)
   - **Fritzing**: un programa de código abierto muy intuitivo con el cual es posible trabajar en placas de prueba, esquemas eléctricos y diseños finales.
   - **123D Circuits**: es un programa de Autodesk que se utiliza online para diseñar y simular circuitos.
   - **Altium**: $$$ expensive
   - **EasyEDA**:
2. Design the schematic
   - Here you define the logic and connectivity of your circuit.
3. Design the layout
   - Here you design the actual shape, size and paths of your circuit.
4. Export to a known format
   - El formato estándar que aceptan las fábricas es el Gerber (se ven con: gerbv, kicad, etc.)
5. Pick up the manufacter and order your PCB
   - [JLCPCB](http://jlcpcb.com) (Used by @info_libertas)
   - [PCBWay](http://pcbway.com) (Used by @info_libertas)
      - They have open source projects: http://pcbway.com/project 
   - NextPCB (sponsored by Jacob Sorber)
6. Assamble your PCB with some SMDs (Soldar los chips a la placa)
   - @info_libertas: JBC CD-2SB + andonstar ADSM 201 (ambos descatalogados, ahora habrá mejores) + flux + trenza + paciencia



## Glosary

- **PCB**: **P**rinted **C**ircuit **B**oard
- **SMD**: **S**urface-**M**ount **D**evice (Chips you connect on top of the PCB)
- PCB + SMDs = Finished board



## Reference
- [Video of Jacob Sorber](https://youtu.be/9zU92H_CLVI)
- [Tweet of @info_libertas](https://twitter.com/info_libertas/status/1404929087618039819)
