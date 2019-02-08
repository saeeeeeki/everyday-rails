require 'rails_helper'

RSpec.describe "Projects", type: :system do
  it "creates a new project as a user" do
    user = FactoryBot.create(:user)
    sign_in_as user

    expect {
      click_link "New Project"

      fill_in "project[name]", with: "Test Project"
      fill_in "project[description]", with: "Trying out Capybara"
      click_button "Create Project"
    }.to change(user.projects, :count).by(1)

    aggregate_failures do
      expect(page).to have_content "Project was successfully created"
      expect(page).to have_content "Test Project"
      expect(page).to have_content "Owner: #{user.name}"
    end
  end
end
