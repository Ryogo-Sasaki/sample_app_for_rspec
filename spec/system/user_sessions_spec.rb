require 'rails_helper'

RSpec.describe 'UserSession', type: :system do
  describe 'ユーザーのログイン挙動テスト' do

    describe 'ログイン前' do
      context 'フォームの入力値が正常' do
        it 'ログインが成功する' do
          user = create(:user)
          visit login_path
          fill_in 'Email', with: user.email
          fill_in 'Password', with: 'password'
          click_button('Login')
          expect(current_path).to eq(root_path)
          expect(page).to have_content 'Login successful'
        end
      end
      context 'フォームが未入力' do
        it 'ログインが失敗する' do
          visit login_path
          fill_in 'Email', with: nil
          fill_in 'Password', with: 'password'
          click_button('Login')
          expect(current_path).to eq(login_path)
          expect(page).to have_content 'Login failed'
        end
      end
      describe 'ログイン後' do
        context 'ログアウトボタンをクリック' do
          it 'ログアウト処理が成功する' do
            user = create(:user)
            visit login_path
            fill_in 'Email', with: user.email
            fill_in 'Password', with: 'password'
            click_button('Login')
            click_link('Logout')
            expect(current_path).to eq(root_path)
            expect(page).to have_content 'Logged out'
            expect(page).to have_content 'Tasks'
          end
        end
      end
    end
  end
end
