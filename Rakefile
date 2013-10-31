require 'rubygems'
require 'optparse'
require 'yaml'
require 'fileutils'

task :review do
  OptionParser.new.parse!
  ARGV.shift
  title = ARGV.join(' ')

  path = "_drafts/#{title}/#{Date.today}-#{title.downcase.gsub(/[^[:alnum:]]+/, '-')}.textile"
  
  if File.exist?(path)
    puts "[WARN] File exists - skipping create"
  else
    FileUtils.mkdir_p("_drafts/#{title}/")
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

desc "Build site using Jekyll"
task :build do
  jekyll "build"
end

desc "Deploy site"
task :deploy => :build do
  rsync "/var/www/guayaba2600.com/"
end

def jekyll(opts="")
  #sh "rm -rf _site"
  sh "jekyll " + opts
end

def rsync(domain)
  #sh "rsync -rtz --delete --delete-after _site/ iacus@guayaba2600.com:#{domain}"
  sh "rsync -Oavtr --no-g --no-perms --delete --delete-after _site/ iacus@guayaba2600.com:#{domain}"
end

task :olddeploy do
  
  command = "jekyll build && rsync -avr -e 'ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null' --delete --delete-after --log-file=/home/iacusm/data/logs/rsync-guayaba.log /home/iacusm/data/web/guayaba-ng/_site/ iacus@guayaba2600.com:/var/www/guayaba2600.com/"
  sh command
  
end
  