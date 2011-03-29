require 'spec_helper'
require 'formattable'

class TestClass
  def content
    "content"
  end
end

describe Formattable do

  subject { TestClass.new.extend(Formattable) }

  it "has a default set of tags" do
    should respond_to(:tags)
  end

  it "complains if the class doesn't have a content" do
    including_on_contentless_class = lambda {class ContentlessClass; include Formattable; end}
    including_on_contentless_class.should raise_error
  end
end
