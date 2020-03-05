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
    expect(task.errors[:title]).to be_valid, include("can't be blank")
  end

  # ➂it 'is invalid without status' do end
  it 'ステータスがなかったらinvalid' do
    task = Task.new(title: 'aaa', status: '')
    expect(task.errors[:status]).to be_valid, include("can't be blank")
  end

  # ➃it 'is invalid with a duplicate title' do end
  it 'タイトルが重複していたらinvalid' do
    Task.create(
      tittle: 'aaa',
      status: :doing
    )
    task = Task.new(
      tittle: 'aaa',
      status: :doing
    )
    task.valid?
    expect(task.errors[:title]).to be_valid, include("has already been taken")
  end

  # ➄it 'is valid with another title' do end
  it 'タイトルが重複していたらinvalid' do
    Task.create(
      tittle: 'aaa',
      status: :doing
    )
    task = Task.new(
      tittle: 'bbb',
      status: :doing
    )
    task.valid?
    expect(task.errors[:title]).to be_valid
  end
end