require 'rails_helper'

RSpec.describe Task, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  # ➀it 'is valid with all attributes' do end
  it '全てのattributeがvalidationを通るか' do
    task = Task.new(title: 'aaa', status: :doing)
    expect(task).to be_valid
  end

  # ➁it 'is invalid without title' do end
  it 'タイトルがなかったらinvalid' do
    task = Task.new(title: '', status: :doing)
    expect(task).to be_valid
    expect(task).to include("can't be blank")
  end

  # ➂it 'is invalid without status' do end
  it 'ステータスがなかったらinvalid' do
    task = Task.new(title: 'aaa', status: '')
    expect(task).to be_valid
    expect(task).to include("can't be blank")
  end

  # ➃it 'is invalid with a duplicate title' do end
  fit 'タイトルが重複していたらinvalid' do
    Task.create(
      title: 'aaa',
      status: :doing
    )
    task = Task.new(
      title: 'aaa',
      status: :doing
    )
    byebug
    expect(task).to be_valid
    expect(task).to include("has already been taken")
  end

  # ➄it 'is valid with another title' do end
  it 'タイトルが重複していなかったらvalid' do
    Task.create(
      title: 'aaa',
      status: :doing
    )
    task = Task.new(
      title: 'bbb',
      status: :doing
    )
    expect(task).to be_valid
  end
end