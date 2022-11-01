require 'rails_helper'

RSpec.describe Api::V1::CoursesController, type: :controller do

  describe "#create" do
    before do
      post :create, params: params
    end

    context "when valid" do
      let(:params) do
        {
          course: {
            title: 'My first course!',
            description: 'My first course description!',
            tutors_attributes: [
              {
                name: 'tutor 1'
              },
              {
                name: 'tutor 2'
              }

            ]
          }
        }
      end

      it 'should create course' do
        expect(Course.count).to eq(1)
      end

      it 'should create tutors' do
        expect(Tutor.count).to eq(2)
      end

      it 'should respond with success' do
        expect(response.status).to eq(201)
      end
    end

    context 'when invalid' do
      context 'course title is blank' do
        let(:params) do
          {
            course: {
              title: nil,
              description: 'My first course description!'
            }
          }
        end

        it 'should respond with 422 - Unprocessible Entity' do
          expect(response.status).to eq(422)
        end

        it 'it should return an error message' do
          response_json = JSON.parse(response.body)
          expect(response_json['message']).to eq(["Title can't be blank"])
        end

      end

      context 'when tutor name is blank' do
        let(:params) do
          {
            course: {
              title: 'My first course!',
              description: 'My first course description!',
              tutors_attributes: [
                name: nil
              ]
            }
          }
        end

        it 'should respond with 422 - Unprocessible Entity' do
          expect(response.status).to eq(422)
        end

        it 'should have error in response body' do
          response_json = JSON.parse(response.body)
          expect(response_json['message']).to eq(["Tutors name can't be blank"])
        end
      end
    end
  end

  describe "#index" do
    let(:course) { FactoryBot.create(:course, title: "1st Course", description: "This is my first course!") }
    let(:tutor1) { FactoryBot.create(:tutor, name: "Tutor 1", course: course) }
    let(:tutor2) { FactoryBot.create(:tutor, name: "Tutor 2", course: course) }

    context "when valid" do
      let(:params) do
        {
          page: 1,
          per_page: 20
        }
      end

      it 'should list courses' do
        puts course, tutor1, tutor2
        get :index, params: params
        response_json = JSON.parse(response.body)
        puts response_json
        expect(response_json['data'][0]['title']).to eq(course.title)
        expect(response_json['data'][0]['description']).to eq(course.description)
        expect(response_json['data'][0]['tutors']['name']).to eq(tutors.first.name)
        expect(response_json['metadata']['page']).to eq(params[:page])
        expect(response_json['metadata']['per_page']).to eq(params[:per_page])
        expect(response_json['metadata']['total_entries']).to eq(1)
      end
    end
  end
end
