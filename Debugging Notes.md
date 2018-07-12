# Debugging Notes

How to analyze failed tests, to figure out if they are valid failures or simply incorrectly implemented tests / not testable.

Use **PushButton Debug Program** to perform each test type:

- Pins test first
- Shorts test
- Analog test, etc... [all unpowered tests]
- Test power supplies for current limit
- Digital Incircuit test, Analog Functional test, etc... [all powered tests]
- Correct all failing tests [re-run each test multiple times with 're-cycle test']
- Review _testability.rpt_ for 'Limited' or commented and debufg these
- Use Test Grader to stress test the tests, and review

## Stable Tests + CPK

Tests should pass everytime they run, and should run on different boards that have slightly different values inherent in the reality of manufacturing electronics. A metric to measure test stability is Process Capability Index [CPK], which is the process capability adjusted for a non-centred distribution.

CPK can very wildly from negative to over one thousand. Generally a an average good test will be around 100-300, but anything above 10 is can be considered stable.

You can view the CPK of a given test by pressing the _Disp Meas_ or _Disp Histo_ button of the BT-Basic window. It will run the test 50 times and show different metrics. For analog debug, the display measurements option is more useful since it is quicker and doesn't require a new window opening; for board grading the histogram is more useful since it shows how close to the limits test measurements tend to be.

## Faon / Faoff / ...

There are six very similar commands used to attach and detach the fixture connections:

**fXon:** This turns on vacuum X to pull fixture down.
**fXoff:** This disengages vacuum X, raising the fixture.

`// X is to be replaced with a, b, c, or d`

- The vacuums may be bypassed to use pneumatic pressure to push fixture down
- This allows for air-cooling of components

This command will discharge all components after a default delay [e.g. 1.5 s]; if this delay is not long enough it can be overidden with fXon {delay}.

Each vacuum well [a,b,c,d] can be defined to control multiple vacuum solenoids. This snippet defines 'a' as controlling solenoids 2 + 3. This means faon would engage solenoids 2 + 3

``` basic
vacuum well a is 2, 3
```

## Short Pin

Some tests will fail due to a short pin not being able to make contact with the board, when it should be in contact. This can be recognized because the voltage values at a node are consistent but lower than expected [e.g. 0.4 V, instead of 3 V].

**Fix:** Use longer version of pin.

## Diode Analog Unpowered Tests

If a test is failing it may be due to the diode being placed backwards; test this by reversing the **s** and **i** buses. If this is the case, the diode needs to be corrected or a new board used.

If this is not the reason for the failure, it may be due to low current [due to current leakage] across the device, thus not reaching the correct votlage drop; this can be fixed by modifying the current being run across the diode.

**The steps for this are:**

- Debug Selected Test
- Compile and Go
- _adjust current [or add a wait of 200 ms]_
  - check in library for current, or datasheet
- Save
- Compile Tests

## LED Colour Unpowered Tests

These tests require a `powered` command because the board fixture must be in the correct position, but the board will not be powered for these tests. The commands you need to run are shown below; commands seperated by `|` are the same as running the commands seperately. [`cps` means connect power source]

`powered | cps | <sps from testplan>`

The part from the testplan is the line that starts with sps in the test plan found the line before the colour powered LED test definition [e.g. `sps 1,5.0,0.2;optimize`].

## Capacitor Analog Unpowered Tests

- try `ed`
- check for possible guards on schematic
- add wait [try `wa50m`, `wa150m`]
- swap `i` + `s` buses
- look in schematic for unguarded node
- try commenting out existing guards
- change frequency [`fr1024`,`fr8192`, `fr128`]
- modify nominal value offset to pass the test
- increase / decrease tolerance to increase cpk

If the measured capacitance value is negative, the capacitor is most likely shorted to ground via jumper [if the other node is connected to ground]. Check in the `board_z` file to make sure both the nodes of the capacitor are not present in the file; if they are then you can comment the test out, with a comment explaining it is shorted by a jumper

`// capacitor tolerances should be limited to around +15%, -30%`

## Custom 4-wire Tests

- try `ed`
- check for possible guards on schematic
- comment out both `a` + `b` buses
  - make sure to also remove `sa` + `sb` options
  - try just commenting just one of the two
- remove the `en` option
- add wait [try `wa50m`, `wa150m`]
- add offset

## Resistor Analog Unpowered Tests

- try `ed`
- check for possible guards on schematic
- add wait [try `wa50m`, `wa150m`]
- add an offset [for ≥ 100 Ω]
  - as last resort, try to avoid

## Diode Analog Unpowered Tests

Make sure test does not pass when `i` and `s` buses are swapped, so test can catch reversed diodes.

- try `ed`
- check for possible guards on schematic
- check part library for breakdown current at given voltage
  - if it is not there, go look in datasheet
- try increasing current
  - 1 mA, 5 mA, +5 mA until 50 mA
- Diode tresholds should be 1.3•_vf_ 0.7•_vf_

## Transistor Analog Unpowered Tests

These tests function as two diode tests for each PN junction [BC and BE]

- see steps for diode tests above

