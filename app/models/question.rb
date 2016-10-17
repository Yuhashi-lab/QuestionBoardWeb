class Question < ActiveRecord::Base
  belongs_to :board
  has_and_belongs_to_many :user
end
