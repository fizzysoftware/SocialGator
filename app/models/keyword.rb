class Keyword < ActiveRecord::Base
  belongs_to :business
  validates :token, presence: true
  
end
