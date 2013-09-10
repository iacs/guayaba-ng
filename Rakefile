require 'rubygems'
require 'optparse'
require 'yaml'

task :review do
  OptionParser.new.parse!
  ARGV.shift
  title = ARGV.join(' ')

  path = "_drafts/#{Date.today}-#{title.downcase.gsub(/[^[:alnum:]]+/, '-')}.textile"
  
  if File.exist?(path)
    puts "[WARN] File exists - skipping create"
  else
    File.open(path, "w") do |file|
      file.puts YAML.dump({'layout' => 'review', 'category' => 'review', 'title' => title, 'cover' => '.jpg', 'score' => '' ,'dev' => '', 'year' => '', 'formato' => [], 'genero' => [], 'plataformas' => [], 'author' => 'Iacus'})
      file.puts "---"
    end
  end
  `subl #{path} &`

  exit 1
end

task :newpost do
  OptionParser.new.parse!
  ARGV.shift
  title = ARGV.join(' ')

  path = "news/_posts/#{Date.today}-#{title.downcase.gsub(/[^[:alnum:]]+/, '-')}.textile"
  
  if File.exist?(path)
    puts "[WARN] File exists - skipping create"
  else
    File.open(path, "w") do |file|
      file.puts YAML.dump({'layout' => 'blogpost', 'title' => title, 'author' => 'Iacus'})
      file.puts "---"
    end
  end
  `subl #{path} &`

  exit 1
end

task :deploy do
  
  command = "jekyll build && rsync -avr -e 'ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null' --delete --delete-after --log-file=/home/iacusm/data/logs/rsync-guayaba.log /home/iacusm/data/web/guayaba-ng/_site/ iacus@guayaba2600.com:/var/www/"
  sh command
  
end
  