require "rails_helper"

RSpec.describe "Users", type: :system do

  describe "ユーザーの挙動テスト" do
    let(:user) { create(:user) }
    let(:other_user) { (create(:user)) }
    let(:task) { create(:task, title: "最初のタスク", user_id: user.id) }

    describe "ログイン前のケース" do
      describe "ユーザー新規登録画面" do
        # 正常系
        # TODO visit~ clickまでは共通化もできそうだが保留
        context "フォーム入力値が全て正しい時" do
          fit "ユーザー新規作成に成功する" do
            user = create(:user)
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
            byebug
          end
        end

        context '登録済メールアドレスを使用' do
          fit 'ユーザーの新規作成が失敗する' do
            visit new_user_path
            fill_in 'Email', with user.email
            fill_in 'Password', with: 'password'
            fill_in 'Password confirmation', with 'passeword'
            click_button('Signup')
            expect(page).to have_content "Email can't be blank"
          end
        end

        describe 'マイページ' do
          context 'ログインしていない状態' do
            it 'マイページへのアクセスが失敗する' do

            end
          end
        end
      end

      describe 'ログイン後' do
        describe 'ユーザー編集' do
          context 'フォームの入力値が正常' do
            it 'ユーザーの編集ができる'
          end
        end
        context 'メールアドレスが未入力時に' do
          it 'ユーザーの編集が失敗する'
        end
        context '登録済メールアドレスを使用' do
          it 'ユーザーの編集が失敗'
        end
        context '他ユーザーの編集ページにアクセス' do
          it 'アクセスが失敗する'
        end
      end

      describe 'マイページ' do
        context 'タスクを作成' do
          it '新規作成したタスクが表示される'
        end
      end

    end
  end

# context 'メールアドレスが未入力のend
# end


#         require 'rails_helper'
#
# Rspec.describe 'Users', type: :system do
#   # before do
#   #   driven_by(:rack_test)
#   # end
#   #
#   #
#
#   describe 'ユーザー挙動のテスト' do
#     # let(:user) { create(:user) }
#     # let(:other_user) {}
#
#     describe 'ログイン前のケース' do
#       describe 'ユーザー新規登録画面' do
#
#         context 'フォーム入力値が全て正しい問' do
#           it 'ユーザー新規作成に成功する' do
#
#           end
#         end
#       end
#     end
#   end
# end


# context 'メールアドレスが未入寮の時' do
#   it 'ユーザーの新規作成に失敗する' do
#     # user = build(:user)
#     fill_in 'Email', with: nil # 明示する
#     fill_in 'Password', with: 'password'
#     fill_in 'Password confirmation', with: 'password'
#     click_button('SignUp')
#     expect(page).to have_content "Email can't be blank"
#   end
# end
# context '登録済メールアドレスのとき' do
#   it 'ユーザーのi新規作成に失敗する' do
#     visit new_user_path
#     # DBへの登録済メールアドレスを取得
#     #
#     fill_in 'Email', with: 'password'
#     fill_in 'Password', with: 'password'
#     click_button('SignUp')
#     expect(page).to have_content 'Email has already been taken'
#     byebug
#   end
# end
#
# context '自分の編集ページにアクセスした時' do
#   it 'ログイン前なので推移に失敗する' do
#     visit edit_user_path(user)
#     expect(page).to have_content 'Login required'
#     # current_path、遷移先のURL+も確認したい
#   end
# end
#       end
#     end
#   end
# end

# describe 'ログイン後のケース' do
#   describe 'ユーザー編集画面' do
#     context 'フォームの入力値がすべて正しいとき'
#     fit 'ユーザーの編集に成功する' do
#       user.create(:user)
#       visit login_path
#       visit edit_user_path(user)
#       byebug
#
#       fill_in 'Email', with: 'bbb@example'
#       fill_in 'Password', with: 'password2'
#       fill_in 'Password confirmation', with: 'password_confirmation2'
#       click_button('Update')
#       expect(page).to have_content 'User was successfully updated.'
#     end
#   end
#
#   context 'メールアドレスが未入力時に' do
#     it 'ユーザーの編集が失敗する' do
#       login(user)
#       visit edit_user_path(user)
#       fill_in 'Email', with: nil
#       fill_in 'Password', with: 'password2'
#       fill_in 'Password confirmation', with: 'password2'
#       click_button('Update')
#       expect(page).to have_content 'U'
#     end
#
#   end
#   context '登録済メールアドレスを使用' do
#
#     it 'ユーザーの編集が失敗'
#   end
#   context '他ユーザーの編集ページにアクセス' do
#     it 'アクセスが失敗する'
#   end
#
#   describe 'マイページ' do
#     context 'タスクを作成' do
#       it '新規作成したタスクが表示される'
#     end
#   end
# end
# end
