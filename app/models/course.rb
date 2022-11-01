class Course < ApplicationRecord
  ############ Associations #############
  has_many :tutors

  ############ Validations #############
  # validates the presence of title and description attributes
  validates_presence_of :title, :description
end
