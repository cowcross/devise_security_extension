module DeviseSecurityExtension
  module Validators
    module Extensions
      extend ActiveSupport::Concern
      # customisations allowing us to set validation rules dynamically
      # based on apartment tenant
      
      class_methods do
        def define_password_length_validator
          @@_password_length_function = password_length
          validate :password_length_valid
        end
        
        def define_password_format_validator
          @@_password_format_function = password_regex
          validate :password_format_valid
        end
      end
      
      def password_length_valid
        length_range = @@_password_length_function.call
        if password && password.length > length_range.max
          errors.add(:password, "Password is too long (maximum is #{length_range.max} characters)")
        elsif password && password.length < length_range.min
          errors.add(:password, "Password is too short (minimum is #{length_range.min} characters)")
        end
      end
      
      def password_format_valid
        regex = @@_password_format_function.call
        unless password && password.match(regex)
          errors.add(:password, "Password does not match the required format")
        end
      end
      
    end
  end
end