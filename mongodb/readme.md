
Step 1: See all your databases:

```
show dbs
```

Step 2: Select the database

```
use your_database_name
```

Step 3: Show the collections

```
show collections
```

This will list all the collections in your selected database.

Step 4: See all the data

```
db.collection_name.find() 
```

or

```
db.collection_name.find().pretty()
```