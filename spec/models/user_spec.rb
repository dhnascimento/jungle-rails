require 'rails_helper'

RSpec.describe User, type: :model do

    describe 'Create user - Form fields' do

      it 'should not create a new user without a first name' do
          @user = User.new(
            first_name: "",
            last_name: "Last",
            email: "test@test.com",
            password: "password",
            password_confirmation: "password"
          )
          @user.save
          expect(@user.errors.full_messages).to include("First name can't be blank")
      end


    it 'should not create a new user without a last name' do
      @user = User.new(
        first_name: "First",
        last_name: "",
        email: "test@test.com",
        password: "password",
        password_confirmation: "password"
      )
      @user.save
      expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
    end

    describe 'Create user - Password' do

      it 'should return an error message if trying to register with empty password' do
        @user = User.new(
          first_name: "First",
          last_name: "Last",
          email: "test@test.com",
          password: "",
          password_confirmation: "password"
        )
        @user.save

        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'should return an error message if trying to register with empty password confirmation' do
        @user = User.new(
          first_name: "First",
          last_name: "Last",
          email: "test@test.com",
          password: "password",
          password_confirmation: ""
        )
        @user.save

        expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
      end

      it 'should create a new user without errors' do
        @user = User.new(
          first_name: "First",
          last_name: "Last",
          email: "test@test.com",
          password: "password",
          password_confirmation: "password"
        )
        @user.save
        expect(@user.errors.full_messages).to be_empty
      end

      it 'should return an error message in case passwords do not match' do
        @user = User.new(
          first_name: "First",
          last_name: "Last",
          email: "test@test.com",
          password: "password",
          password_confirmation: "password1213"
        )
        @user.save
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'should return an error if password lenght is less than 5' do
        @user = User.new(
          first_name: "First",
          last_name: "Last",
          email: "test@test.com",
          password: "pass",
          password_confirmation: "pass"
        )
        @user.save
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
      end

    end

    describe 'Create user - Email' do

      it 'should return an error if trying to register without an email' do
        @user = User.new(
          first_name: "First",
          last_name: "Last",
          email: "",
          password: "password",
          password_confirmation: "password"
        )
        @user.save

        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'should return an error message if trying to register with an email already in the database (not case sensitive)' do
        @user = User.new(
          first_name: "First",
          last_name: "Last",
          email: "test@test.com",
          password: "password",
          password_confirmation: "password"
        )
        @user.save
        
        @user = User.new(
          first_name: "Second",
          last_name: "Late",
          email: "test@test.com",
          password: "password1",
          password_confirmation: "password1"
        )
        @user.save
        expect(@user.errors.full_messages).to include("Email has already been taken")
      end

      it 'should return an error message if trying to register with an email already in the database (case sensitive)' do
        @user = User.new(
          first_name: "First",
          last_name: "Last",
          email: "test@test.com",
          password: "password",
          password_confirmation: "password"
        )
        @user.save
        
        @user = User.new(
          first_name: "Second",
          last_name: "Late",
          email: "TeSt@TEST.com",
          password: "password1",
          password_confirmation: "password1"
        )
        @user.save
        expect(@user.errors.full_messages).to include("Email has already been taken")
      end
  end

  describe '.authenticate' do
    before [:each] do
      @user = User.new(
        first_name: "First",
        last_name: "Last",
        email: "test@test.com",
        password: "password",
        password_confirmation: "password"
      )
      @user.save
    end

      it 'returns an instance of the user if authentication is successful' do

        expect(@user.authenticate_with_credentials("test@test.com", "password")).to eq(@user)
      end

      it 'returns an instance of the user if authentication is successful (email with spaces after and before)' do

        expect(@user.authenticate_with_credentials("    test@test.com   ", "password")).to eq(@user)
      end

      it 'returns an instance of the user if authentication is successful (email not case sensitive)' do

        expect(@user.authenticate_with_credentials("TesT@tEst.cOm", "password")).to eq(@user)
      end

      it 'returns nil if authentication is not successful (wrong password)' do

        expect(@user.authenticate_with_credentials("test@test.com", "passwordo")).to be nil
      end

      it 'returns false if authentication is not successful (wrong email)' do

        expect(@user.authenticate_with_credentials("testo@test.com", "password")).to be nil
      end

  end

end

