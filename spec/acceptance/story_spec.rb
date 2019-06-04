require 'rails_helper'

describe Story do

  describe "filtering stories", :type => :feature do

    fixtures :users
    fixtures :stories

    let!(:user) { users(:john) }

    it "profile filtered", js: true do
      visit "/profiles/#{user.id}"

      within('#story_filters') do
        find('#filter').find(:xpath, "option[1]").select_option
      end

      expect(page).to have_css 'section#profile-info'
    end
  end
end
