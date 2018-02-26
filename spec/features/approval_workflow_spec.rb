require 'rails_helper'

describe 'Navigate' do 
  before do
    @admin_user = FactoryBot.create(:admin_user)
    login_as(@admin_user, :scope => :user)
  end

  describe 'Edit' do
    before do
      @post = FactoryBot.create(:post)
    end

    it 'has a status that can edited on the form' do
      visit edit_post_path(@post)

      choose 'post_status_approved'
      click_on 'Save'

      expect(@post.reload.status).to eq('approved')
    end
  end
end