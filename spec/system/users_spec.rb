require "rails_helper"

RSpec.describe "Users", type: :system do

  describe "ユーザーの挙動テスト" do
    let(:other_user) { (create(:user)) }
    byebug

    describe "ログイン前のケース" do
      describe "ユーザー新規登録画面" do
        context "フォーム入力値が全て正しい時" do
          it "ユーザー新規作成に成功する" do
            user = build(:user)
            visit new_user_path
            fill_in 'Email', with: user.email
            fill_in 'Password', with: 'password'
            fill_in 'Password confirmation', with: 'password'
            click_button('SignUp')
            expect(page).to have_content 'User was successfully created'
            byebug
          end
        end
        context 'メールアドレスが未入力' do
          it 'ユーザーの新規作成が失敗する' do
            visit new_user_path
            fill_in 'Email', with: nil
            fill_in 'Password', with: 'password'
            fill_in 'Password confirmation', with: "password"
            click_button('SignUp')
            expect(page).to have_content "Email can't be blank"
            byebug
          end
        end

        context '登録済メールアドレスを使用' do
          it 'ユーザーの新規作成が失敗する' do
            visit new_user_path
            fill_in 'Email', with: user.email
            fill_in 'Password', with: 'password'
            fill_in 'Password confirmation', with: 'password'
            click_button('SignUp')
            expect(page).to have_content "Email has already been taken"
          end
        end
      end


      describe 'マイページ' do
        context 'ログインしていない状態' do
          it 'マイページへのアクセスが失敗する' do
            visit edit_user_path(user)
            expect(page).to have_content 'Login required'
          end
        end
      end
    end

    describe 'ログイン後' do
      describe 'ユーザー編集' do
        context 'フォームの入力値が正常' do
          it 'ユーザーの編集ができる' do
            visit login_path
            fill_in 'Email', with: user.email
            fill_in 'Password', with: 'password'
            click_button 'Login'
            visit edit_user_path(user)
            fill_in 'Email', with: 'testtest@gmail.com'
            fill_in 'Password', with: 'passwordpassword'
            fill_in 'Password confirmation', with: 'passwordpassword'
            click_button('Update')
            expect(page).to have_content 'User was successfully updated.'
          end
        end
      end

      context 'メールアドレスが未入力時に' do
        it 'ユーザーの編集が失敗する' do
          user = create(:user)
          visit login_path
          fill_in 'Email', with: user.email
          fill_in 'Password', with: 'password'
          click_button 'Login'
          visit edit_user_path(user)
          fill_in 'Email', with: ''
          fill_in 'Password', with: 'passwordpassword'
          fill_in 'Password confirmation', with: 'passwordpassword'
          click_button('Update')
          expect(page).to have_content "Email can't be blank"
        end
      end

      context '登録済メールアドレスを使用' do
        it 'ユーザーの編集が失敗' do
          login(other_user)
          # other_user = create(:user)
          # visit login_path
          # fill_in 'Email', with: user.email
          # fill_in 'Password', with: 'password'
          # click_button 'Login'
          visit edit_user_path(other_user)
          fill_in 'Email', with: user.email
          fill_in 'Password', with: 'passwordbbb'
          fill_in 'Password confirmation', with: 'passwordbbb'
          click_button('Update')
          expect(page).to have_content 'Email has already been taken'
          byebug
        end
      end
      context '他ユーザーの編集ページにアクセス' do
        it 'アクセスが失敗する' do
          user = create(:user)
          visit login_path
          fill_in 'Email', with: user.email
          fill_in 'Password', with: 'password'
          click_button('Login')
          visit edit_user_path(other_user)
          expect(page).to have_content 'Forbidden access'
        end
      end
    end

    describe 'マイページ' do
      context 'タスクを作成' do
        it '新規作成したタスクが表示される' do
          user = create(:user)
          visit login_path
          fill_in 'Email', with: user.email
          fill_in 'Password', with: 'password'
          click_button('Login')
          visit_user_path(user)
          expect(page).to have_content 'タスク➀'
        end
      end
    end
  end
end
