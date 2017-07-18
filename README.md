### Propel Helper
This repository works as a small helper to initialize propel for your project. It includes the following:

* Setup scripts for windows (Coming soon for mac/linux)
* Dummy files for schema and propel model. You can change the `app` folder to `src` or whatever suits you best.
* Wiki with the most common operations of Propel to help you get started

### How-To
This helper allows you to connect your project to one or multiple databases based on your project's needs.

Based on your given domain, you can separate propel schema and configuration and allow the propel engine to reverse
and generate models according to your needs.

### Single domain
If your project has only one database, you can avoid all related domains in the code, including inner domain folders for
build, config and as a namespace.

### Multiple domains
If your project connects and manages multiple databases, you can separate each database on each own folder,
the so-called domain.

Create different folders and replicate config and scripts according to your schema.

By setting a different namespace, you can separate the models for your different databases.

#### IMPORTANT
By default, propel can connect to a given database name but it can save it to the configuration as "default".
Having multiple databases cannot work with all databases marked as default because each schema has to have its own
connection manager.

When creating the database schema, define a different database name which can be used as namespace
for the connection manager used by Propel.
