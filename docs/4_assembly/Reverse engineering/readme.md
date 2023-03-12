# Reverse engeneerging


1. Identify the architecture (CPU + Memory) the binay is working with
   - This will tell you the register sizes, etc.
2. find a disassembler
   - Dis51: target a single architecture
   - Dis66k: custom-written for automotive reverse engineering
   - CATS dasm
   - IDA Pro: Supports more embedded target but is very expensive
   - Hopper
   - dasmx
   - objdump



bosch EDC17CP09 	Automatic Transmission 325d 204hp
Bosch EDC17CP45



The ECU is a common target of reverse engineering, sometimes referred to as chip tuning.
 the most popular ECU hack is modifying the fuel map to alter the balance of fuel efficiency and performance in order to give you a higher-performance vehicle