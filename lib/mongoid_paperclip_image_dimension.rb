require 'active_support/concern'

module Mongoid::Paperclip::ImageDimension
  extend ActiveSupport::Concern

  included do
    class_attribute :perperclip_image_dimension_fields
    self.perperclip_image_dimension_fields = []
  end

  module ClassMethods
    def save_image_dimensions_on(*args)
      args.flatten.each do |attachment_field|
        attachment_field = attachment_field.to_sym
        dimension_field_name = "#{attachment_field}_dimensions".to_sym
        perperclip_image_dimension_fields << attachment_field
        field dimension_field_name, :type => Hash

        class_eval <<-END
          def #{attachment_field}_dimension(style=:original)
            #{attachment_field}_dimensions[style.to_s].map(&:to_i)
          end

          def #{attachment_field}_dimension_str(style=:original)
            #{attachment_field}_dimension(style).join('x')
          end

          after_#{attachment_field}_post_process do
            save_dimensions_for(:"#{attachment_field}")
          end
        END

      end
    end
  end

  def save_dimensions_for(attachment_field)
    styles = self.class.attachment_definitions[attachment_field][:styles].keys + [:original]
    dimension_hash = {}
    styles.each do |style|
      attachment = self.send attachment_field
      geo = Paperclip::Geometry.from_file(attachment.queued_for_write[style])
      dimension_hash[style] = [ geo.width.to_i, geo.height.to_i ]
    end
    self.send "#{attachment_field}_dimensions=", dimension_hash
  end
end
