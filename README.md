# openssl.csr.bash
bash script to use openssl req utility to make a certificate signing request with subject fields

## usage
change the variables at the top of `openssl.csr.bash` to match your needs: `site_name`, `email_address`, `organization`, etc.

execute the script

    ./openssl.csr.bash

# additional info
[here is an end-to-end guide](https://jamielinux.com/docs/openssl-certificate-authority/index.html) for creating a root certificate authority, intermediate CA, certificate signing requests, and certs

## SAN ([subject alternative names](https://en.wikipedia.org/wiki/SubjectAltName)) certificates
- sometimes you want one certificate to use with multiple sub-domain names, such as `www.example.com`, `test.example.com`, and `another.example.com`, but you don't want to be so permissive as to issue a [wildcard certificate](https://en.wikipedia.org/wiki/Wildcard_certificate) `*.example.com`
- sometimes your alias domains are not sub-domains, such as `example.com` and `example.org`

[here is a guide](http://apetec.com/support/GenerateSAN-CSR.htm) for creating the configuration file to be used with the CSR

as an addendum to the [end-to-end guide](https://jamielinux.com/docs/openssl-certificate-authority/index.html), you will need to [modify your intermediate CA configuration](http://stackoverflow.com/questions/21297139/how-do-you-sign-certificate-signing-request-with-your-certification-authority#answer-21340898) by adding `copy_extensions = copy` to the `[CA_default]` section

***caution***: this will allow a vulnerability for other people to sneak in unauthorized domains in their certificate signing request. if you are signing requests for other people, then make sure that you **review** the request **before** signing it

    openssl req -text -noout -verify -in example.com.csr

## converting formats (.crt/.pem/.cer & .key) to .pfx
Microsoft's IIS uses the `pfx` format, so you will need to [convert it](http://stackoverflow.com/questions/6307886/how-to-create-pfx-file-from-cer-certificate-and-private-key#answer-17284371)

    openssl pkcs12 -export -out example.com.pfx -inkey example.com.key -in example.com.crt
