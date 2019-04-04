# MultiMeet
<a href="https://codeclimate.com/github/Aakup/MultiMeet-1/maintainability"><img src="https://api.codeclimate.com/v1/badges/17147a80811321af3566/maintainability" /></a>

<a href="https://codeclimate.com/github/Aakup/MultiMeet-1/test_coverage"><img src="https://api.codeclimate.com/v1/badges/17147a80811321af3566/test_coverage" /></a>

<a href="https://travis-ci.org/Aakup/MultiMeet-1"><img src="https://travis-ci.org/Aakup/MultiMeet-1.svg?branch=master">

## Dependencies
- Ruby 2.4.0
- Rails 2.4.10

## Development Quickstart
1. clone repo: `git clone https://github.com/Aakup/MultiMeet-1`
2. `cd MultiMatch`
3. install packages: `bundle install --without production`
4. setup db: `rake db:setup db:migrate`
5. seed db: `rake db:seed`
6. `rails s(erver)` --> starts app on http://localhost:3000

## Development Guidelines
- develop on your own branch of this repo, call it by your <name/feature> e.g. kevin/projects-list
- write your own tests for your own feature
- before you push: make sure tests run via `rspec` and `cucumber features`
- push the branch, then PR to master, and wait for a code review
- only merge if travis passes for PR
- in case of merge conflict: follow Github instructions for resolving merge conflict.

- TODO: add linter

### DB migrations
- if making db changes:
  - run `db:migrate` and check in your new `schema.rb`
  - to completely overwrite schema and migrations: `rake db:drop db:create db:migrate db:seed`
- each time you pull and there's a migration: run `db:migrate` or `db:reset`
