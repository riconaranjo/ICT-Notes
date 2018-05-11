# Tests Notes

These notes cover in detail the tests performed with Keystone / Agilent / HP 3070 ICT machines.

Below is an except from `General Notes.md`

>## Unpowered Tests
>
>- **Pins** [system-fixture-pcb continuity]
>- **Preshorts** [tests switches, jumpers, potentiometers at expected settings]
>   - This is done to ensure these devices do not fail in the Shorts Test
>- **Shorts** [unexpected shorts]
>- **Analog Incircuit** [tests for analog components]
>   - resistors, capacitors, inductors, diodes, zener diodes, FETs, transistors
>- **TestJet** [for proper soldering of IC and connectors]
>- **DriveThru** [variation of TestJet, where signal goes through multiple devices]
>   - for when you have limited access to PCB connections / parts
>- **MagicTest** [like DriveThru for Analog Incircuit test]
>- **Polarity Check** [lTestJet probe to test for polarity of capacitors]
>- **ConnectCheck** [like TestJet, but alternate technique]
>
>## Powered Tests
>
>Powered tests, where if too much current is drawn, tests will fail assuming a short from power to ground.
>
>- **Setup Power Supplies:** [test power draw]
>- **Digital Incircuit:** [test individual digital ICs]
>- **Analog Funcitonal:** [test individual analog IC] (aka: Powered Analog)
>- **Mixed Signal:** [digital + analog]
>- **Digital Functional:** [tests groups of devices]
>- **Boundary Scan:** [JTAG]
>   - Incircuit tests with probe
>   - Interconnect tests with TDI / TDO

## Preshorts

Test run before Shorts test to ensure switches, jumpers, potentiometers are functioning, since they would cause Shorts test to fail.

## Shorts

Uses 0.1V source and 100Ω resistor, which are not adjustable.

**Two sections:** expected and unexpected shorts.

- First, shorts are defined and are checked if they exist
- Second, these shorts are compared to all other nodes
  - to ensure there are no unexpected shorts

If an unexpected short is found, the hardware will isolate the nodes that are shorted together.

### Threshold

`threshold 16` defines that anything above 16Ω is an open.

### Settling Delay

This defines how long to wait for reactive components to stabilize.

`settling delay 500m` defines a setting time of 500 ms

### Phantom Shorts

Shorts that were detected, but could not be isolated.

## Pins

This tests connects all pins to ground, except one. It checks for current flow at this pin, and assumes board connection if there is current flow.

**Different from shorts:** because it uses 2.5V [instead of 0.1V] to ensure diode / transistors will turn on; uses 10kΩ [instead of 100Ω].

If the software is trying to reverse bias a diode, it will use -2.5V.

A node between two capacitors is isolated since no current can flow, and cannot be tested with pins test; thus the test should be commented out only when nodes are isolated.