require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  describe 'ログイン前'
  describe '挙動テスト' do
    let(:user) { create(:user) }
    let(:task) { create(:task, user_id: user.id) }
    # let(other_user){(create(:user))}
    # let(other_task){create(:task, user_id: other_user.id)}

    describe 'ログイン前のケース' do
      describe 'タスクの新規作成画面' do
        context '権限がないため' do
          it 'アクセスに失敗する'
          user
          visit new_task_path
          expect(login_path).to eq(current_path)
          expect(page).to have_content 'Login required'
        end
      end
    end

    describe 'タスクの編集画面' do
      context '権限がないため' do
        it 'アクセスに失敗する' do
          user
          visit edit_task_path(user)
          expect(login_path).to eq(current_path)
          expect(page).to have_content 'Login required'
        end
      end
    end
  end

  describe 'ログイン後のケース' do
    describe 'タスクの新規作成画面' do
      context 'フォームの入力値がすべて正しい時'
      it 'タスクの新規作成に成功する'
      login(user)

      visit new_task_path
      fill_in 'Title', with: '最初のタスク'
      fill_in 'Content', with: '最初のコンテント'
      select 'todo', from: 'Status'
      click_button('Create Task')

      expect(page).to have_content 'Task was successfully  created'
    end
  end


describe '賛の編集画面' do

  context 'フォームの入力ちが全て正しいとき' do
    it 'タスクの編集に成功する' do
      login(user)
      visit edit_task_path(task)
      fill_in 'Title', with: '2つめのタスクに変更'
      fill_in 'Content', with: ''
      select 'doing'
      fill_in 'Deadline', with: 'eq December 201'
      click_button('Update Task')
      expect(page).to have_content 'Task was successfully updated'
    end
  end

  content '他ユーザーの編集ページにアクセスした時'
  it '権限がないため、アクセスが失敗する' do
    login(user)
    other_task
    visit edit_task_path(other_task)
    expect(root_path).to eq(current_path)
    expect(page).to have_content 'Forbidden access'
  end
end

describe 'タスクの一覧画面' do
  let!(:task) { create(:task, user_id: user.id) }
  context 'Destroyボタンをクリックした時'
  it '賛の削除に成功する' do
    login(user)
    task
    click_link('Destroy')
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content 'Task was successfully destroyed'
  end
end
end
