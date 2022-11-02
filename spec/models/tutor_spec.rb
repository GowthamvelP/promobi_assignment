require 'rails_helper'

RSpec.describe Tutor, type: :model do
  describe '#associations' do
    it { should belong_to(:course) }
  end

  describe '#validations' do
    context 'validate title' do
      it 'should validate the presence of name' do
        expect { create(:tutor, name: nil) }.to raise_error(
                                                  ActiveRecord::RecordInvalid
                                                )
      end
    end
  end
end