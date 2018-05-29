# File Preparation Notes

After the `board` and `board_xy` have been compiled, and the board placement decided, some files need to be prepared in order to order the test fixture.

## Isolated Supply

Due to how the 3070 system works, it will not connect the power supply ground to the circuit ground. To overcome this, there is a simple workaround that has been created. All the pins of the high or low side of the power supply are connected to an electronic node with maximum wires so that when IPG runs, it will not be able to connect the power supply to real ground.

Each power supply has three pins on the positive and negative outputs: A, B, and Sense [prefixed with L for low, or H for H]. Each one of these pins **on one of the two ouputs** is connected with three wires [the maximum] to an electronic pin, which is named with the power supply number and the pin that is connected to [e.g. `PS1_LA`]. The pin names can be found in power supply resources excel sheet.

It is important to only do this to the reference output, and not both, otherwise you will not be able to supply power to the board. The refernce voltage will be the negative output if the voltage is defined as positive [e.g. 48 V], but it will be the positive output if the output ius defined as negative [e.g. -48 V]. Make sure to read the SOP Appendix 7 about how to isolate the supply properly and why this is necessary.

### Creating Electronic Nodes

To create an electronic node you can add the node from the fixture consultant through the menubar _Tasks_ > _View/Edit Fixture Electronics_ > _Add/Delete Nodes_. In the pop-up windows type the name of your new node and press _Add New Node_.

To find which power supply are connected where, you can find it by searching for `Supply` in the `board` file.

### Wiring Power Supply to Electronic Nodes

After creating the electronic nodes you need to connect the power supply reference output to these nodes. Using fixture consultant, open the _Fixture Wiring Diagram_ and _Search Specification Form_ windows. You can the first through the menubar option _Tasks_ > _View/Edit Fixture Electronics_ > _Add/Delete Wires_. For the second, go _Search_ > _For Node_. Type the electronic node name press _Show Wiring_; this will automatically display the node in the _Fixture Diagram_. [You can forgo the first step and the second step will open the _Fixture Diagram_ automatically] Repeat this for the three nodes [A, B, S].

Now you need to add the pins from the supply. These pin numbers can be found in the power supply resources excel sheet, they will be a 5 digit number. You add these in the _Fixture Wiring Diagram_ window by adding it as an item. It may say `<OTHER Node>` since it is not connected to any other node. To add wires between these two nodes, you can type both nodes into the bottom section where is says _Specify Endpoints For New Wire:_, press _Add New Wire_. Repeat this three times per node, for each of the three nodes.

Now you have to do this for all the remaining power supplies.

### Wiring Power Supply to Pins

Now that the power supply is connected to the electronic nodes, you need to connect these electronic nodes to pins on the fixture. You can find pins connected to the correct node on the board [e.g. `RTN`]. You can find the pins connected to a node by going through the menubar _Search_ > _For Node_ and finding the node then pressing _Locate_. You can then select any drilled hole and right clicking on it. This will open the _Node Information Form_ window. You can then press the _Show Fixture Wiring For This Node_ to show it in the _Fixture Diagram_ window. Now connect the pins to the terminals; make sure to have enough pins based off the current that is expected: 2 probes for the first Amp, and one more for every additional Amp [e.g 1.6 A requires 4 probes since 1 + 0.5 + 0.1]. The sense [S] pin on the supplies does not have much current through it so the probes should mostly be connected to the other pins [A and B].