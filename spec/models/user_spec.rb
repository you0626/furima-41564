require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it '全ての項目が正しく入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      context 'ニックネーム関係' do
        it 'nicknameが空では登録できない' do
          @user.nickname = ''
          @user.valid?
          expect(@user.errors.full_messages).to include "Nickname can't be blank"
        end
      end

      context 'メールアドレス関係' do
        it 'emailが空では登録できない' do
          @user.email = ''
          @user.valid?
          expect(@user.errors.full_messages).to include "Email can't be blank"
        end

        it '重複したemailが存在する場合は登録できない' do
          @user.save
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
      end

      context 'パスワード関係' do
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

        it 'passwordが英字のみでは登録できない' do
          @user.password = 'abcdef'
          @user.password_confirmation = 'abcdef'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
        end

        it 'passwordが数字のみでは登録できない' do
          @user.password = '123456'
          @user.password_confirmation = '123456'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
        end

        it 'passwordが全角文字では登録できない' do
          @user.password = 'ＡＢＣ１２３'
          @user.password_confirmation = 'ＡＢＣ１２３'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
        end
      end

      context '名前関係' do
        it 'first nameが空白の場合は無効であること' do
          @user.first_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("First name can't be blank")
        end

        it 'first nameが全角でない場合は無効であること' do
          @user.first_name = 'abc'
          @user.valid?
          expect(@user.errors.full_messages).to include('First name is invalid. Input full-width characters')
        end

        it 'last nameが空白の場合は無効であること' do
          @user.last_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name can't be blank")
        end

        it 'last nameが全角でない場合は無効であること' do
          @user.last_name = 'xyz'
          @user.valid?
          expect(@user.errors.full_messages).to include('Last name is invalid. Input full-width characters')
        end

        it 'first name katakanaが空白の場合は無効であること' do
          @user.first_name_katakana = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("First name katakana can't be blank")
        end

        it 'first name katakanaが全角カタカナでない場合は無効であること' do
          @user.first_name_katakana = 'あああ'
          @user.valid?
          expect(@user.errors.full_messages).to include('First name katakana is invalid. Input full-width katakana characters')
        end

        it 'last name katakanaが空白の場合は無効であること' do
          @user.last_name_katakana = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name katakana can't be blank")
        end

        it 'last name katakanaが全角カタカナでない場合は無効であること' do
          @user.last_name_katakana = 'いろは'
          @user.valid?
          expect(@user.errors.full_messages).to include('Last name katakana is invalid. Input full-width katakana characters')
        end
      end

      context '生年月日関係' do
        it 'birthが空白の場合は無効であること' do
          @user.birth = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Birth can't be blank")
        end
      end
    end
  end
end
