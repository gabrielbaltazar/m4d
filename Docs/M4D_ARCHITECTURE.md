# Understanding M4D architecture #

### Architecture

The M4D project was developed upon SOLID principles. While this is true for most classes, it is not for everyone. SOLID was dropped every time its implementation corresponded to a more complicated implementation for developers using the project resources. Thus, to facilitate the use of M4D features, classes with more than one responsibility were introduced, but in a way that the structure did not lose the flexibility needed for its own customizations.

### Migration Manager ###

The migration manager (TMigrationsManager) is the main class. It is responsible for focusing all the features of the migrations, so that the developer can have a simple and quick access to them. It's basically a menu of features.

Through the migration manager you can:

* Register a migration.
* Execute a migration.
* Rollback a migration.
* Get migration information.
* Access other classes that interfere with the migration mechanism.

### Migration History ###

The migration history manager (IMigrationsHistory) is the interface responsible for managing all the features of the migration history recording.

Through it, it is possible to:

* Clear migration history.
* Load migration history.
* Add and remove items from migration history.
* Save migration history.
* Get the list of history migrations.

The use of most of the functionality of this class is performed by the migration mechanism. You will probably only use it as a form of query informations from the migrations already performed.

### Migrations Register ###

The migration register (IMigrationsRegister) is the interface responsible for registering migrations in a migration list. This list is used to identify all existing migrations, for the execution or rollback of migrations.

Through it it is possible to register the migrations. 

Note that the migration manager already bridges the iteration with the migration register, so there is no need to use this class directly. However, if you need to customize the way migrations are registered, this interface should be used in your reimplementation.

### Getter Migration ###

Getter Migration, seriously? What name!

Ok, not the best, but the interface (IGetterMigrations) is required. It is responsible for migrating from a list of migrations. The M4D project is based on SOLID, so there are several classes, each with its own responsibility. This is to look for migrations.

Through it, you can search for migrations, either by sequence or by date.

### Migration Executor ###

The Migration Performer (IMigrationExecutor) is responsible for performing the migrations, both updates and rollbacks.

Through it, you can:

* Perform all migrations.
* Perform pending migrations.
* Execute the migrations until a given migration (by sequence).
* Rollback all migrations.
* Rollback until a specific migration (by sequence).


