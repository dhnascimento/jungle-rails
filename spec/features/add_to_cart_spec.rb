require 'rails_helper'

RSpec.feature "Visitor add a product to cart", type: :feature, js: true do
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
  scenario "User clicks on the 'Add' button and My Cart increases by one" do

    visit root_path

    expect(page).to have_content("My Cart (0)")
    save_screenshot("add_cart_home_page.png")
    first(:button, 'Add').click

    save_screenshot("add_cart_product_added.png")
    expect(page).to have_content("My Cart (1)")
  end
end
