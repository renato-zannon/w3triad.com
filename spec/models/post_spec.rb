require 'spec_helper'

describe Post do
  subject { Factory.build(:post) }

  it "is valid with valid attributes" do
    subject.should be_valid
  end

  it "isn't valid without a title" do
    ["", nil].each do |invalid_title|
      subject.title = invalid_title
      subject.should_not be_valid
    end
  end

  it "isn't valid without a content" do
    ["", nil].each do |invalid_content|
      subject.content = invalid_content
      subject.should_not be_valid
    end
  end

  it "isn't valid without an author" do
    subject.author = nil
    subject.should_not be_valid
  end
end
