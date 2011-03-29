require 'spec_helper'

class TestClass
  attr_accessor :content
end

describe Formattable do

  subject { TestClass.new.extend(Formattable) }

  it "has a default set of tags" do
    should respond_to(:tags)
    subject.tags.should_not be_nil
  end


  describe "#formatted_content" do
    it "is defined" do
      subject.should respond_to(:formatted_content)
    end

    it "formats simple tags" do
      subject.content = "$tcontent$t"
      subject.tags['t'] = ['<tag>', '</tag>']
      subject.formatted_content.should == "<tag>content</tag>"
    end

    it "a tag doesn't interfere on another" do
      subject.content = "$btext1$b $itext2$i $b$itext3$i$b"
      subject.tags['b'] = ["<bold>", "</bold>"]
      subject.tags['i'] = ["<italic>", "</italic>"]
      subject.formatted_content.should == "<bold>text1</bold> <italic>text2</italic> <bold><italic>text3</italic></bold>"
    end

    it "leaves the tag unopened if doesn't encounter a pair of keys" do
      subject.content = "$ttext"
      subject.tags['t'] = ["<tag>", "</tag>"]
      subject.formatted_content.should == "<tag>text"
    end

    it "substitutes \$ with $, and don't resolve as a tag" do
      subject.content = '\$t$ttext$t'
      subject.tags['t'] = ["<tag>", "</tag>"]
      subject.formatted_content.should == "$t<tag>text</tag>"
    end
  end

  it "complains if the class doesn't have a content" do
    including_on_contentless_class = lambda {class ContentlessClass; include Formattable; end}
    including_on_contentless_class.should raise_error
  end
end
