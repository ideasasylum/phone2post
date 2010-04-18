answer
say 'Hi, welcome to phone2post'
result = ask 'Please enter your PIN code', 
                {:repeat => 3, :mode => 'dtmf', :choices => '[4 DIGITS]'}
log "#{result.name}:#{result.value}"
if result.name == 'choice'
    apikey = result.value
    
    event = record('Record your podcast now. Press the hash key when finished',
               { :repeat              => 0, 
                 :bargein             => true, 
                 :beep                => true, 
                 :silenceTimeout      => 5, 
                 :maxTime             => 60,
                 :timeout             => 4.03456789,
                 :terminator          => '#', 
                 :recordFormat        => 'audio/mp3',
                 :recordURI           => "http://phone2post.heroku.com/upload/4367803575802/#{apikey}" })

    log 'Recorded file: ' + event.recordURI
    say 'Your podcast has been sent to posterous.'
end

say 'Thank you. Bye!'

hangup
