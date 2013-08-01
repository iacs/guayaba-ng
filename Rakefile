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