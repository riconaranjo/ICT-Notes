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

## Diode Analog Tests

If a test is failing it may be due to the diode being placed backwards; test this by reversing the **s** and **i** buses. If this is the case, the diode needs to be corrected or a new board used.

If this is not the reason for the failure, it may be due to low current [due to current leakage] across the device, thus not reaching the correct votlage drop; this can be fixed by modifying the current being run across the diode.

**The steps for this are:**

- Debug Selected Test
- Compile and Go
- _adjust current [or add a wait of 200 ms]_
- Save
- Compile Tests