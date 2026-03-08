FROM krakend:2.9

COPY krakend/krakend.json /etc/krakend/krakend.json

CMD ["krakend", "run", "-c", "/etc/krakend/krakend.json"]
