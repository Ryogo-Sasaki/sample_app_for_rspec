require 'rails_helper'

RSpec.describe User, type: :system do
  describe 'ログイン前' do
    describe 'ユーザー新規登録' do
      context 'フォームの入力値が正常' do
        fit 'ユーザーの新規作成ができる'
        let(:user) { User.new(email: 'aaa@gmail.com', password: 'aaa', password_confirmation: 'aaa', created_at: '', updated_at: '') }
        byebug
        expect(user).to have_selector '.alert-success', text: 'User was successfully created.'
      end

      context 'メールアドレスが未入力' do
        fit 'ユーザーの新規作成が失敗する'
        let(:user) { User.new(email: '', password: 'aaa', password_confirmation: 'aaa', created_at: '', updated_at: '') }
        byebug
        expect(user).to have_content '.alert-danger', text: 'ユーザーの登録に失敗しました'
      end

      context '登録済メールアドレスを使用' do
        fit 'ユーザーの新規作成が失敗する'

        user = build(:user)
        expect(user).to have_content '.alert-danger', text: 'ユーザーの登録に失敗しました'
      end

      describe 'マイページ' do
        context 'ログインしていない状態' do
          fit 'マイページへのアクセスが失敗する'
          visit users_path
          expect(user).to have_content '.alert-danger', text: 'Login Required'
        end
      end
    end
  end

  describe 'ログイン後' do
    describe 'ユーザー編集' do

      context 'フォームの入力値が正常' do
        let(:user_a) { FactoryBot.create(:user, email: 'aaa@gmail.com', password: 'aaa', password_confirmation: 'aaa', created_at: '', updated_at: '') }

        before do
          visit login_path

          click_button 'ログインする'
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
