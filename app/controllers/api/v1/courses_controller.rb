class Api::V1::CoursesController < ApplicationController
  include CoursesConcern

  # GET /courses with associated tutors
  def index
    fetch_courses_with_tutors
  end

  # POST /courses along with tutor attributes
  def create
    create_courses_with_tutors
  end
end
