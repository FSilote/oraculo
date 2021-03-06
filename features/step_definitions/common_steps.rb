Given /^(?:|I am )signed in$/ do
  @user = User.create!(email: "joao@example.com", password: "thePassword", name: "Joao")
  @user.confirm!
  When %Q{I sign in as "joao@example.com/thePassword"}
end

Given /^I am not signed in$/ do
  visit "/"
  click_link "Sign Out"
end

Then /should see success message/ do
  page.should have_css(".notice")
end

Then /^I should see error messages$/ do
  page.body.should match(/error_explanation/m)
end

Then /^an email with subject "([^"]*)" should have been sent to (.*)$/ do |subject, email|
  sent = ActionMailer::Base.deliveries.last
  sent.subject.should == subject
  sent.to.first.should == email
end
