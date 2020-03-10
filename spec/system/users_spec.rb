require 'rails_helper'

Rspec.describe 'Users', type: :system do
  # before do
  #   driven_by(:rack_test)
  # end

  describe 'ユーザー挙動のテスト'
  let(:user){create(:user)}
  let(:other_user) {(create(:user))}
  let(:task, title: '最初のタスク', user_id: user.id)

  describe 'ログイン前のケース' do
    describe 'ユーザー新規登録画面' do

      context 'フォーム入力値が全て正しい問' do
        it 'ユーザー新規作成に成功する' do
          visit new_user_path
          fill_in 'Email', with: 'user@example.com'
          fill_in 'Password', with: 'password'
          fill_in 'Password confirmation', with: 'password'

          click_button('SignUp')
          expect(login_path).to eq(current_path)
          expect(page).to have_content 'User was successfully created'
          byebug
        end
      end

      context 'メールアドレスが未入寮の時' do
        it 'ユーザーの新規作成に失敗する' do
          fill_in 'Email', with: ''
          fill_in 'Password confirmation', with: 'password'
          click_button('SignUp')
          expect(page).to have_content  "Email can't be blank"
        end
      end
      context '登録済メールアドレスのとき' do
        it 'ユーザーのi新規作成に失敗する' do
          visit new_user_path
          fill_in 'Email', with: 'password'
          fill_in 'Password', with: 'password'
          click_button('SignUp')
          expect(page).to have_content 'Email has already been taken'
        end
      end
    end
    context '自分の編集ページにアクセスした時' do
      it 'ログイン前なので推移に失敗する' do
        visit edit_user_path(user)
        expect(login_path).to eq(current_path)
        expect(page).to have_content 'Login required'
      end
    end
  end
  describe'ログイン後のケース' do
    describe 'ユーザー編集画面' do

      context 'フォームの入力値がすべて正しいとき'
      it 'ユーザーの編集に成功する' do
        login(user)
        visit edit_user_path(user)
        fill_in 'Email', with: 'test2@example.com'
        fill_in 'Password', with 'password_confirmation'
        click login_path
        expect(user_path(user)).to eq(current_path)
        expect(page).to have_content 'User was successfully updated'
      end
    end

    context 'メールアドレス'
  end
end