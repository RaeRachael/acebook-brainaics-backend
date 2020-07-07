require 'rails_helper'
require_relative '../../support/features/chat_helpers.rb'

RSpec.feature "Edit", type: :feature do
  scenario "user can write a message", :focus => true do
    sign_in
    visit '/rooms/show'
    expect(page).to have_content('make a scream')
  end

  scenario "user can write a message" do
    writes_a_message
    expect(page).to have_content(/Hello, world!/)
  end
end