require 'rails_helper'

RSpec.describe Task, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  # ➀it 'is valid with all attributes' do end
  it '全てのattributeがvalidationを通るか' do
   task = Task.new(title: 'aaa', status: :doing)
   expect(task).to be_valid
  end

  # ➁it 'is invalid without title' do end
    it 'タイトルがなかったらinvalid'do
      task = Task.new(title: '', status: :doing )
      expect(task.errors[:title]).to be_valid
    end

  # ➂it 'is invalid without status' do end
   it 'ステータスがなかったらinvalid' do
     task = Task.new(title: 'aaa', status: '')
    expect(task.errors[:status]).to be_valid
   end

  # ➃it 'is invalid with a duplicate title' do end
  it 'タイトルが重複していたらinvalid' do
    task = Task.new(title: 'bbb', status: :doing)
    task.title = "bbb"
    expect(task.errors[:title]).to be_valid
  end

  # ➄it 'is valid with another title' do end
  it 'タイトルが重複していたらinvalid' do
    task = Task.new(title: 'bbb', status: :doing)
    task.title =  "ccc"
    expect(task.errors[:title]).to be_valid
  end
end
