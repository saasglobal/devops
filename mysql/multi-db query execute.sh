#!/bin/bash
# Prepared by : Rimon
# mysql credential
user="USER"
pass="PASSWORD"

# list of all databases
all_dbs="$(mysql -u $user -p$pass -Bse 'SHOW DATABASES')"

for db in $all_dbs
     do
        if test $db != "DATABASE_1"
            then if test $db != "DATABASE_2"
            then if test $db != "DATABASE_3"
            then if test $db != "DATABASE_4"
            then if test $db != "DATABASE_5"
            then if test $db != "DATABASE_6"
            then if test $db != "DATABASE_7"
            then if test $db != "DATABASE_8"
            then if test $db != "DATABASE_9"
            then if test $db != "DATABASE_10"
            then if test $db != "DATABASE_11"
            then mysql -u$user -p$pass $db -sN -e "source /path/to/store/script/query.sql"
        fi
       fi
      fi
     fi
        fi
       fi
      fi
     fi
        fi
       fi
      fi
     
	  done