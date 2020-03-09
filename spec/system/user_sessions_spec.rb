require 'rails_helper'

RSpec.describe "User_Sessions", type: :system do

  describe 'ログイン前' do
    before do
      visit login_path
    end
    context 'フォームの入力値が正常' do
      it 'ログインが成功する'
      user_sessions = User_Sessions.build(email: 'aaa@gmail.com', password: 'aaa')
        click_button 'Login'
        expect(user_sessions).to have_selector '.alert-success', text: 'ログインに成功しました'
      end

    context 'フォームが未入力' do
      it 'ログインが失敗する'

      user_sessions = User_Sessions.build(email: '', password: '')
        click_button 'Login'
      expect(user_sessions).to have_content '.alert-danger', text: 'ログインに失敗しました'
      end
  end

  describe 'ログイン後' do
    before do
      visit login_path
      user_sessions = User_Sessions.build(email: 'aaa@gmail.com', password: 'aaa')
      click_button 'Login'
    end
    context 'ログアウトボタンをクリック' do
    it 'ログアウト処理が成功する'
      click_button 'Logout'
    end
    expect(user_sessions).to have_selector '.alert-success', text: 'ログアウトに成功しました
  end
end
