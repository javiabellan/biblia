# Parsing HTML: [`pup`](https://github.com/ericchiang/pup)

- **Filter by tag**: `cat robots.html | pup 'title'`
- **Filter by tag with id**: `cat robots.html | pup 'span#See_also'`
- **Filter by tag with class**: `cat robots.html | pup 'table.someClass'`
- **Filter by tag with attribute**: `cat robots.html | pup 'th[scope="row"]'`