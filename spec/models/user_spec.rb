require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    it 'nicknameが空では登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Nickname can't be blank"
    end

    it 'emailが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end

    it 'passwordが空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'passwordとpassword_confirmationが不一致では登録できない' do
      @user.password = '123456'
      @user.password_confirmation = '1234567'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'First nameが空白の場合は無効であること' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'First nameが全角でない場合は無効であること' do
      @user.first_name = 'abc'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name is invalid. Input full-width characters')
    end

    it 'Last nameが空白の場合は無効であること' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'Last nameが全角でない場合は無効であること' do
      @user.last_name = 'xyz'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name is invalid. Input full-width characters')
    end

    it 'First name katakanaが空白の場合は無効であること' do
      @user.first_name_katakana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name katakana can't be blank")
    end

    it 'First name katakanaが全角カタカナでない場合は無効であること' do
      @user.first_name_katakana = 'あああ'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name katakana is invalid. Input full-width katakana characters')
    end

    it 'Last name katakanaが空白の場合は無効であること' do
      @user.last_name_katakana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name katakana can't be blank")
    end

    it 'Last name katakanaが全角カタカナでない場合は無効であること' do
      @user.last_name_katakana = 'いろは'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name katakana is invalid. Input full-width katakana characters')
    end

    it 'Birthが空白の場合は無効であること' do
      @user.birth = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth can't be blank")
    end

    it '重複したemailが存在する場合は登録できない' do
      @user.save
      expect(@user).to be_persisted
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'emailは@を含まないと登録できない' do
      @user.email = 'testmail'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end

    it 'passwordが5文字以下では登録できない' do
      @user.password = '00000'
      @user.password_confirmation = '00000'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'passwordが129文字以上では登録できない' do
      @user.password = Faker::Internet.password(min_length: 129, max_length: 150)
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
    end
  end
end
