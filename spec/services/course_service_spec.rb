require 'rails_helper'

RSpec.describe CourseService, type: :service do
  describe '#create_course' do
    let(:course) { build(:course) }

    it 'should create course' do
      success, @course = CourseService.new(course).create_course

      expect(success).to eq(true)
      expect(@course.persisted?).to eq(true)
      expect(@course).to eq(course)
    end
    context 'when invalid' do
      it 'should create not course when title is blank' do
        course.title = nil
        success, @course = CourseService.new(course).create_course

        expect(success).to eq(false)
        expect(@course.persisted?).to eq(false)
        expect(@course.errors.full_messages).to eq(["Title can't be blank"])
      end
      it 'should create not course when description is blank' do
        course.description = nil
        success, @course = CourseService.new(course).create_course

        expect(success).to eq(false)
        expect(@course.persisted?).to eq(false)
        expect(@course.errors.full_messages).to eq(["Description can't be blank"])
      end
      it 'should create not course when tutors name is blank' do
        course.tutors_attributes = [{"name" => nil}]
        success, @course = CourseService.new(course).create_course

        expect(success).to eq(false)
        expect(@course.persisted?).to eq(false)
        expect(@course.errors.full_messages).to eq(["Tutors name can't be blank"])
      end
    end
  end
end