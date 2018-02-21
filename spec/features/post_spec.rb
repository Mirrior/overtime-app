require 'rails_helper'

describe 'Navigate' do
  before do 
    @user = FactoryBot.create(:user)
    login_as(@user, :scope => :user)
  end

  describe "Index" do
    before do
      visit posts_path
    end
    it "Can be reached successfully" do
      expect(page.status_code).to eq(200)
    end

    it "Has a title of Posts" do
      expect(page).to have_content(/Posts/)
    end

    it "Has a list of posts" do
      post1 = FactoryBot.create(:post)
      post2 = FactoryBot.create(:second_post)
      visit posts_path
      expect(page).to have_content(/Maybe in Russia|Probably in Russia/)
    end
  end

  describe 'new' do
    it 'has a link form the homepage' do
      visit root_path

      click_link("new_post_from_nav")
      expect(page.status_code).to eq(200)
    end
  end

  describe 'Creation' do
    before do
      visit new_post_path
    end

    it 'Has a new form that can be reached' do
      expect(page.status_code).to eq(200)
    end

    it 'Can be created from new form page' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "Some rationale"
      click_on "Save"

      expect(page).to have_content("Some rationale")
    end

    it 'Will have a user associated with it' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "User association"
      click_on "Save"

      expect(User.last.posts.last.rationale).to eq("User association")
    end
  end

  describe 'Edit' do
    before do 
      @post = FactoryBot.create(:post)
    end
    it "can be reached by clicking edit on index page" do
      visit posts_path

      click_link("edit_#{@post.id}")
      expect(page.status_code).to eq(200)
    end

    it 'can be edited' do
      visit edit_post_path(@post)

      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "Edited Content"
      click_on "Save"

      expect(page).to have_content("Edited Content")
    end
  end
end