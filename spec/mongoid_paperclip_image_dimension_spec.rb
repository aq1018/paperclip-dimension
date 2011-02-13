require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

# mocking Rails.root & Rails.env used in Paperclip::Interploration
module Rails
  def self.root
    File.dirname(__FILE__) + "/.."
  end
  
  def self.env
    "test"
  end
end

class Post
  include Mongoid::Document
  include Mongoid::Paperclip
  include Mongoid::Paperclip::ImageDimension
  
  has_mongoid_attached_file :image, :styles => {
    :large    =>    ['350x350>',     :jpg],
    :medium   =>    ['150x150>',     :jpg],
    :small    =>    ['30x30>',       :jpg]
  }
  
  has_mongoid_attached_file :another_image, :styles => {
    :large    =>    ['350x350>',     :jpg],
    :medium   =>    ['150x150>',     :jpg],
    :small    =>    ['30x30>',       :jpg]
  }
  
  # This will save all dimensions of images and thumbnails for both :image and :another_image
  save_image_dimensions_on :image, :another_image
end

describe Mongoid::Paperclip::ImageDimension do
  before(:each) do
    @p = Post.create!({
     :image =>File.open(File.dirname(__FILE__) + '/ruby.png'),
     :another_image => File.open(File.dirname(__FILE__) + '/ruby.png')
    })
    @p.reload
  end
  
  it "should save dimensions" do
    @p.image_dimensions.should_not be_nil
    @p.another_image_dimensions.should_not be_nil
  end
  
  it "should retreive dimensions correctly" do
    @p.image_dimension.should == [995, 996]
    @p.image_dimension(:original).should == [995, 996]
    @p.image_dimension(:large).should == [350, 350]
    @p.image_dimension(:medium).should == [150, 150]
    @p.image_dimension(:small).should == [30, 30]
    
    @p.another_image_dimension.should == [995, 996]
    @p.another_image_dimension(:original).should == [995, 996]
    @p.another_image_dimension(:large).should == [350, 350]
    @p.another_image_dimension(:medium).should == [150, 150]
    @p.another_image_dimension(:small).should == [30, 30]
  end

  it "should retreive dimension strings correctly" do
    @p.image_dimension_str.should == "995x996"
    @p.image_dimension_str(:original).should == "995x996"
    @p.image_dimension_str(:large).should == "350x350"
    @p.image_dimension_str(:medium).should == "150x150"
    @p.image_dimension_str(:small).should == "30x30"
    
    @p.another_image_dimension_str.should == "995x996"
    @p.another_image_dimension_str(:original).should == "995x996"
    @p.another_image_dimension_str(:large).should == "350x350"
    @p.another_image_dimension_str(:medium).should == "150x150"
    @p.another_image_dimension_str(:small).should == "30x30"
  end
  
end
