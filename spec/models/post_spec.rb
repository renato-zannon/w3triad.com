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

  describe "#paragraphs" do
    it "returns an array containing the paragraphs on the content (stripped)" do
      subject.content = "Paragraph 1\n\n   Paragraph 2\n\n\nParagraph 3\nLine 1  "
      subject.paragraphs.should == ["Paragraph 1", "Paragraph 2", "Paragraph 3\nLine 1"]
    end
  end
end
