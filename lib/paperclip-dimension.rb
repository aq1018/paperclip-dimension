require 'paperclip'

module Paperclip
  module Dimension
    def self.included(klass)
      klass.extend Paperclip::Dimension::ClassMethods
    end

    module ClassMethods
      # override has_attached_file to:
      # 1). save dimensions on post process
      # 2). create dimension accessors
      def has_attached_file name, options={}
        super

        class_eval <<-END
          # for ActiveRecord
          serialize :#{name}_dimensions, Hash if respond_to?(:serialize)

          def #{name}_dimension(style=:original)
            self.#{name}_dimensions[style.to_s]
          end

          def #{name}_dimension_str(style=:original)
             dim = #{name}_dimension(style.to_s)
             dim ? dim.join('x') : nil
          end
        END

        send "after_#{name}_post_process", lambda { save_dimensions_for(name) }
      end
    end

    def save_dimensions_for(name)
      opts = self.class.attachment_definitions[name]

      styles = [:original]
      styles += opts[:styles].keys if opts[:styles]
      dimension_hash = {}
      styles.each do |style|
        attachment = self.send name
        geo = ::Paperclip::Geometry.from_file(attachment.queued_for_write[style])
        dimension_hash[style.to_s] = [ geo.width.to_i, geo.height.to_i ]
      end
      self.send "#{name}_dimensions=", dimension_hash
    end
  end

  module Glue
    class << self
      def included_with_dimension(klass)
        included_without_dimension(klass)
        klass.send :include, Paperclip::Dimension
      end

      alias :included_without_dimension :included
      alias :included :included_with_dimension
    end
  end

  module Schema
    COLUMNS[:dimensions] = :string
  end
end
