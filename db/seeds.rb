# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# seed Users
users_list = [
    [ "Armando", "Fox", "afox", "armando@berkeley.edu", "ilove169"],
    [ "Jane", "Doe", "jdoe", "janedoe@average.com", "skrskr"]
]

users_list.each do |first, last, username, email, password|
  User.create(first_name: first, last_name: last, username: username,
              email: email, password_digest: BCrypt::Password.create(password),
              password: password, password_confirmation: password)
end

# seed Projects
projects_list = [
    [1, "CS 61A Sections", "jdoe"],
    [2, "169 Meeting Times", "afox"],
    [3, "Midterm Grading Sessions", "afox"],
    [4, "EE 16A Lab Assisting", "jdoe"]
]

projects_list.each do |id, name, username|
  Project.create(id: id, project_name: name, username: username)
end

# seed
