require 'rails_helper'

RSpec.describe User, type: :model do

    describe 'Password' do
      it 'Should create a new user without errors' do
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

    describe 'Email' do
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
    it 'returns an instance of the user if authentication is successful' do
      @user = User.new(
        first_name: "First",
        last_name: "Last",
        email: "test@test.com",
        password: "password",
        password_confirmation: "password"
      )
      @user.save

      expect(User.find_by_email("test@test.com")).to eq(@user)
      expect(@user.authenticate("password")).to eq(@user)
    end

    it 'returns false if authentication is not successful (wrong password)' do
      @user = User.new(
        first_name: "First",
        last_name: "Last",
        email: "test@test.com",
        password: "password",
        password_confirmation: "password"
      )
      @user.save

      expect(User.find_by_email("test@test.com")).to eq(@user)
      expect(@user.authenticate("passwordo")).to be false
    end

    it 'returns false if authentication is not successful (wrong email)' do
      @user = User.new(
        first_name: "First",
        last_name: "Last",
        email: "test@test.com",
        password: "password",
        password_confirmation: "password"
      )
      @user.save

      expect(User.find_by_email("testo@test.com")).to be nil
      # expect(@user.authenticate("password")).to be false
    end

  end

      




end

