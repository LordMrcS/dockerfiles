FROM alpine:latest

RUN apk --no-cache add --update freeradius freeradius-postgresql freeradius-ldap freeradius-utils 

RUN rm -rf /var/cache/apk/*

EXPOSE 1812/udp
EXPOSE 1813/udp

CMD ["radiusd","-f","-l", "stdout","-d","/etc/raddb"]
