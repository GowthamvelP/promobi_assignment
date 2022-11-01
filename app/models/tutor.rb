class Tutor < ApplicationRecord
  ############ Associations #############
  belongs_to :course

  ############ Validations #############
  # validates the presence of the name attribute
  validates_presence_of :name
end
