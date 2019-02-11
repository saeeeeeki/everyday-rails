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

  it "completes a user's project" do
    # プロジェクトを持ったユーザーを準備する
    user = FactoryBot.create(:user)
    project = FactoryBot.create(:project, owner: user)
    sign_in user

    # ユーザーはログインする
    visit project_path(project)

    expect(page).to_not have_content "Completed"

    click_button "Complete"

    # ユーザーがプロジェクト画面を開き、completeボタンをクリックすると、プロジェクトは完了済みとしてマークされる
    expect(project.reload.completed?).to be true
    expect(page).to have_content "Congratulations, this project is complete!"
    expect(page).to have_content "Completed"
    expect(page).to_not have_button "Complete"
  end
end
