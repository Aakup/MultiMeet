Given /^a participant to project "(.*)" with email "(.*)" has a secretid "(.*)"$/ do |project_name, email, secret_id|
  project = Project.find_by(:project_name => project_name)
  project_id = project[:id]

  participant = Participant.find_by(:project_id => project_id, :email => email)

  participant.secret_id = secret_id
end

When /^I access the time ranking page for project "(.*)" from email "(.*)" and secretid "(.*)"$/ do |project_name, email, secret_id|

  project = Project.find_by(:project_name => project_name)
  project_id = project[:id]

  participant = Participant.find_by(:project_id => project_id, :email => email)
  participant_id = participant[:id]

  visit "/projects/" + project_id.to_s + "/participants/" + participant_id.to_s + "/ranking/edit?secret_id=" + secret_id
end

When /^I access the time ranking page for project of id "(.*)" from user id "(.*)" and secretid "(.*)"$/ do |projectid, userid, secret_id|

  project_id = projectid.to_i
  participant_id = userid.to_i

  visit "/projects/" + project_id.to_s + "/participants/" + participant_id.to_s + "/ranking/edit?secret_id=" + secret_id
end

When /^I choose "(.*)" for time "(.*)"$/ do |option, time|
  time = ProjectTime.find_by(:date_time => Time.parse(time))
  if option.eql?("Preferred")
    choose(time.id.to_s, option: "1") # name and value to make unique
  elsif option.eql?("Okay")
    choose(time.id.to_s, option: "2") # name and value to make unique
  else
    choose(time.id.to_s, option: "3") # name and value to make unique
  end
end
