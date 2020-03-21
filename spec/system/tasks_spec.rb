require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  describe '挙動テスト' do
    let(:other_user) { create(:user) }
    let(:user) { create(:user)}
    let(:other_task) { create(:task, user_id: other_user.id) }
    let(:task) { create(:task, user_id: user.id)}

    describe 'ログイン前のケース' do
      describe 'タスクの新規作成画面' do
        context '権限なし' do
          it 'アクセスに失敗する' do
            user = create(:user)
            visit new_task_path
            expect(page).to have_content 'Login required'
            expect(current_path).to eq(login_path)
          end
        end
      end

      describe 'タスクの編集画面' do
        context '権限なし' do
          it 'アクセスに失敗する' do
            visit edit_task_path(user)
            expect(current_path).to eq(login_path)
            expect(page).to have_content 'Login required'
          end
        end
      end
    end


    describe 'ログイン後のケース' do
      describe 'タスクの新規作成画面' do
        context 'フォームの入力値がすべて入力されている時' do
          it 'タスクの新規作成に成功する' do
            visit login_path
            fill_in 'Email', with: user.email
            fill_in 'Password', with: 'password'
            click_button("Login")
            visit new_task_path
            fill_in 'Title', with: 'タスク➀'
            fill_in 'Content', with: 'コンテント➀'
            select 'todo', from: 'Status'
            click_button('Create Task')
            expect(page).to have_content 'Task was successfully created'
            expect(page).to have_content 'タスク➀'
            expect(page).to have_content 'コンテント➀'
          end
        end
      end
    end


    describe 'タスクの編集画面' do
      context 'フォームの入力値が全て正しい場合' do
        fit 'タスクの編集に成功する' do
          visit login_path
          fill_in 'Email', with: user.email
          fill_in 'Password', with: 'password'
          click_button('Login')
          visit edit_task_path(task)
          fill_in 'Title', with: 'タスク➁'
          fill_in 'Content', with: 'タスク➁'
          select 'doing', from: 'Status'
          fill_in 'Deadline', with: '2020/11/22 22:22'
          click_button('Update Task')
          expect(page).to have_content 'Task was successfully updated.'
          expect(page).to have_content task.reload.title
          expect(page).to have_content task.reload.content
        end
      end

      context '他ユーザーの編集ページにアクセスした時' do
        it '権限がないため、アクセス失敗' do
          user = create(:user)
          visit login_path
          fill_in 'Email', with: user.email
          fill_in 'Password', with: 'password'
          click_button('Login')
          visit edit_task_path(other_task)
          expect(current_path).to eq(root_path)
          expect(page).to have_content 'Forbidden access'


        end
      end
    end


    describe 'タスクの一覧画面' do
      context 'Destroyボタンをクリックした時' do
        it 'タスクの削除に成功する' do
          user = create(:user)
          visit login_path
          fill_in 'Email', with: user.email
          fill_in 'Password', with: 'password'
          click_button('Login')
          visit new_task_path
          fill_in 'Title', with: 'タスク➀'
          fill_in 'Content', with: 'コンテント➀'
          select 'todo', from: 'Status'
          click_button('Create Task')
          visit tasks_path
          click_link('Destroy')
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_content 'Task was successfully destroyed.'
          expect(page).not_to have_content task.title
          expect(page).not_to have_content task.content
        end
      end
    end
  end
end

