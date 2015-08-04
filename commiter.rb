#!/usr/bin/env ruby

offset = 200

loop do

  if offset > 0

    @date = (Time.now - offset).strftime("%a %b %-d %H:%M:%S %Y %z")

    File.open('vars', 'w+') do |f|
      f.puts "export GIT_AUTHOR_DATE=\"#@date\""
      f.puts "export GIT_COMMITTER_DATE=\"#@date\""
    end

    IO.popen("/bin/bash", "w") do |shell|
      shell.puts "source vars"
      shell.puts "echo $GIT_AUTHOR_DATE"
      shell.puts "echo $GIT_COMMITTER_DATE"
      shell.puts "git add . && git commit -m '#@date' && git push origin master"
    end
    
    offset = offset - 86400

  end

end
