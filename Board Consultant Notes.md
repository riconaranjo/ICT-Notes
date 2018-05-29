# Board Consultant Notes

These notes cover how to use the board consultant in the ICT application development. The board consultant can be used to input data for test generation, including where to place short / long probes, critical or fixed nodes, which devices will use TJ / VTEP, etc.

These notes will cover the steps that use board consultant found in the Standard Operating Procedure for ICT application development.

In these notes, often only one way is shown on how to access different sections of the board consultant app; this is usually not the only way, you can also use the menubar to access all sections off the app.

## Opening Board Consultant

In order to open the `board` file in the board consultant, first open BT-Basic in the same directory as the `board` file. Type `board consultant` or `board cons` and it will open a new window with the board consultant. You may see a pop-up to open the `board` file or you may have to open it manually.

To manually open the board file, go to _File_ > _Load Existing Board_ and select the directory with the board and board_xy files, and press _Load Board_. This should open the board file and render the board in the bottom right panel.

## Exiting Board Consultant

You can close the board consultant by pressing the x in the top right but this will give you a pop-up that _`this may terminate your X client'_; you can press _ok_. Additionally if you want to avoid this pop-up, you can go _File_ > _Exit_.

Before doing this it is important to know that the board file is not automatically written to when you make changes in board consultant. You must save before exiting if you do not want to lose your work. To save: _File_ > _Save Board Information_; it is recommended to save often in case of unexpected crashes or otherwise.

## Defining Devices with TJ / VTEP

TestJet [TJ] has been superceded with Vectorless Test Extended Performance [VTEP] since it is more precise but functionally remains the same, so often times TestJet is said when VTEP is meant.

Devices that use VTEP must be defined in the board file so that the appropriate tests are generated for these devices. In order to define these devices as requiring tests using TestJet / VTEP you have to search for the device. Go to _Search_ > _For Device_ in the menubar and in the _Designator_ field type the device name [e.g. U2, D10] and press <kbd>enter</kbd>. Press _Show Data For Device_ and a pop-up will appear for the specified device.

About halfway down the pop-up — below the failure message — there is a yes/no/future dropdown for _Test Using Agilent TestJet/VTEP_. Change the value to _Yes_, and press _Replace Device_, as it will overwrite the current values for the device. After pressing this button at the very top of the pop-up in the _Notes_ section, there will be a message saying that the device have been updated. You can now press _Close_ on this pop-up.

This will update the device in the board file by adding `TJ AUTO` upon saving your changes.

### Finding devices that need TJ / VTEP

In order ot find out which devices need this type of testing you can find a table in the Statement of Work [SOW] for the given board. Ask if you do not know where to find this.

## General Purpose Relays [GP Relays]

Each of the fixture modules has multiple GP relays that can be placed around the board to connect two nodes together when needed. This is often done when testing a component that has more than one 'ground' [e.g. `GND1`, `GND2`]; since the software cannot handle two different grounds, when testing this device individually, the grounds will be shorted together with a GP relay.

Another place you would add a GP relay is at the power switch; if you need to short two nodes together to turn the card on, you can add a GP relay between these two nodes to selectively turn on the board.

In order to add GP relay connections in the board consultant, in the left-hand flowchart panel you can select _View / Edit Test System Data_. In the bottom left panel select _Enter GP Relay Connections_ and a pop-up will appear. You can now enter which nodes you want to selectively be able to short together, one node in each column. You must enter the node names, not pin names [i.e. `HOTSWP_VIN` instead of `U2.3`]

The card preferences should say _Control Over Access_, if it doesn't change it so it does. Press _Update_, and the Notes section at the top of the pop-up should say that the GP relay connections have been updated. You can press _Close_ on the pop-up.

## Entering Fixed Nodes

Fixed nodes are generally nodes connected to power or ground through a jumper [e.g. inductor, low-value resistor, fuses, kelvin connects]. These are nodes that we do not want to drive, since that would not be worthwhile trying to drive power to 0, or ground to 1. For each fixed node you have to also define the expected logic level at the node: "1", "0", or "X". The "X" state is for when you are unsure what value the node will be or if it would be somewhere around halfway between "1" and "0".

To add the fixed nodes to the board file using board consultant, select _View / Edit Test System Data_ in the left-hand flowchart panel, and then select the _Enter Fixed Node Data_ option; you should get a pop-up window. In this window you can add all the node names, specify the family, and the expected logic level. After you are done inputting all the fixed nodes, press _Update_; you should see the Notes section update. You can press _Close_ now.

### Adding more than four fixed nodes

In the _Fixed Node Options Form_ pop-up, you might think that there is no button to add more nodes after the first four blank rows are filled up. And you would be correct, there is no button to add more rows. But, you can press <kdb>enter</kbd> in the bottom row and it will automatically add a new row.

## Capture TestJet Outlines

This option can be found in the menubar under _Tools_ > _Capture All TestJet/VTEP Device Outlines_. A pop-up will appear, press _Yes_.

## TestJet Auto Selection

In order to set TestJet to auto select probe types, you can go to _Fixture Options_ by going to the flowchart and selecting _View / Edit Test System Data_ and clicking _Enter Fixture Options_, which will open yet another pop-up. Find the _Default Probe Type for TestJet/VTEP Devices aDded By Board Consultant:_ and in the dropdown menu select _Auto Selection_, then press update and _Close_.

## Compiling the `board` file

Before compiling the board file, there are a few things you need to do, otherwise you will get a bunch of errors and it will fail.

You must first compile all libaries in the `custom_lib/` folder. The quickest way of doing this is by selecting to the menubar option _Compile_ > _Compile Modified Libraries_, instead of compiling them with BT-Basic individually. This does not seem to give error messages if libraries don't compile correctly.

If the board file compiles successfully, this will be noted in the Notes section of the board consultant.

### Errors

You will probably get lots of errors when compiling the board file, so in order to see them you can use BT-Basic to compile the board with the list option:

`compile "board";list`

This will generate a `board.l` file which mostly the same as the board file but it has the error messages after the line which caused the error. At the very bottom is a report of the board file and a description of the error messages. This file is also generated when compiling the board through the board consultant.

#### Safeguards

Any digital custom libraries will have safeguards, and these safeguards must be added the `safeguards` file, otherwise you will get an error.

Each safeguard type [e.g. `standard_cmos`, `default`] must be imported with an include statement at the top of the file:

`include "default"`

Below this, **each file that uses a safeguard** must be defined:

`use parameters "default" for "<library_name>"`

After modifying the safeguard file, you must compile it. You can do this with the _Compile_ > _Compile Modified Safeguard Files_.

#### Pins Missing

You might get the error message `This pin cannot be found in the library device definiton.`. This means that not all pins were defined in the custom libraries. To fix this you need to ensure all the pins are defined / used in the tests and recompile the library.

### Warnings

If you missed any fixed nodes you should get a warning that a power pin is not connected to a fixed node. All you have to do to fix this is add the missed nodes to the fixed nodes list.

The warnings below can be ignored, but all others should be corrected.

- family is not used
- node is connected to multiple power supplies
- diode value is not in usual range
- tolerance is not in the usual range