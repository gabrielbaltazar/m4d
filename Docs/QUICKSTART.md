[Back](DOCUMENTATION.md)

### Quick Start ###

So you decided to use M4D? Good!

The first thing to know is that it is very simple to use it. It was made to make your life easier, as well as being flexible enough for your customizations.

### Requirements ###

To get started with migrating features, just download the M4D files. After that, add the **"units\classes"** and **"units\interfaces"** folders to your **library path** and you're done!

M4D was developed to be flexible, and give the possibility of customization of its functionalities. However, to facilitate its use for those who are beginning to know it, there are standard builders that will speed up the use of its features.

Understand, however, that the default record engine for the update history uses the file system, as opposed to another more secure method. That's because the file system is a common model for all system developers, but we recommend that as you get more intimate with these tools, you rewrite your own method of writing history, probably by writing them to a database. It is easy and we have an example of how to accomplish this that goes along with the files at the time of download.

Along with the M4D files, there are two demonstration projects:

* **Demo** - This project is a simple example of how to use the standard features of M4D.
* **DemoDB** - In this project, we reimplement how the histories are generated so that they store the information in a database (SQLLite, but the logic is the same for any other).

### Migrations ###

The first thing to understand how migrations work is to create a migration. Each migration will be a different unit. You can give it the name you need for this unit, but we suggest using the prefix "M" to identify it as a migration unit. In addition, we suggest that all migrations be separated from the source code, inside a folder called "Migrations", for example. We believe this will facilitate the organization of the source code.

Here is an example of a migration:

```sh
unit MExempleOfMigration;

interface

uses
  {$IF DECLARED(FireMonkeyVersion)}
    FMX.Dialogs,
  {$ELSE}
    Vcl.Dialogs,
  {$ENDIF}
  M4D,
  M4D.Migrations;

type
  TMDescription1 = class(TMigrations)
  public
    procedure Setup; override;
    procedure Up; override;
    procedure Down; override;
  end;

implementation

uses
  System.SysUtils;

{ TMDescription1 }

procedure TMDescription1.Setup;
begin
  Self.Version := '1.00';
  Self.SeqVersion := 1;
  Self.DateTime := StrToDateTime('01/09/2017 07:13:00');
end;

procedure TMDescription1.Down;
begin
  ShowMessage('Executing down!');
end;

procedure TMDescription1.Up;
begin
  ShowMessage('Executing up!');
end;

initialization
  RegisterMigration(TMDescription1);

end.
```

The first thing here, is to understand the **TMigrations** class. It is a class that implements the **IMigration** interface. You can create your own implementation of this interface, although we see no reason for this.

IMigrations has 3 properties:

* **Version** - Sets the version of this update. It is purely informative. It exists so you can sort your updates in different "versions". So you can know to which version this update refers. Here you pass your versioning form. If you do not use any, leave it empty.
* **SeqVersion** - Sequence of the update. It is responsible for determining the order of the updates. Do not repeat the sequence with other migrations.
* **DateTime** - Sets the update date and time. It is purely informative. It exists so you can sort your migrations for a period of time. When in doubt, leave empty.

IMigrations also have 3 methods:

* **Setup** - The setup method is used to inform the migration´s version, sequence, and date properties.
* **Up** - Method that will be executed when the migration is running. As updates occur, the migration engine takes each migration that will be part of the process and executes this method, in addition to the setup method.
* **Down** - Method that will be executed when the migration is returning. As updates are retroacted, the migration engine takes each migration that will be part of the process and executes this method, in addition to the setup method.

Thus, the process of updating the migrations must be placed in the UP method, and the process of returning the updates must be placed in the DOWN method.

The last thing to be said here is about calling the **RegisterMigration** method, which is below the **"initialization"** directive. This is how the update engine knows which registered updates can be performed.

### Update ordering ###

Each update has a sequence. This sequence is extremely important because it determines the order of the updates. As the update engine is triggered to run the updates, it follows this sequence to determine which update is to be processed first. If updates need to be returned, the order of the migrations that will be executed will be reversed because it is understood that the latest updates should be outdated first.

Although we see no reason for this, even this mechanism may be replaced by another, which we find more convenient.

### Standard Builders ###

Standard builders exist only to facilitate the use of M4D features.

Within the unit M4D, there are:

> **function MigrationFacade: TMigrationsFacade; overload;**
>
> This function is a singleton that returns the person responsible for managing the migrations.

> **procedure Release;**
>
> This procedure destroys the singleton, to avoid any problem with "memory leaks".

Also, as you use the features of M4D, you may find it necessary to pass several parameters. This is a necessity for the dependency inversion approach, which M4D is heavily built. Before you can fully understand the features, so that you have no difficulties in using them, standard builders of these required instances have been added. Inside the M4D.Defaults unit, there are:

> **TDefaultInstanceOfMigrationsSerializerCreator.getInstance**
>
> Default serialization object instance builder.

> **TDefaultInstanceOfMigrationsHistoryCreator.getInstance (AMigrationSerializer: IMigrationSerializer): IMigrationsHistory;**
>
> Defalut migrations´s history object instance builder.

> **TDefaultInstanceOfMigrationGetterCreator.getInstance: IGetterMigrations;**
>
> Instance constructor for obtaining the default migrations.

> **TDefaultInstanceOfMigrationListOrderCreator.getInstance: IMigrationListOrder;**
>
>Constructor of the default migration ordering object instance.

> **TDefaultInstanceOfMigrationsRegisterCreator.getInstance (AMigrationListOrder: IMigrationListOrder): IMigrationsRegister;**
>
> Instance builder for the default migrations log object.

> **TDefaultInstanceOfMigrationExecutorCreator.getInstance (AMigrationsHistory: IMigrationsHistory): IMigrationExecutor;**
>
> Constructor of the instance of the default migrations run object.

### Getting to work ###

Now that you know you do not need to know the architecture of M4D deeply, let's start using it.

**Step One: Creating the Migration.**

Let's use the migration itself here above, seen earlier. So you should add it to your project.

**Step Two: Performing the Migration**
```sh
M4D.MigrationFacade.ExecutePending;
```
This will cause all migrations not yet executed to run.

**Step Three: Returning the Migration**
```sh
M4D.MigrationFacade.Rollback;
```
This will cause all migrations to be returned.

### Conclusion ###

Pretty simple huh? Ready to [explore other features](M4D_ARCHITECTURE.md)?
