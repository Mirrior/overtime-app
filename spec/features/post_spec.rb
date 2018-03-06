require 'rails_helper'

describe 'Navigate' do
  let(:user) {FactoryBot.create(:user) }

  let(:post) do
    Post.create(date: Date.today, rationale: "Maybe in Russia", user_id: user.id, overtime_request: 3.5)
  end

  before do 
    login_as(user, :scope => :user)
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
      post1 = FactoryBot.create(:post, user_id: user.id)
      post2 = FactoryBot.create(:second_post, user_id: user.id)
      visit posts_path
      expect(page).to have_content(/Maybe in Russia|Probably in Russia/)
    end

    it 'has a scope so that only post creators can see there posts' do
      other_user = User.create(first_name: "Non", last_name: "Authorized", email: "something@from.hell", password: "asdfasdf", password_confirmation: "asdfasdf", phone: "5555555555")
      post_from_other_user = Post.create(date: Date.today, rationale: "This shouldn't be seen", user_id: other_user.id, overtime_request: 3.5)

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
      logout(:user)

      delete_user = FactoryBot.create(:user)
      login_as(delete_user, :scope => :user)

      post_to_delete = Post.create(date: Date.today, rationale: "asdfasdf", user_id: delete_user.id, overtime_request: 2.5)

      visit posts_path

      click_link("delete_post_#{post_to_delete.id}_from_index")
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
      fill_in 'post[overtime_request]', with: 4.5

      expect{ click_on "Save" }.to change(Post, :count).by(1)
    end

    it 'Will have a user associated with it' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "User association"
      fill_in 'post[overtime_request]', with: 4.5
      click_on "Save"

      expect(User.last.posts.last.rationale).to eq("User association")
    end
  end

  describe 'Edit' do

    it 'Can be edited' do
      visit edit_post_path(post)

      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "Edited Content"
      click_on "Save"

      expect(page).to have_content("Edited Content")
    end

    it 'cannot be edited by a non authorized user' do
      logout(:user)
      non_authorized_user = FactoryBot.create(:non_authorized_user)
      login_as(non_authorized_user, :scope => :user)

      visit edit_post_path(post)

      expect(current_path).to eq(root_path)
    end
  end
end