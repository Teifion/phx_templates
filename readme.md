### Purpose
A script designed to create files for using in Phoenix based on some differences I have with the existing generators. This is designed to be extensible and used by anybody that wants to make their own tweaks.

### Existing types
##### Grouped object
Something linked directly to a group and has a group_id as part of its attribute list. It will have controllers, views and templates for it.

##### Connector object
Connector object is something used to link other objects together and does not require the same level of queries, controllers, views or templates.
