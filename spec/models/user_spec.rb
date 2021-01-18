require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録/ユーザー情報' do
    context '新規登録できるとき' do
      it 'nicknameとemail、passwordとpassword_confirmationとfirst_nameとfamily_nameとread_firstとread_familyとbirthが存在すれば登録できる' do
        @user.valid?
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'ニックネームが空では登録出来ない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'メールアドレスが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'メールアドレスが一意性でないと登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'メールアドレスは、@を含まないと登録できない' do
        @user.email = 'aa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'パスワードがないと登録できない' do
        @user.password = ''
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'パスワードは、6文字以上での入力でないと登録できない' do
        @user.password = 'abc12'
        @user.password_confirmation = 'abc12'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'パスワードは半角英語のみでは登録できない' do
       @user.password = "abcdefg"
       @user.password_confirmation = "abcdefg"
       @user.valid?
       binding.pry
       expect(@user.errors.full_messages).to include("Password is invalid")
      end
      
      it 'password：全角英数混合は登録できない' do
        @user.password = "Ａbcdefg123"
        @user.password_confirmation = "abcdefg"
        @user.valid?
        binding.pry
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      
      it '半角英数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      
      it 'パスワードは、確認用を含めて2回入力しないと登録できない' do
        @user.password = 'abc123'
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      
      it 'パスワードは、確認用と一致していないと登録できない' do
        @user.password = 'abc123'
        @user.password_confirmation = 'abc456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end
  
  describe 'ユーザー新規登録/本人情報の確認' do
    context '新規登録できないとき' do
      it 'ユーザー本名は、名字がないと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      
      it 'ユーザー本名は、名前がないと登録出来ない' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end
      
      it 'ユーザーの名字は、全角（漢字・ひらがな・カタカナ）での入力でないと登録できない' do
        @user.family_name = "YAMADA"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name is invalid")
      end
      
      it 'ユーザーの名前は、全角（漢字・ひらがな・カタカナ）での入力でないと登録できない' do
        @user.first_name = "TAROU"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end
      
      it 'フリガナは全角カタカナでないと登録できない' do
        @user.read_family = 'ｱ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Read family is invalid")
      end
      
      it 'ユーザーの名字（フリガナ）は全角カタカナ以外は登録できない' do
        @user.read_family = "ｱ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Read family is invalid")
      end
      
      it 'ユーザー名前のフリガナは、空では登録できない' do
        @user.read_first = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Read first can't be blank",)
      end

      it 'ユーザー名字のフリガナは、空では登録できない' do
        @user.read_first = ''
        @user.valid?
        binding.pry
        expect(@user.errors.full_messages).to include("Read first can't be blank",)
      end

      it '生年月日がないと入力出来ない' do
        @user.birth = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth can't be blank")
      end
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'トップページのテスト' do
    it 'ログイン/ログアウト' do
      # トップページに移動する
      visit root_path
      # ログアウト状態では、ヘッダーに新規登録/ログインボタンが表示されること
      expect(page).to have_content('ログイン')
      expect(page).to have_content('新規登録')
      # ヘッダーの新規登録をクリックすることで、各ページに遷移できること
      click_link '新規登録'
      # トップページに遷移する
      visit root_path
      # ヘッダーの新規登録をクリックすることで、各ページに遷移できること
      click_link 'ログイン'
      # 正しいユーザー情報を入力する
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq root_path
      # ログイン状態では、ヘッダーにユーザーのニックネーム/ログアウトボタンが表示されること
      expect(page).to have_content(@user.nickname)
      expect(page).to have_content('ログアウト')
      # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
      # ヘッダーのログアウトボタンをクリックすることで、ログアウトができること
      click_link 'ログアウト'
      # トップページへ遷移することを確認する
      expect(current_path).to eq root_path
    end
  end
end
