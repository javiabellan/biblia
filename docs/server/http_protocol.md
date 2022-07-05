# HTTP server

https://atareao.es/software/utilidades/httpie-un-cliente-http-para-la-linea-de-comandos/

## Python HTTP server


```bash
python3 -m http.server 9000
```

Now, create the simple index.html file inside that server directory where you have started the server. go to [http://localhost:9000](http://localhost:9000)



## Netcat HTTP server


```bash
while true
do
  echo -e "HTTP/1.1 200 OK\r\n\r\n$(date)" | nc -l localhost 8888
done

# ncat -lk -p 8080 --exec $(server_response) # --listen --keep-open

# https://www.youtube.com/watch?v=pYjoqsFjzgQ

function response {
  echo -en "HTTP/1.1 200 OK\r\n\r\n"
  echo '<!DOCTYPE html>'
  echo '<html lang="es">'
  echo '  <head>'
  echo '    <title>HTML</title>'
  echo '    <meta charset="utf-8">'
  echo '    <meta http-equiv="refresh" content="5">' # Update frontend every 5 seconds
  echo '  </head>'
  echo '  <body>'
  echo " $(date)"
  echo '  </body>'
  echo '</html>'
}

while true; do
  response | nc -l localhost 8888
  # here netcat waits for 1 connection, 
  # When the user concet to http://localhost:8888
  # The program flow continues
  echo "================================================"
done
```




## HTTP protocol


### HTTP request

```
GET / HTTP/1.1             -> request line
Host: localhost:8000       \
User-Agent: curl/7.54.0    | Request headers
Accept: */*                /
```

### HTTP response

```
HTTP/1.1 200 OK
Content-Type: text/html
Content-Lenght: 11

Hello world
```

```
INTERNET --http--> WEB SERVER --http--> APPLICATION SERVER --wsgi--> WEB FRAMEWORK
                   ==========           ==================           =============
                   apache               gunicorn                     Django
                   ngixn                uWSGI                        Flask
                                                                     FastAPI
```


https://www.youtube.com/watch?v=UklcIDgHtwQ
https://www.youtube.com/watch?v=WqrCnVAkLIo



CGI: Common Gateway Interface (1997)
WSGI: Web Server Gateway Interface (2003)



- caching mechanism:
- Reverse proxy: a system that forwards all requests from the web to our web server and back




- Que pasa si alguien sube una imagen (o imagenens) muy pesada? Relentiza el servidor?
  - gunicorn bloquearia la petición
  - Pero ngixn haria offloading buffering 