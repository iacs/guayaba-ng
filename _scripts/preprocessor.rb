# require 'optparse'
require 'yaml'
require 'pathname'
require 'fileutils'
require 'mini_magick'

def load_settings(settings_file)
  abs_path = File.join(File.expand_path(File.dirname(__FILE__)),settings_file)
  settings_file_obj = File.open(File.join(abs_path), 'r')
  @settings = YAML.load(settings_file_obj)  
  @path_covers = @settings['path_covers']
  @path_ss = @settings['path_ss']
  @path_reviews = @settings['path_reviews']
  @url_ss = @settings['url_ss']
end

def parse_options()
  @filename = ARGV.pop()
  raise 'Missing post file' unless @filename
end


begin
  load_settings('settings_pp.yml')

  parse_options

  dirname, basename = Pathname.new(@filename).split
  dirname = File.expand_path(dirname)
  postname, ext = basename.to_s.split('.')
  imgdir = File.join(dirname, postname)

  # Create image directory
  if !Dir.exists?(imgdir)
    FileUtils::mkdir_p imgdir
    puts "Created"
  end

  newfilepath = File.join(dirname, postname)
  newfilepath = "#{newfilepath}-tmp.#{ext}"

  f = File.open(@filename, 'r')
  g = File.open(newfilepath, 'w')
  puts "Creando archivo #{newfilepath}"
  
  # hacky initialization (sorry)
  coverfile = ""

  f.each_line do |line|
    if (line.start_with?("!") and line.end_with?("!\n"))
      imgfile = line.sub("!\n","")
      imgfile = line.sub("!", "")
      imgfile, ext = imgfile.split('.')
      newline = "p(pagination-centered). !(entry-screen)#{@settings['url_ss']}#{postname}/#{imgfile}-th.jpg!:#{@settings['url_ss']}#{postname}/#{imgfile}.#{ext}\n"
      g.puts(newline)
    elsif (line.start_with?("cover: "))
      coverfile = line.gsub("cover: ", "")
      coverfile.strip!
      @coverpath = File.join(dirname, coverfile)
      g.puts(line)
    else
      g.puts(line)
    end
  end

  # Done with text files
  f.close()
  g.close()

  # Rename files
  og_name = f.path
  File.rename(f.path, "#{f.path}-orig")
  File.rename(g.path, og_name)

  # Moving files to their place
  dirs = File.absolute_path(__FILE__).split(File::SEPARATOR).map {|x| x=="" ? File::SEPARATOR : x}
  dest_sshots = File.join("/", dirs[1], @path_ss, postname)
  dest_review = File.join("/", dirs[1], @path_reviews, basename)
  
  FileUtils.mv(@coverpath, dest_cover)

  # Convert images
  thumb_geometry = @settings['thumbnail_geometry']
  start_dir = Pathname.new(File.absolute_path(__FILE__)).dirname

  Dir.chdir(dirname)

  Dir["#{dirname}/*"].each do |image_filepath|
    img_name, img_ext = image_filepath.split('.')
    image_thumb_filepath = "#{img_name}-th.jpg"
    if (img_ext == 'jpg' or img_ext == '.png')
      img = MiniMagick::Image.open(image_filepath)
      img.combine_options do |o|
        o.resize(thumb_geometry)
      end
      img.format 'jpg'
      img.write(image_thumb_filepath)
      tmp_pn = Pathname.new(image_filepath)
      dest_f = File.join(tmp_pn.dirname, postname, tmp_pn.basename)
      puts dest_f
      tmp_pn = Pathname.new(image_thumb_filepath)
      dest_t = File.join(tmp_pn.dirname, postname, tmp_pn.basename)
      FileUtils.mv(image_filepath, dest_f)
      FileUtils.mv(image_thumb_filepath, dest_t)
    end
  end

  Dir.chdir(start_dir)

  # Moving the last files
  origin_review = File.join("/", dirs[1], @filename)
  FileUtils.mv(imgdir, dest_sshots)
  FileUtils.mv(origin_review, dest_review)

  # Fin

end
