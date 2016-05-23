# openssl.csr.bash
bash script to use openssl req utility to make a certificate signing request with subject fields

## install [openssl][1]

ubuntu

    sudo apt-get install openssl

red hat

    sudo yum install openssl

## usage
change the variables at the top of `openssl.csr.bash` to match your needs: `site_name`, `email_address`, `organization`, etc.

execute the script

    ./openssl.csr.bash

# additional info
[here is an end-to-end guide][3] for creating a root certificate authority,
intermediate CA, certificate signing requests, and certs

## SAN ([subject alternative names][8]) certificates
- sometimes you want one certificate to use with multiple sub-domain names, such as `www.example.com`, `test.example.com`, and `another.example.com`, but you don't want to be so permissive as to issue a [wildcard certificate][6] `*.example.com`
- sometimes your alias domains are not sub-domains, such as `example.com` and `example.org`

[here is a guide][4] for creating the configuration file to be used with the CSR

as an addendum to the [end-to-end guide][3], you will need to [modify your intermediate CA configuration][5]
by adding `copy_extensions = copy` to the `[CA_default]` section

***caution***: this will allow a vulnerability for other people to sneak in unauthorized domains in their
certificate signing request. if you are signing requests for other people, then make sure that you
**review** the request **before** signing it

    openssl req -text -noout -verify -in example.com.csr

## converting formats (.crt/.pem/.cer & .key) to .pfx
Microsoft's IIS uses the `pfx` format, so you will need to [convert it][7]

    openssl pkcs12 -export -out example.com.pfx -inkey example.com.key -in example.com.crt

# credits

Thanks to Jeff Walton for [helping me figure out][2] which default configuration file to use.

[1]:https://www.openssl.org/
[2]:http://stackoverflow.com/a/37042289/4233593
[3]:https://jamielinux.com/docs/openssl-certificate-authority/index.html
[4]:http://apetec.com/support/GenerateSAN-CSR.htm
[5]:http://stackoverflow.com/a/21340898/4233593
[6]:https://en.wikipedia.org/wiki/Wildcard_certificate
[7]:http://stackoverflow.com/a/17284371/4233593
[8]:https://en.wikipedia.org/wiki/SubjectAltName
