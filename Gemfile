source 'https://rubygems.org'

ruby File.read('.ruby-version')

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'arel', github: 'rails/arel'
gem 'rails', github: 'rails/rails'
