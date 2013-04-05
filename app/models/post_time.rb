class PostTime < ActiveRecord::Base
  belongs_to :user
  belongs_to :business
end
