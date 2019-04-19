# MultiMeet
<a href="https://codeclimate.com/github/Aakup/MultiMeet-1/maintainability"><img src="https://api.codeclimate.com/v1/badges/17147a80811321af3566/maintainability" /></a>

<a href="https://codeclimate.com/github/Aakup/MultiMeet-1/test_coverage"><img src="https://api.codeclimate.com/v1/badges/17147a80811321af3566/test_coverage" /></a>

<a href="https://travis-ci.org/Aakup/MultiMeet"><img src="https://travis-ci.org/Aakup/MultiMeet.svg?branch=master"></a>

<a href="http://multi-meet.herokuapp.com/"><img


## Dependencies
- Ruby 2.4.0
- Rails 4.2.10

## Development Quickstart
1. clone repo: `git clone https://github.com/Aakup/MultiMeet`
2. `cd MultiMatch`
3. install packages: `bundle install --without production`
4. setup db: `rake db:setup db:migrate`
5. seed db: `rake db:seed`
6. `rails s(erver)` --> starts app on [http://localhost:3000](http://localhost:3000)

## Development Guidelines
- develop on your own branch of this repo, call it by your <name/feature> e.g. kevin/projects-list
- write your own tests for your own feature
- write down cucumber scenarios before coding
- before you push: make sure tests run via `bundle exec rspec` and `bundle exec cucumber features`
- push the branch, then PR to master, and wait for a code review
- in case of merge conflict: pull from master, resolve locally, push to your branch.

- TODO: add linter

### DB migrations
- if making db changes:
  - run `db:migrate` and check in your new `schema.rb`
  - to completely overwrite schema and migrations: `rake db:drop db:create db:migrate db:seed`
- each time you pull and there's a migration: run `db:migrate` or `db:reset`
