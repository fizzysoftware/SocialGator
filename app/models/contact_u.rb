class ContactU < ActiveRecord::Base
  attr_accessible :email,:phone_number,:related_to,:message
end
