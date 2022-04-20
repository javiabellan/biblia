# [Ruby](https://wiki.archlinux.org/title/ruby) 

> Ruby gems are installed inside `.local/share/gem/ruby/3.0.0/gems/`

https://stackoverflow.com/questions/69724440/jekyll-crash-on-generation-segmentation-fault

### Install Jekyll (a Ruby gem)

1) On the home directory:

```bash
sudo pacman -S ruby ruby-rdoc gcc make

# Install the bundler
gem install bundle
```

2) On the project directory (the one containing the `Gemfile` file)

```bash
# install gems of the Gemfile (jekyll, ...)
bundle install

# Lauch page locally
bundle exec jekyll serve --livereload
bundle exec jekyll serve --livereload --watch --baseurl "" --trace`
```