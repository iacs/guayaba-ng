ruby:
  pkg.installed
  
ruby-dev:
  pkg.installed
  
nodejs:
  pkg.installed
  
imagemagick:
  pkg.installed
  
git:
  pkg.installed
  
bundler:
  gem.installed:
    - require:
      - pkg: ruby
      
rake:
  gem.installed:
    - require:
      - pkg: ruby
      
install_bundle:
  cmd.run:
    - name: bundler install --path .vendor/bundle
    - cwd: /vagrant/
    - require:
      - pkg: ruby
      - pkg: ruby-dev
      - gem: bundler
      
# Configfiles

/home/vagrant/.tmux.conf:
  file.managed:
    - source: salt://files/tmux.conf
    
/home/vagrant/.gitconfig:
  file.managed:
    - source: salt://files/gitconfig
    
/home/vagrant/scripts/tmux-webdev.sh:
  file.managed:
    - source: salt://files/tmux-webdev.sh
    - makedirs: true
    - mode: 755
    
