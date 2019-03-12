# travis-test

NOTE: This is depricated.  We don't use it.  I'm just keeping it around for reference (e.g. webserver stuff)




Simple solution for automatic build and continuous integration across Thoughtstem techs and languages:

1) Deploy this to a Linux box (Amazon EC2's micro tier is fine) at /home/ubuntu/travis-test.  Make sure you have a static ip.
2) Set up your github webhooks to ping http://IP/hello.rkt on every push
3) Put your travis API key in a file called 
4) This will trigger a Travis build of either ts-all-dev or ts-all-master 
5) If the build fails, take action.




