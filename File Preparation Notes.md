# File Preparation Notes

After the `board` and `board_xy` have been compiled, and the board placement decided, some files need to be prepared in order to order the test fixture.

## Isolated Supply

Due to how the 3070 system works, it will not connect the power supply ground to the circuit ground. To overcome this, there is a simple workaround that has been created. All the pins of the high or low side of the power supply are connected to an electronic node with maximum wires so that when IPG runs, it will not be able to connect the power supply to real ground.

Each power supply has three pins on the positive and negative outputs: A, B, and Sense [prefixed with L for low, or H for H]. Each one of these pins **on one of the ouputs** [positive or negative output, but not both] is connected with three wires [the maximum] to an electronic pin, which is named with the power supply number and the pin that is connected to [e.g. `PS1_LA`]. The pin names can be found in power supply resources excel sheet.

It is important to only do this to the reference output, and not both, otherwise you will not be able to supply power to the board. The refernce voltage will be the negative output if the voltage is defined as positive [e.g. 48 V], but it will be the positive output if the output ius defined as negative [e.g. -48 V]. Make sure to read the SOP Appendix 7 about how to isolate the supply properly and why this is necessary.

### Creating Electronic Nodes

To create an electronic node you can add the node from the fixture consultant through the menubar _Tasks_ > _View/Edit Fixture Electronics_ > _Add/Delete Nodes_. In the pop-up windows type the name of your new node and press _Add New Node_.

To find which power supply are connected where, you can find it by searching for `Supply` in the `board` file.

### Wiring Power Supply to Electronic Nodes

After creating the electronic nodes you need to connect the power supply reference output to these nodes. Using fixture consultant, open the _Fixture Wiring Diagram_ and _Search Specification Form_ windows. You can the first through the menubar option _Tasks_ > _View/Edit Fixture Electronics_ > _Add/Delete Wires_. For the second, go _Search_ > _For Node_. Type the electronic node name press _Show Wiring_; this will automatically display the node in the _Fixture Diagram_. [You can forgo the first step and the second step will open the _Fixture Diagram_ automatically] Repeat this for the three nodes [A, B, S].

Now you need to add the pins from the supply. These pin numbers can be found in the power supply resources excel sheet, they will be a 5 digit number. You add these in the _Fixture Wiring Diagram_ window by adding it as an item. It may say `<OTHER Node>` since it is not connected to any other node. To add wires between these two nodes, you can type both nodes into the bottom section where is says _Specify Endpoints For New Wire:_, press _Add New Wire_. Repeat this three times per node, for each of the three nodes.

Now you have to do this for all the remaining power supplies.

### Wiring Power Supply to Pins

Now that the power supply is connected to the electronic nodes, you need to connect these electronic nodes to pins on the fixture. You can find pins connected to the correct node on the board [e.g. `RTN`] by going through the menubar _Search_ > _For Node_ and finding the node then pressing _Locate_.You can then select any drilled hole and right clicking on it. This will open the _Node Information Form_ window with all the probes for this nodel; if no probes exist or you need more probes, you will have to add them [see section below]. You can then press the _Show Fixture Wiring For This Node_ to show it in the _Fixture Diagram_ window. Now connect the pins to the terminals; make sure to have enough pins based off the current that is expected: 2 probes for the first Amp, and one more for every additional Amp [e.g 1.6 A requires 4 probes since 1 + 0.5 + 0.1]. The sense [S] pin on the supplies does not have much current through it so the probes should mostly be connected to the other pins [A and B].

#### Adding probes

You can add new probes from board consultant. You do this by right clicking on a possible probe location for the desired node. This will open the _Node Entry Form_ window. Change the _Probe Access_ option to _Mandatory_, as it will probably be set to _Normal_. You must now recompile the `board` file, the `board_xy` file, and add the board placement line from `fixture.o` into `board_xy`.

In fixture consultant, you can reload the board through the menubar _File_ > _Open..._ and pressing _OK_ [assuming you are already in the board directory]. Now to view the new probe, go to _Tasks_ > _Run Probe Selection_ and you should see the mandatory probe is now shown with a hollow red box.

#### Removing probes

Let's say you accidently added a probe and now you want to remove it, how do you do that? First you have to disconnect all the wires that are connected to this probe in fixture consultant. Next you want to right click on the probe in fixture consultant, which will open the _Node Information Form_. In the _Actions_ otions, select _Convert Probe to Alternative_, and this will convert the probe back to an alternative [assuming that is what it was before].

You must also make sure to convert the pin back to _Normal_ from _Mandatory_ in the board consultant, otherwise when you run probe selection in fixture consultant it will add a probe there again.

## Running Test Consultant

After isolating the power supplies, you are now ready to start generating the tests using the IPG Test Consultant. You can run test consultant by opening BT-Basic and pressing <kbd>F6</kbd>.

After the test consultant opens, select _Actions_ > _Develop Board Test_ in the menubar, which will open another window. To start the test generation, select _Actions_ > _Begin Batch Development_ and this will do the entire generation in the background, with the output in a command line window. You will get a pop-up saying something about unmux and mux systems, press continue, and the test generation will begin.

If you get a warning that one or more tests had compilation errors you can try and find it in the `summary` file that was generated by searching for `FAILED`, but this often is unreliable as it comments the wrong tests. You can run the test generation with _Begin Interactive Development_ instead of the batch development option where you will see which libraries are failing for which tests. You will then have to modify the tests libraries [not the ones in the `custom_lib/` folder since these are made to be generic] for each test that failed to compile; this will often mean modifying the same type of test with the same changes since one node may be already grounded when the test library set it to ground.

After fixing and compiling these tests, you must mark them as permanent in the `testorder` file. You do this by removing the `comment` keyword and replacing it with `permanent` and saving the file. If you fail to do this, then the failing test will be recreated and all your changes will be overwritten.

## Regenerating `fixture` file

You may need to regenerate the fixture file after recompiling the `board` and `board_xy` files. You can do this through BT-Basic with the following command from the board directory command:

`list object "fixture/fixture.o" over "fixture/fixture"`

This regenerates the `fixture` file within the `fixture/` folder. You must do it this way, otherwise the correct header will not be created.

## Creating Custom Tests

For certain components like LEDs you may have to create custom tests. Create these in a `custom_test/` folder.

For LEDs, these tests should be powered analog tests. The only difference is that a seperate power supply may be used. You will have to isolate this power supply as well, but the electronic terminal need not be connected to probes.