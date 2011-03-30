require 'spec_helper'

module Formattable
  describe TagCollection do

    subject { TagCollection.new }

    describe "accepts tags mapping to" do
      specify "an array with two members, when the key is simple" do
        subject["c"] = ["<cool>", "</cool>"]
        subject.should include "c"
      end

      specify "a block, for the parenthesis key" do
        subject["()"] = Proc.new { |tag| ["<#{tag}>","</#{tag}>"] }
        subject["(cool)"].should == ["<cool>", "</cool>"]
      end
    end
    describe "lets me change the tags" do
      specify "by merging another hash" do
        new_tag = {"c" => ["<cool>", "</cool>"]}
        subject.merge new_tag
        subject.should include "c"
        subject["c"].should == ["<cool>", "</cool>"]
      end

      specify "by directly acessing the tags hash" do
        subject["c"] = ["<cool>", "</cool>"]
        subject.should include "c"
        subject["c"].should == ["<cool>", "</cool>"]
      end
    end

    describe "complains if I try to include" do
      specify "a tag with invalid characters" do
        bad_tags = ["$t", "t a g", "(t", "t)", ")t", "t(", "t ", "(())", "(()"]
        bad_tags.each do |bad_tag|
          including_bad_tag = lambda { subject[bad_tag] = ["<bad tag>", "</bad tag>"]}
          including_bad_tag.should raise_error ArgumentError
        end
      end

      specify "a tag that maps to an ill-formed array" do
        bad_arrays = [ [], ["bad"], ["very", "bad", "array"] ]
        bad_arrays.each do |bad_array|
          mapping_bad_array = lambda { subject['t'] = bad_array }
          mapping_bad_array.should raise_error ArgumentError
        end
      end

      specify "a nil tag, or a tag that maps to nil" do
        nil_tags = { nil => ["<tag>", "</tag>"], 't' => nil }
        nil_tags.each do |bad_key, bad_value|
          nil_tag = {bad_key => bad_value}
          setting_nil_tag = lambda { subject.merge nil_tag }
          setting_nil_tag.should raise_error ArgumentError
        end
      end

      specify "a Proc that accepts more (or less) than 1 parameter" do
        bad_procs = [ Proc.new {}, Proc.new { |a,b| }, Proc.new { |a,b,c| } ]
        bad_procs.each do |bad_proc|
          mapping_bad_proc = lambda { subject['()'] = bad_proc }
          mapping_bad_proc.should raise_error ArgumentError
        end
      end
    end

    it "is enumerable" do
      Enumerable.instance_methods.each do |method|
        subject.should respond_to(method)
      end
    end
  end
end
