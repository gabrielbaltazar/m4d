# FAQ - Frequently Asked Questions #

### How is the migrate engine performance? ###

In addition to performing the updates, by calling the UP method of migrations, there are a number of other steps necessary for the correct operation of the migrations.

First, all migrations must be ordered so that the order of migrations runs correctly. This ordering, by default, is performed through the sequence of migrations. For this reason, prior to the UP method call, the Migration Manager calls the SETUP method so that the migration information is loaded correctly

Another thing to be clarified is that, after the migration is executed, the occurrence information for that execution is written to a history so that you can identify which migrations have already been performed later. Note that this step is necessary for migration management to exist.

All of these steps can be customized through your own implementation.

Even with all these processes, we noticed that the update engine runs 1000 updates in about 0.35 seconds, on a mediocre computer. We consider this satisfactory enough for any application where extreme performance is not really necessary.

To improve this performance, you may want to reimplement your own ordering engine, your own migration management mechanism, or your own historical control mechanism as needed.

### Does M4D have any form of transaction? ###

No. The purpose of the migration mechanism is not to give atomicity to operations. However, you can use transactions within the updates without any loss. If an error occurred during the upgrade, there is no way for the migration mechanism to know where exactly the error was and to take coherent steps to return the migrations by executing the DOWN method, facially, to the problem encountered.
However, you may want to reimplement your own transaction mechanism, which can be done through a reimplementation of some of the M4D classes.