webirb
======

executes ruby code from http requests.

Run:

 ruby werirb.rb


Examples:

1.
  curl http://localhost:4567/irb/ -X POST -d "code=2**2"

  response:
   {"code":"2**2","output":"","exception":null,"result":4}

2.
  curl http://localhost:4567/irb/ -X POST -d "code=puts 'Hello'"

  response:
   {"code":"puts 'Hello'","output":"Hello\n","exception":null,"result":null}

3.
  Use test_api_webirb.html for other tests.