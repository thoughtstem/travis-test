#Couldn't get this to work in Racket.  So...
# We'll do this until I can figure out Racket's http client lib
curl -s -X POST \
   -H "Content-Type: application/json" \
   -H "Accept: application/json" \
   -H "Travis-API-Version: 3" \
   -H "Authorization: token $1" \
   -d "{\"request\":{\"branch\":\"$3\"}}" \
   https://api.travis-ci.com/repo/thoughtstem%2F$2/requests
