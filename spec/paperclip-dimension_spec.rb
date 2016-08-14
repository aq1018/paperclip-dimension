require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Paperclip::Dimension do
  before(:each) do
    @p = Post.create!({
        :image => File.open(File.dirname(__FILE__) + '/ruby.png'),
        :another_image => File.open(File.dirname(__FILE__) + '/ruby.png'),
        :image_with_proc => File.open(File.dirname(__FILE__) + '/ruby.png'),
        :image_no_styles => File.open(File.dirname(__FILE__) + '/ruby.png')
    })
    @p.reload
  end

  it "should save dimensions" do
    expect(@p.image_dimensions).to_not eq nil
    expect(@p.another_image_dimensions).to_not eq nil
    expect(@p.image_with_proc).to_not eq nil
    expect(@p.image_no_styles_dimensions).to_not eq nil
  end

  it "should accept empty styles hash" do
    expect(@p.image_no_styles_dimension).to eq [995, 996]
    expect(@p.image_no_styles_dimension(:original)).to eq [995, 996]
    expect(@p.image_no_styles_dimension(:large)).to eq nil
  end

  it "should retrieve dimensions correctly" do
    expect(@p.image_dimension).to eq [995, 996]
    expect(@p.image_dimension(:original)).to eq [995, 996]
    expect(@p.image_dimension(:large)).to eq [350, 350]
    expect(@p.image_dimension(:medium)).to eq [150, 150]
    expect(@p.image_dimension(:small)).to eq [30, 30]

    expect(@p.another_image_dimension).to eq [995, 996]
    expect(@p.another_image_dimension(:original)).to eq [995, 996]
    expect(@p.another_image_dimension(:large)).to eq [350, 350]
    expect(@p.another_image_dimension(:medium)).to eq [150, 150]
    expect(@p.another_image_dimension(:small)).to eq [30, 30]

    expect(@p.image_with_proc_dimension).to eq [995, 996]
    expect(@p.image_with_proc_dimension(:original)).to eq [995, 996]
    expect(@p.image_with_proc_dimension(:large)).to eq [350, 350]
    expect(@p.image_with_proc_dimension(:medium)).to eq [150, 150]
    expect(@p.image_with_proc_dimension(:small)).to eq [30, 30]
  end

  it "should retrieve dimension strings correctly" do
    expect(@p.image_dimension_str).to eq "995x996"
    expect(@p.image_dimension_str(:original)).to eq "995x996"
    expect(@p.image_dimension_str(:large)).to eq "350x350"
    expect(@p.image_dimension_str(:medium)).to eq "150x150"
    expect(@p.image_dimension_str(:small)).to eq "30x30"

    expect(@p.another_image_dimension_str).to eq "995x996"
    expect(@p.another_image_dimension_str(:original)).to eq "995x996"
    expect(@p.another_image_dimension_str(:large)).to eq "350x350"
    expect(@p.another_image_dimension_str(:medium)).to eq "150x150"
    expect(@p.another_image_dimension_str(:small)).to eq "30x30"

    expect(@p.image_with_proc_dimension_str).to eq "995x996"
    expect(@p.image_with_proc_dimension_str(:original)).to eq "995x996"
    expect(@p.image_with_proc_dimension_str(:large)).to eq "350x350"
    expect(@p.image_with_proc_dimension_str(:medium)).to eq "150x150"
    expect(@p.image_with_proc_dimension_str(:small)).to eq "30x30"
  end
end
