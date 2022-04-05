
# Web Scraping


## Get data from internet

- **cURL**
- **Selenium**
- **Google Chrome cli**
  - `google-chrome-stable --headless --disable-gpu --dump-dom 'URL' > ~/file.html`
- lynx
  - lynx -dump -listonly http://aligajani.com 


> ### Reference
> - https://www.queryhome.com/tech/54364/overview-about-wget-command
> - https://www.linuxtechi.com/wget-command-practical-examples/
> - https://www.youtube.com/watch?v=GJum2O2JM6M
> - https://www.youtube.com/watch?v=-GCDJ26B4Ho

## Parse data




## 3 ways
There are 3 ways of we scrapping:

1. FIRST OPTION: Static webpages + `pup`
2. SECOND OPTION: API reverse engineering + `jq`
3. LAST OPTION: Use Selenium or Headless browser



### 1. Static webpages

Get a simple static page (server side rendered) with `curl` or `wget` and parse them

Example:

```bash
page_html=$(curl -s $URL)
title=$(echo $page_html | pup 'title' text{})
echo $title

col_A=$(echo $page_html | pup 'a.bb1c_ attr{href}')
col_B=$(echo $page_html | pup 'span.price-sale text{}')
table=$(paste col_A col_B)
```

> https://www.youtube.com/watch?v=GJum2O2JM6M



### 2. API reverse engineering

Useful for dynamic websites. Find the hidden api that makes XHR requests to fullfill the webpage. XMLHttpRequest is used heavily in AJAX programming.

- Step 1: See the requests that the web is doing: Chrome or Firefox dev tools > Network > XHR requests
- Step 2: Copy the target request as cURL (right click)
- Step 3: Paste the target request in [Postman](https://www.postman.com) or [Insomnia](https://insomnia.rest)
- Step 4: Elaborate your own script using `curl` + `jq`


### 3. Headless browser and Selenium

Use Selenium or Headless browser for automate the interaction with the web.

