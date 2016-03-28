#!/bin/bash
site_name="example.com"
email_address="webmaster@$site_name"
organization="$site_name"
organizational_unit="$site_name"
country="US"
state="AR"
city="Fayetteville"

openssl req -new -nodes -sha256 -newkey rsa:2048 -keyout $site_name.key -out $site_name.csr -subj "/CN=$site_name/emailAddress=$email_address/O=$organization/OU=$organizational_unit/C=$country/ST=$state/L=$city"
