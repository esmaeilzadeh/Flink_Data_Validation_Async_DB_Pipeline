در صورتی که sbt روی سیستمی که می خواید build بگیرید نصب ندارید قبلش از اینجا باید آخرین ورژنش رو نصب کنید روی سیستمتون: 
https://www.scala-sbt.org/download.html


برای اجرای پروژه لطفا دستور زیر رو در root پروژه بزنید:
./build.sh
این سرویس ها روی سیستم فعال میشه:
kafka:
localhost:9092 (system is not dependent on this port and if this is used with another service you can change it)

psql:
localhost:5433 (system is not dependent on this port and if this is used with another service you can change it)
user: dbuser
pass: dbpassword

jobmanager:
http://localhost:8090

برای مشاهده لاگ flink:
docker-compose -f validator/docker/docker-compose.yml logs -f
برای respawn کردن کل سرویس ها (در صورت بروز مشکل یا down شدن هر کدام):
./respawn.sh


در تاپیک registered_mobiles  مقدار زیر رو وارد کنید که بتونید smoke تست بگیرید:
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
 

