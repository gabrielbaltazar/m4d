# Welcome #

This is the repository of the migration framework for Delphi. 

Migrations are snippets of codes that run on updates of any type. They work as a version control mechanism. Migrations help your source code stay organized, as well as provide rollup and update functionalities.

Migration are common in frameworks such as Laravel, for example.

### Setting M4D up? ###

To start using the migrations, you will need 3 simple steps.

First step - simply add these folders in your project's library:

units \ classes
units \ interfaces
units \ types

This will make the compiler to know what is required to compile the migrations.

Step Two - Create your migration class:

Along with the installation of M4D, a wizard is added to the IDE to speed up the creation of the migration class, with everything needed for its operation.

Step Three - Record your migration class:

The registration of the migration class is very simple, and done through the call of the RegisterMigration (TMigrationClass) method. You can do it anytime you need it, and together are some examples of how we suggest doing it.

Once done, simply use the migration manager to simply move forward or return with the migrations. Simple, is not it?

### License Information ###

It is free!

For more information, read our more detailed license information.

### Contact Information ###

Please, let me know that you are using this framework for migrations (M4D). It will be a pleasure.

M4D was developed to people like you enjoy the facilities and empowerment of your application.

* Author: Edgar Borges Pavao
* Email: m4d@edgarpavao.com