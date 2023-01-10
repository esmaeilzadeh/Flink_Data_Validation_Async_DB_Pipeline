This a simple Apache Flink data streaming pipeline which applies a series of custom validations that was generated with Play validation library. Then connect to an external DB asynchronously and fetch data and check is input data are identical with the record existed in the DB the write the output in another DB.

If you don't have installed sbt please download and install it from here:
https://www.scala-sbt.org/download.html
for runing the project:
./build.sh

After running the project these services becomes available:
kafka:
localhost:9092 (system is not dependent on this port and if this is used with another service you can change it)

psql:
localhost:5433 (system is not dependent on this port and if this is used with another service you can change it)
user: dbuser
pass: dbpassword

jobmanager:
http://localhost:8090

For watching the flink log you can run this command:
docker-compose -f validator/docker/docker-compose.yml logs -f

To respawn the system you can run this command:
./respawn.sh



For testing the system you can put this message in the registered_mobiles topic:
key:
{"userId":23423},
value:
{
    "service": {
      "mobileNumber": "10131155490",
      "imsi": "878861121092696",
      "sms": 0,
      "data3g": 0,
      "data4g": 0
    },
    "address": {
      "address": "1933 Kropf Alley",
      "postalCode": "7163175038",
      "tel": "1562289156"
    },
    "certificationNo": "5067",
    "fatherName": "Newham",
    "name": "Else",
    "family": "Livvy",
    "birthDate": "4752/72/85",
    "gender": 0,
    "identificationNo": "8205446298"
  }
 

