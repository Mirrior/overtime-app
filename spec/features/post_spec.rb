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
      post1 = FactoryBot.create(:post, user_id: @user.id)
      post2 = FactoryBot.create(:second_post, user_id: @user.id)
      visit posts_path
      expect(page).to have_content(/Maybe in Russia|Probably in Russia/)

    end

    it 'has a scope so that only post creators can see there posts' do
      post1 = Post.create(date: Date.today, rationale: "Nooooo work", user_id: @user.id)
      post2 = Post.create(date: Date.today, rationale: "Nooooo work", user_id: @user.id)

      other_user = User.create(first_name: "Non",
                                        last_name: "Authorized",
                                        email: "something@from.hell",
                                        password: "asdfasdf",
                                        password_confirmation: "asdfasdf"
                                       )
      post_from_other_user = Post.create(date: Date.today, rationale: "This shouldn't be seen", user_id: other_user.id)

      visit posts_path

      expect(page).to_not have_content(/This shouldn't be seen/)
    end
  end

  describe 'new' do
    it 'has a link form the homepage' do
      visit root_path

      click_link("new_post_from_nav")
      expect(page.status_code).to eq(200)
    end
  end

  describe 'Delete' do
    it 'can be deleted' do
      @post = FactoryBot.create(:post)
      @post.update(user_id: @user.id)
      visit posts_path

      click_link("delete_post_#{@post.id}_from_index")
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
      @post = FactoryBot.create(:post, user_id: @user.id)
    end

    it 'Can be edited' do
      visit edit_post_path(@post)

      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "Edited Content"
      click_on "Save"

      expect(page).to have_content("Edited Content")
    end

    it 'cannot be edited by a non authorized user' do
      logout(:user)
      non_authorized_user = FactoryBot.create(:non_authorized_user)
      login_as(non_authorized_user, :scope => :user)

      visit edit_post_path(@post)

      expect(current_path).to eq(root_path)
    end
  end
end