class Course < ApplicationRecord
  ############ Associations #############
  has_many :tutors, dependent: :destroy
  accepts_nested_attributes_for :tutors

  ############ Validations #############
  # validates the presence of title and description attributes
  validates_presence_of :title, :description
  validates_uniqueness_of :title
end
