$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rspec'
require 'active_record'
require 'paperclip'
require 'paperclip-dimension'
require 'rbconfig'

# Hack for running Paperclip on Windows
if RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/
  Paperclip.options[:command_path] = 'C:\\Program Files\\ImageMagick'
end

# mocking Rails.root & Rails.env used in Paperclip::Interploration
module Rails
  def self.root
    File.dirname(__FILE__) + "/.."
  end

  def self.env
    "test"
  end

  def self.logger
    nil
  end
end

ActiveRecord::Base.send(:include, Paperclip::Glue)

# turn off logging
Paperclip.options[:log] = false

# use sqlite3 memory store
ActiveRecord::Base.establish_connection({
  :adapter    =>    'sqlite3',
  :database   =>    ':memory:'
})

# create tables
ActiveRecord::Schema.define do
  create_table :posts do |t|
    t.attachment :image
    t.attachment :another_image
    t.attachment :image_with_proc
    t.attachment :image_no_styles
  end
end

# define model
class Post < ActiveRecord::Base
  extend Paperclip::Dimension::ClassMethods

  has_attached_file :image, :styles => {
    :large  => ['350x350>', :jpg],
    :medium => ['150x150>', :jpg],
    :small  => ['30x30>',   :jpg]
  }

  has_attached_file :another_image, :styles => {
    :large  =>  ['350x350>', :jpg],
    :medium => ['150x150>', :jpg],
    :small  => ['30x30>',   :jpg]
  }

  has_attached_file :image_with_proc, :styles => Proc.new { |obj|
    {
        :large  => ['350x350>', :jpg],
        :medium => ['150x150>', :jpg],
        :small  => ['30x30>',   :jpg]
    }
  }

  has_attached_file :image_no_styles

  %i(image another_image image_with_proc image_no_styles).each do |field|
    validates_attachment_content_type field, :content_type => ['image/png']
  end
end
