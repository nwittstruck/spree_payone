require 'spec_helper'

RSpec.feature "Navigation Integration", type: :feature do
  stub_authorization!

  it 'Spree main navigation has tab for payone extension' do
    visit spree.admin_path

    within('#main-sidebar') do
      expect(page).
        to have_selector("a[href=\"#{spree.edit_admin_payone_settings_path}\"]")
      expect(page).
        to have_selector("a[href=\"#{spree.admin_payone_docs_path}\"]")
      expect(page).
        to have_selector("a[href=\"#{spree.admin_payone_logs_path}\"]")
    end
  end
end
