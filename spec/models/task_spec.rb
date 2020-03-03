require 'rails_helper'

RSpec.describe Task, type: :model do
  it '全てのattributeがvalidationを通るか' do
   task = Task.new(title: 'aaa', status: :doing)
   expect(task).to be_valid
  end

    it 'タイトルがなかったらinvalid'do
      task = Task.new(title: '', status: :doing )
      expect(task.errors[:title]).to be_valid
    end

   it 'ステータスがなかったらinvalid' do
     task = Task.new(title: 'aaa', status: '')
    expect(task.errors[:status]).to be_valid
   end

  it 'タイトルが重複していたらinvalid' do
    task = Task.new(title: 'bbb', status: :doing)
    task.title = "bbb"
    expect(task.errors).to be_valid
  end

  fit 'タイトルが重複していたらinvalid' do
    task = Task.new(title: 'bbb', status: :doing)
    task.title =  "ccc"
    expect(task.errors).to be_valid
  end
end
