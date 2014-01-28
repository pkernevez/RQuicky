#! /bin/sh

## Prend un fichier :
## 192.168.1.1 - - [2013/10/09:10:40:39 +0200] "GET /site HTTP/1.1" 200 11197 1856282
##
## pour trasformer en 
## ip;date;method;url;code;length;duration
## 192.168.1.1;2013/10/03 02:00:26;GET;/site;200;51930;758212

fileName=$1 
echo "ip;date;method;url;code;length;duration" >"work/$fileName.out"
sed -E "s/(.*)\ -\ -\ \[(201[34].*):(.*:.*:.*)\ .*\]\ \"(.*)\ (.*)\ .*\"\ (.*)\ (.*)\ (.*)/\1;\2 \3;\4;\5;\6;\7;\8/g" $fileName >>"work/$fileName.out"