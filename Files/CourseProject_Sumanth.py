import mariadb
import sys

try:
   cm_connection = mariadb.connect(
      user="root",
      password="root",
      host="127.0.0.1",
      port=5701,
      database="loansystem")
except mariadb.Error as e:
    print(f"Error connecting to MariaDB Platform: {e}")
    sys.exit(1)

else:
   mycursor=cm_connection.cursor()
   Q1="SELECT * FROM payment WHERE AmountPaid>1500;"
   mycursor.execute(Q1)
   results=mycursor.fetchall()
   for i in results:
      print(i)
   cm_connection.close()



