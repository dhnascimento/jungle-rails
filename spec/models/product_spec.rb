require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before (:each) do
      @category = Category.new(id: 1, name: 'Bogus')
      @category.save
    end

      it "should create a new product with a name" do
        @product = Product.new(
          name:"Product"
        )
      expect(@product.name).to eq("Product")
      end

      it "should create a new product with a description" do
        @product = Product.new(
          description:"Description"
        )
      expect(@product.description).to eq("Description")
      end

      it "should create a new product with a description" do
        @product = Product.new(
          description:"Description"
        )
      expect(@product.description).to eq("Description")
      end

      it "should create a new product with quantity" do
        @product = Product.new(
          quantity: 1
        )
      expect(@product.quantity).to eq(1)
      end

      it "should create a new product with a category and category_id" do
        @product = @category.products.new(
        )
      expect(@product.category).to eq(@category)
      expect(@product.category_id).to eq(1)
      end

      it "should create a new product with a price" do
      @product = Product.new(
        price: 100
      )
      expect(@product.price).to eq(100)
      end
    
  end

  describe "Error messages" do
    before (:each) do
      @category = Category.new(id: 1, name: 'Bogus')
    end

      it "Should return the 'Name can't be blank' error if name = nil" do
        @product = Product.new(
          name: nil,
          description: "Description",
          category: @category,
          quantity: 2,
          image: "url",
          price: 100
        )
        @product.save
        expect(@product.errors.full_messages).to include("Name can't be blank")
      end

      it "Should return the 'Quantity can't be blank' error if quantity = nil" do
        @product = Product.new(
          name: "Name",
          category: @category,
          quantity: nil,
          price: 100
        )
        @product.save
        expect(@product.errors.full_messages).to include("Quantity can't be blank")
      end

        it "Should return the '[Price cents is not a number, Price is not a number, Price can't be blank]' array error if price = nil" do
          @product = Product.new(
            name: "Name",
            category: @category,
            quantity: 1,
            price: nil
          )
          @product.save
          expect(@product.errors.full_messages).to eq(["Price cents is not a number", "Price is not a number", "Price can't be blank"])
        end

        it "Should return the Price is not a number' array error if price = '2'" do
          @product = Product.new(
            name: "Name",
            category: @category,
            quantity: 1,
            price: "A"
          )
          @product.save
          expect(@product.errors.full_messages).to include("Price is not a number")
        end
      
  end
end


