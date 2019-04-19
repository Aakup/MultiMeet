Given /^no current user$/ do
    page.driver.submit :delete, "/logout", {}
end

Given /^a registered user with the email "(.*)" with username "(.*)" exists$/ do |email, username|
    User.create(:username => username, :email => email, :first_name => "Daniel",
    :last_name => "Lee", :password => "password", :password_confirmation => "password")
end

Given /^a registered user with the email "(.*)" with password "(.*)" exists$/ do |email, password|
    User.create(:username => "ddd", :email => email, :first_name => "Daniel",
    :last_name => "Lee", :password => password, :password_confirmation => password)
end

Given /^a user with the email "(.*)" with password "(.*)" and with username "(.*)" exists$/ do |email, password, username|
    User.create(:username => username, :email => email, :first_name => "Daniel",
                :last_name => "Lee", :password => password, :password_confirmation => password)
end

Given /^a registered user with the username "(.*)" has a project named "(.*)"$/ do |username, project_name|
  user = User.find_by(:username => username)
  user.projects.create(:project_name => project_name, :duration => 60)
end

Given("a project of id {string} with date {string} and time {string} and duration {string}") do |id, date, time, duration|
    project = Project.find(id)
    project.update(duration: duration)
    ProjectTime.create(:project_id => id, :date_time => Date.parse(date), :is_date => true)
    ProjectTime.create(:project_id => id, :date_time => Time.parse(time), :is_date => false)
end

When /^I access the landing page$/ do
    get "/"
end

When /^I access the matchings page for project of id "(.*)"$/ do |id|
    visit "/projects/" + id + "/matching"
end

When /^I press the roster bottom for project of id "(.*)"$/ do |id|
    visit "/projects/" + id + "/participants"
end

When /^I press the edit bottom for project of id "(.*)"$/ do |id|
    visit "/projects/" + id + "/edit"
end

When /^I press the delete bottom for participant of email "(.*)" and project id of "(.*)"$/ do |email, id|
    Participant.find_by(:project_id => id, :email => email)
    Participant.delete(:email => email)
end

When /^I access the times page for project of id "(.*)"$/ do |id|
    visit "/projects/" + id + "/times"
end

When("I click the second show") do
    page.all("a.btn btn-info")[1].click
end

Given /^a default matching exists for project with id "(.*)"$/ do |id|
      multimatch_121_output = {
        "schedule": [
            {
                "event_name": "Person3-0",
                "people_called": [
                    "Person3"
                ],
                "timestamp": "Fri, 22 Mar 2019 13:00:00 GMT"
            },
            {
                "event_name": "Person1-0",
                "people_called": [
                    "Person1"
                ],
                "timestamp": "Fri, 22 Mar 2019 14:00:00 GMT"
            },
            {
                "event_name": "Person2-0",
                "people_called": [
                    "Person2"
                ],
                "timestamp": "Fri, 22 Mar 2019 15:00:00 GMT"
            }
        ]
    }
    Matching.create(project_id: id, output_json: multimatch_121_output.to_json)

end
