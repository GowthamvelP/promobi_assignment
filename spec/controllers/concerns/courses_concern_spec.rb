require 'spec_helper'

class CoursesController < ApplicationController
include CoursesConcern
end

describe CoursesController do

  it "should mark an item out of stock" do
    create(:course)
    create(:tutor, course: course)
    create(:tutor, course: course)
    response = subject.fetch_courses_with_tutors
    expect(item.is_in_stock).to be false
  end
end