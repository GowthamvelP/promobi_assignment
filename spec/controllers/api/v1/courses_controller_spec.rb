require 'rails_helper'

RSpec.describe Api::V1::CoursesController, type: :controller do
  describe "#index" do
    let(:course) { FactoryBot.create(:course, title: "1st Course", description: "This is my first course!") }
    let(:tutor1) { FactoryBot.create(:tutor, name: "Tutor 1", course: course) }
    let(:tutor2) { FactoryBot.create(:tutor, name: "Tutor 2", course: course) }

    context "when valid params are passed" do
      let(:params) do
        {
          page: 1,
          per_page: 20
        }
      end

      it 'should list courses with associated tutors' do
        get :index, params: params
        response_json = JSON.parse(response.body)
        expect(response_json['data'][0]['title'].to_s).to eql(course.title.to_s)
        expect(response_json['data'][0]['description'].to_s).to eq(course.description.to_s)
        expect(response_json['data'][0]['tutors'][0]['name']).to eq(tutor1.name)
        expect(response_json['metadata']['page']).to eq(params[:page])
        expect(response_json['metadata']['per_page']).to eq(params[:per_page])
        expect(response_json['metadata']['total_entries']).to eq(1)
      end
    end

    context "when invalid page params are passed" do
      let(:params) do
        {
          page: 'hi',
          per_page: 20
        }
      end

      it 'should respond with an invalid page error' do
        get :index, params: params
        response_json = JSON.parse(response.body)
        expect(response_json['success']).to eq(false)
        expect(response_json['message']).to eq("Invalid page.")
      end
    end

    context "when invalid page params are passed" do
      let(:params) do
        {
          page: 1,
          per_page: "hey there!"
        }
      end

      it 'should respond with an invalid per_page error' do
        get :index, params: params
        response_json = JSON.parse(response.body)
        expect(response_json['success']).to eq(false)
        expect(response_json['message']).to eq("Invalid per page.")
      end
    end
  end

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
end
