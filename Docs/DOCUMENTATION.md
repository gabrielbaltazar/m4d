# Documentation (Version 1.0.0) #

Welcome to our documentation. Here you will get information on how the project is structured, and how to get the best out of it.

### Quick start ###

if you want to quickly start using migration features, you may prefer to go directly to the [quick start](QUICKSTART.md).

### Class Reference ###

If you prefer, you can access the [class reference](CLASSES_REFERENCE.md).

### Migration Tool ###

If you want to know more about our wizard, click [here](MIGRATIONTOOLS.md).

### Performance Information ###

In addition to performing the updates, by calling the UP method of migrations, there are a number of other steps necessary for the correct operation of the migrations.
First, all migrations must be ordered so that the order of migrations runs correctly. This ordering, by default, is performed through the sequence of migrations. For this reason, prior to the UP method call, the Migration Manager calls the SETUP method so that the migration information is loaded correctly.
Another thing to be clarified is that, after the migration is executed, the occurrence information for that execution is written to a history so that you can identify which migrations have already been performed later. Note that this step is necessary for migration management to exist.
All of these steps can be customized through your own implementation.
Even with all these processes, we noticed that the update engine runs 1000 updates in about 0.35 seconds. We consider this satisfactory enough for any application where extreme performance is not really necessary.
To improve this performance, you may want to reimplement your own ordering engine, your own migration management mechanism, or your own historical control mechanism as needed.