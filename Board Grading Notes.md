# Board Grading Notes

After all the tests have been debugged, then the tests are analyzed and graded on how reliable they are. Since during production, boards will have different components each with varying values; for example a resistor might be rated at 10 Ω ± 10%. This means that if one test is marginally passing on one board, another board of the same type might fail since its components perform slightly differently.

In order to measure how reliable an **analog test** is, it is run 50 times and the using fancy statistics a **CPK value** is calculated. If the CPK is lower than 10, a test is unreliable and needs to be adjusted. Sometime the CPK will be higher than 10 but the average mean of measured values in a test might be close to the upper or lower limits of the test; this test would also need to be adjusted.

Even though a script runs all the tests and generated a report, every test is verified individually and run to make sure that it is within the correct bounds and with a high enough CPK.

## Phase One and Phase Two

There are two phases to testing; phase one is unpowered tests, and phase two is powered tests. The board grading results for each phase is in a seperate file.

Phase One: `bdg_results_phase_one`
Phase Two: `bdg_results_phase_two`

## Flags

When the board grading script is run it will insert flags for certain tests; each test can have multiple flags, or none at all. These flags are: M, C, F.

**M:** Mean, the mean measurement is close to upper or lower limit, or is not centred
**C:** CPK, the CPK value is low, test may need adjustments
**F:** Fail, test failed at least once

## Setup

Open KornShell and type `startdebug` on the test machine, from board working directory. In the BT-Basic window you can type `testhead is 1`, or select it as a Macro in the PushButton Debug program. Run the `pins` test macro in order to setup test fixture for debugging.

In order to evaluate the tests, open them in the **PushButton Debug** [PBD] program by either typing `debug "<part_name>"` in BT-Basic, or in the PBD window with _Debug > Debug Test_ and typing the part name into the window [e.g. r100]. You then want to run the test several times by pressing _display histo_ or _display meas_ in the BT-Basic window, or PBD window with _Display > Display Histogram / Display Measurement_.

If you make any changes to the test file you need to press _Compile and Go_ before running _Display Histogram / Display Measurement_.

### On First Login

- Map Network ICT drive
- Run `setupenv.ksh` in KornShell

## Quickly Running Tests

In order to quickly debug the test and show the histogram of the the results, you can type these commands into BT-Basic.

`debug '<test_name>' | display histo`

It is important to note that if you modify the tests outside the debug window, if you press run this command, it will not run your modified test as it needs to be compiled

## Modifying Tests

After every test is verified a comment [with name] is added in the board results file. This is to ensure that every test is verified and adjusted as necessary. Any test that is modified needs to be commented [with name] with the original line also commented out, so that any changes are visible. After a test is adjusted, it needs to be saved and compiled [and marked as permanent].

`// to mark test as permanent after being compiled, press Mark in the PushButton Debug program after selecting Compile`

### Steps

- _Debug Selected Test..._ [PBD]
- _display histo_          [BT-Basic]
- Analyze for mean too close to limits or low CPK

**If changes are needed:**

- Add comment with what changes are and why
- _Compile and Go_  [PBD]
- _display histo_   [BT-Basic]
- Repeat if necessary
- Save file
- _Compile Test..._ [PBD]
- _Mark_            [PBD]
- _OK_              [PBD]

## Resistors

Sometimes resistor tests may fail or have a low CPK and will need adjusting to make the test more reliable.

### CPK Too Low

If the CPK is too low for a resistor, these are the steps you could take to improve the test.

**If the measurements seem centred:**

- add `ed` [extra-digit]
  - this may require lowering the reference resistor by a magnitude
    - e.g. `re3` to `re2`
- increase wait time
- remove wait time

**If the measurements are not centred:**

- modify offset [if present]
  - increase to move right; decrease to move left
- decrease /increase tolerances [only if CPK does not decrease]
  - obviously within reason [if in doubt ask]
  - usually no more than ±15% [try 10%]
    - exception: 10 Ω with +10% to +50% [since small resistance]
- increase tolerances
- add `en` [enhanced measurement]
- comment / uncomment guards

### Mean Not Centred

Follow the same steps as above.

Sometimes, although a test may be flagged to have a low CPK, it may not need adjustment. If the test is run multiple times [~50] and the CPK is measured to be well above 10, **and the measurement is centred**, then no adjustments need to be made. Comment the measured CPK in the board grading results file.

Other times, the CPK may be well above 10 [e.g. 600] but the measurement is not centred. This still means the test needs adjustment to ensure the test is reliable.