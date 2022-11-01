# app/services/course_service.rb
class CourseService
  def initialize(course)
    @course = course
  end

  def create_course
    [@course.save, @course]
  end
end