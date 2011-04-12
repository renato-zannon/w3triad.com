require 'spec_helper'

class TestClass
  attr_accessor :content
  act_as_formattable
end

describe Formattable do

  subject { TestClass.new }

  it "has a default set of tags" do
    should respond_to(:tags)
    subject.tags.should_not be_nil
  end


  describe "#formatted_content" do
    it "is defined" do
      subject.should respond_to(:formatted_content)
    end

    it "formats simple tags" do
      subject.content = "#tcontent#t"
      subject.tags['t'] = ['<tag>', '</tag>']
      subject.formatted_content.should == "<tag>content</tag>"
    end

    it "formats complex tags" do
      subject.content = "#(t style)test#(t style)"
      subject.tags['(t)'] = lambda { |t| ["<#{t}>", "</#{t}>"] }
      subject.formatted_content.should == "<style>test</style>"
    end

    it "a tag doesn't interfere on another" do
      subject.content = "#btext1#b #itext2#i #b#itext3#i#b"
      subject.tags['b'] = ["<bold>", "</bold>"]
      subject.tags['i'] = ["<italic>", "</italic>"]
      subject.formatted_content.should == "<bold>text1</bold> <italic>text2</italic> <bold><italic>text3</italic></bold>"
    end

    it "formats complex tags and simple tags altogether" do
      subject.content = "#(t style)#ttext#t#(t style) #t#(t style)text#(t style)#t"
      subject.tags['(t)'] = lambda { |t| ["<#{t}>", "</#{t}>"] }
      subject.tags['t'] = ['<test>', '</test>']
      subject.formatted_content.should == "<style><test>text</test></style> <test><style>text</style></test>"
    end
    it "leaves the tag unopened if doesn't encounter a pair of keys" do
      subject.content = "#ttext"
      subject.tags['t'] = ["<tag>", "</tag>"]
      subject.formatted_content.should == "<tag>text"
    end

    it "substitutes \# with #, and don't resolve as a tag" do
      subject.content = '\#t#ttext#t'
      subject.tags['t'] = ["<tag>", "</tag>"]
      subject.formatted_content.should == "#t<tag>text</tag>"

      subject.content = '#(t tag)\#(t tag)text\#(t tag)#(t tag)'
      subject.tags['(t)'] = lambda { |tag| ["<#{tag}>", "</#{tag}>"] }
      subject.formatted_content.should == "<tag>#(t tag)text#(t tag)</tag>"
    end
  end

  it "complains if the class doesn't have a content" do
    including_on_contentless_class = lambda {class ContentlessClass; include Formattable; end}
    including_on_contentless_class.should raise_error
end

describe "#paragraphs" do
  it "returns an array containing the paragraphs on the content (stripped)" do
    subject.content = "Paragraph 1\n\n   Paragraph 2\n\n\nParagraph 3\nLine 1  "
    subject.paragraphs.should == ["Paragraph 1", "Paragraph 2", "Paragraph 3\nLine 1"]
  end
end
end
