require 'rails_helper'

RSpec.describe Course, type: :model do
  describe '#associations' do
    it { should have_many(:tutors) }
  end

  describe '#validations' do
    context 'validate title' do
      it 'should validate uniqueness of title' do
        create(:course, title: 'course')
        course = build(:course, title: 'course')
        expect { course.save! }.to raise_error(
                                     ActiveRecord::RecordInvalid
                                   )
      end

      it 'should validate presence of title' do
        course = build(:course, title: nil)
        expect { course.save! }.to raise_error(
                                     ActiveRecord::RecordInvalid
                                   )
      end
    end

    context 'validate description' do
      it 'should validate presence of description' do
        course = build(:course, description: nil)
        expect { course.save! }.to raise_error(
                                     ActiveRecord::RecordInvalid
                                   )
      end
    end
  end
end