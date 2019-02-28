#lang racket
(require web-server/servlet
         web-server/servlet-env
         simple-http
         json)

(define travis-key (first (file->lines "../travis-key")))

(define (run-build branch)
  (system (~a "bash /home/ubuntu/travis-test/run-build.sh " 
               travis-key " ts-all-" branch " master")))


(define (verify method branch repo-name)
  ;TODO: Get the secret key out of the paylad and check it here too
  ;  See: https://developer.github.com/webhooks/securing/

  (and (string=? "POST" method) ;Must be a post method
       ;Ignore pushes to ts-all-dev and ts-all-master (prevents double builds when we do push to those)
       (not 
         (or (string=? "ts-all-dev" repo-name)
             (string=? "ts-all-master" repo-name)))
       (or (string=? "dev" branch)
	   (string=? "master" branch))))
 
(define (my-app req)

  (define method (~a (request-method req)))
  (define bindings (request-bindings req))
  (define json-payload (string->jsexpr (extract-binding/single 'payload bindings)))

  (define branch (third (string-split (hash-ref json-payload 'ref) "/")))
  (define repo-name (hash-ref (hash-ref json-payload 'repository) 'name))

  (and (verify method branch repo-name)
       (run-build branch))

  (response/xexpr
   `(html (head (title "Hello world!"))
          (body (p "Hey out there!")))))
 
(serve/servlet my-app
               #:port 80
	#:listen-ip #f
	#:servlet-path "/hello.rkt")
