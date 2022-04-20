# Parsing JSON: `jq`

- **HTML table to csv**: `cat wiki.html | pup "table.wikitable tbody tr json{}" | jq '.[] | .children | "\(.[0].text),\(.[1].text),\(.[2].text)"' -r`
- table.json jq -r '.tbody.tr[1:][] | [.td[]["$t"]] | @csv'

> https://programminghistorian.org/en/lessons/json-and-jq
> https://www.datascienceatthecommandline.com/2e/chapter-5-scrubbing-data.html
