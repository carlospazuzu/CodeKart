require 'rails_helper'

NUMBER_OF_RACERS = 3

RSpec.describe 'Racers', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/racers/', headers: { 'Accept': 'application/json' }
      expect(response).to have_http_status(:success)
    end

    context 'when there are no records' do
      it 'returns an empty array' do
        get '/racers/', headers: { 'Accept': 'application/json' }
        expect(response.body).to eq('[]')
      end
    end

    context 'when there are saved records' do
      let!(:racers) { create_list(:racer, NUMBER_OF_RACERS) }
      it 'returns an array of racers' do
        get '/racers/', headers: { 'Accept': 'application/json' }
        expect(JSON.parse(response.body).size).to eq(NUMBER_OF_RACERS)
      end
    end
  end

  describe 'POST /racers' do
    let(:racer) { build(:racer) }
    it 'returns https status 201' do
      post '/racers/', params: {'racer': {'name': racer.name, 'born_at': racer.born_at, 'image_url': racer.image_url }}
      expect(response).to have_http_status(:created)
    end

    context 'when correct parameters are given' do
      it 'creates a new racer' do
        expect {
          post '/racers/', params: { 'racer': { 'name': racer.name, 'born_at': racer.born_at, 'image_url': racer.image_url } } 
        }.to change(Racer, :count).by(1)
      end
    end

    context 'when wrong parameters are given' do
      it 'returns a https status 422' do
        post '/racers/', params: { 'racer': { 'name': '', 'born_at': racer.born_at, 'image_url': racer.image_url } }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      context 'when no name is given' do
        it 'issues a message telling it cannot be blank' do
          post '/racers/', params: { 'racer': { 'name': '', 'born_at': racer.born_at, 'image_url': racer.image_url } }
          expect(JSON.parse(response.body)['errors']['name']).to eq(["can't be blank"])
        end
      end

      context 'when no birth date is given' do
        it 'returns an array of with both possible errors (cannot be blank and must be older than 18 years old)' do
          post '/racers/', params: { 'racer': { 'name': racer.name, 'born_at': nil, 'image_url': racer.image_url } }
          expect(JSON.parse(response.body)['errors']['born_at']).to eq(["can't be blank", 'Need to be at least 18 years old!'])
        end
      end

      context 'when a birth date of an underaged person is given' do
        it 'issues a message telling it must be older than 18 years old' do
          post '/racers/', params: { 'racer': { 'name': racer.name, 'born_at': 14.years.ago, 'image_url': racer.image_url } }
          expect(JSON.parse(response.body)['errors']['born_at']).to eq(['Need to be at least 18 years old!'])
        end
      end
    end
  end

  describe 'GET /destroy' do
    let!(:racer) { create(:racer) }

    it 'returns http status 204' do
      delete '/racers/1'
      expect(response).to have_http_status(:no_content)
    end

    it 'deletes a racer' do
      expect { delete '/racers/1' }.to change(Racer, :count).by(-1)
    end
  end

  describe 'GET /update' do
    let!(:racer) { create(:racer) }

    it 'returns http success' do
      patch '/racers/1', params: { 'racer': { 'name': 'Esmilinguido' } }
      expect(response).to have_http_status(:success)
    end

    it 'changes a recorded data' do
      patch '/racers/1', params: { 'racer': { 'name': 'Esmilinguido' } }
      expect(Racer.find(1).name).to eq('Esmilinguido')
    end
  end

  describe 'GET /show' do
    let!(:racer) { create(:racer) }
    it 'returns http success' do
      get "/racers/#{racer.id}", headers: { 'Accept': 'application/json' }
      expect(response).to have_http_status(:success)
    end

    it 'exhibits the requested racer' do
      get "/racers/#{racer.id}", headers: { 'Accept': 'application/json' }
      expect(JSON.parse(response.body)['name']).to eq(racer.name)
    end
  end
end
