answer
say 'Hi, welcome to phone2post'
answer = ask 'Please enter your PIN code', 
                {:repeat => 3, :terminator => '#', 
                :mode => 'dtmf', :choices => '[4 DIGITS]'}

if result.name == 'choices'
    apikey = result.value
    
    event = record('Record your podcast now. Press the hash key when finished',
               { :repeat              => 0, 
                 :bargein             => true, 
                 :beep                => true, 
                 :silenceTimeout      => 5, 
                 :maxTime             => 60,
                 :timeout             => 4.03456789,
                 :terminator          => '#', 
                 :recordURI           => "http://phone2post.heroku.com/upload/#{apikey}" })

    log 'Recorded file: ' + event.recordURI
end

say 'Thank you. Your podcast has been sent to posterous. Bye!'

hangup
