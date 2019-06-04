require 'rails_helper'

describe 'Story', type: :feature, js: true do
  fixtures :users
  fixtures :stories

  let!(:user) { users(:john) }

  context 'filtering stories' do
    before do
      visit profile_path(user)

      select 'todos', from: 'filter'
    end

    it 'profile filtered' do
      expect(page).to have_css 'section#profile-info'
    end
  end
end
