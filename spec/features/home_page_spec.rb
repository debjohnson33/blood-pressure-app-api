require 'rails_helper'

describe 'Home Page', js: true do
	
	it 'should display an h1 tag with "Welcome to Blood Pressure App"' do
		visit '/'

		expect(page).to have_css("h1", text: "Welcome to Blood Pressure App")
	end 
end