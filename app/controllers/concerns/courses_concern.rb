# Interface for the controller actions of Courses
module CoursesConcern
  extend ActiveSupport::Concern

  def fetch_courses_with_tutors
    courses = Course.includes(:tutors).all
    pagy, courses = pagy(courses, page: params[:page], items: params[:per_page])
    render_json_with_pagination(pagy, courses, CourseSerializer)
  end

  def create_courses_with_tutors
    course_service_object = initialize_course_service(Course.new(course_params))
    course = course_service_object.create_course
    if course[0]
      respond_with_success('Created', :created)
    else
      respond_with_error(course[1].errors.full_messages, :unprocessable_entity)
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def course_params
    params.fetch(:course, {})
          .permit(:title, :description,
                  tutors_attributes: [:name])
  end

  def initialize_course_service(course)
    CourseService.new(course)
  end
end
