#!/bin/bash
# search_home.sh: a example proof of query against home#index 
curl -XGET http://${SERVER}:${ES_PORT}/callowayart/art/_search?pretty -d '
{
  "size" : 10,

  "query": { "bool": {
    "must_not": { "term": { "__tags" : "backendonly" }}
  }},

  "sort" : {
    "_script" : { 
        "script" : "Math.random()",
        "type" : "number",
        "params" : {},
        "order" : "asc"
    }
  }
}
'