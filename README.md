Phone2Post
==========
A simple [Tropo](http://www.tropo.com) script and Sinatra application which records a podcast over the phone and then posts the mp3 to Posterous

Install
-------
*For the server:* clone this repo, copy example_posterous.yaml to posterous.yaml and edit as shown below. Push to [Heroku](http://heroku.com).

*For the telephony part:* upload tropo.rb to Tropo, and change the URL to point to your server.

Configuration
-------------
Edit posterous.yaml as shown below:

  --- 
  "0000": 
    username: myemail@domain.com
    password: mysecretpassword
    site_id: posterous_site_id

where posterous_site_id can be found by executing:

  curl -u myemail@domain.com:mysecretpassword http://posterous.com/api/getsites

Operation
---------
 1. Phone the number provide by Tropo
 2. Listen to the prompt and enter your 4 digit PIN code
 3. When prompted, record your podcast and press # to post
 4. Tropo will send the mp3 file to your Sinatra app, which will send it to Posterous, which can autobroadcast it to the world!
