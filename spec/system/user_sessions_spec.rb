#  require 'rails_path'
#
# RSpec.describe 'UserSessions', type: :system do
#
#   describe 'ログイン前' do
#     # let(:user_a){ FactoryBot.create(:user)}
#
#     before do
#       @user = build(:user, email: 'aaa@gmail.com', password: 'aaa')
#       byebug
#       visit login_path
#
#       fill_in 'Email', with: 'aaa@gmail.com'
#       fill_in 'Password', with: 'aaa'
#       click_button 'Login'
#     end
#
#     context 'フォームの入力値が正常' do
#       it 'ログインが成功する' do
#         expect(user).to have_selector '.alert-success', text: 'Login successful'
#       end
#       context 'フォームが未入力'
#       it 'ログインが失敗する' do
#       end
#     end
#     end
#     describe 'ログイン後' do
#       context 'ログアウトボタンをクリック'
#       it 'ログアウト処理が成功する' do
#       end
#     end
#   end
#
#
# require 'rails_helper'
#
# Rspec.describe 'UserSessions', type: :system do
#   # before do
#   #   driven_by(:rack_test)
#   # end
#
#   describe 'ユーザーのログイン挙動テスト' do
#     let(:user) { create(:user) }
#
#     describe 'ログイン前のテストケース' do
#
#       context 'フォーム入力値が全て正しい時' do
#         it 'ログインが成功する' do
#           user
#
#           visit login_path
#           fill_in 'Email', with: user.email
#           fill_in 'Password', with: user.password
#           click_button('Login')
#           byebug
#           expect(page).to have_content 'Login successful'
#         end
#       end
#
#       context 'フォームが未入力のとき' do
#         it 'ログインが失敗する' do
#           user
#           visit login_path
#           fill_in 'Email', with: ''
#           fill_in 'Password', with user.password
#           click_button('Login')
#           expect(page).to have_content 'Login failed'
#         end
#       end
#     end
#
#     describe 'ログイン後のケース' do
#       context 'ログアウトボタンをクリックした時' do
#         it 'ログアウトに成功する'
#         login(user)
#         click_link('Logout')
#         expect(root_path).to eq(current_path)
#         expect(page).to have_content 'Logged out'
#       end
#     end
#   end
# end