# Route53 Lookup
Loops through the AWS Route53 Record Sets to find a certain value or name. 

# Usage
## Initial setup
```
chmod +x route53-lookup.sh
export AWS_PROFILE="myprofile" # or run aws configure to setup your credentials
```

## Lookup a value registered in any record set
```
./route53-lookup.sh '172.17.0.1'
```

## Lookup a record set's name
```
LOOKUP_KEY='Name' ./route53-lookup.sh 'foo.bar.io'
```

## Get a list of all record set names in Route53
```
LOOKUP_KEY='Name' ./route53-lookup.sh
``` 

## Get a list of all record set values in Route53
```
LOOKUP_KEY='Value' ./route53-lookup.sh
```