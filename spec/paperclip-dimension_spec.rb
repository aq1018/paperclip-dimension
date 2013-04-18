require File.expand_path(File.dirname(__FILE__) + '/spec_helper')


describe Paperclip::Dimension do
  before(:each) do
    @p = Post.create!({
     :image =>File.open(File.dirname(__FILE__) + '/ruby.png'),
     :another_image => File.open(File.dirname(__FILE__) + '/ruby.png'),
     :image_no_styles => File.open(File.dirname(__FILE__) + '/ruby.png')
    })
    @p.reload
  end

  it "should save dimensions" do
    @p.image_dimensions.should_not be_nil
    @p.another_image_dimensions.should_not be_nil
    @p.image_no_styles_dimensions.should_not be_nil
  end
  
  it "should accept empty styles hash" do
    @p.image_no_styles_dimension.should  == [995, 996]
    @p.image_no_styles_dimension(:original).should == [995, 996]
    @p.image_no_styles_dimension(:large).should be_nil
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

