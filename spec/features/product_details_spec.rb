require 'rails_helper'

RSpec.feature "Visitor navigates to product page", type: :feature, js: true do
  before [:each] do 
    @category = Category.create!(name: 'Apparel')
    
    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image:  open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

    scenario "User clicks on product at home page and goes to product's description page" do
      
      visit root_path
      save_screenshot("product_home_page.png")
      first(:link, 'Details').click
      find('section.products-show')
      
      save_screenshot("product_product_page.png")
      expect(page).to have_css '.product-detail'
    end


end
