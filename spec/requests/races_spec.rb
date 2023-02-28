require 'rails_helper'

RACES_NUMBER = 5

RSpec.describe 'Races', type: :request do
  describe 'GET /races' do
    context 'when there are no records' do
      it 'renders an empty array' do
        get '/races', headers: { 'Accept': 'application/json' }
        expect(JSON.parse(response.body)).to eq([])
      end
    end

    context 'when there are records' do
      it 'returns http status 200' do
        get '/races', headers: { 'Accept': 'application/json' }
        expect(response).to have_http_status(:ok)
      end

      let!(:races) { create_list(:race, RACES_NUMBER) }
      it 'renders races JSON objects' do
        get '/races', headers: { 'Accept': 'application/json' }
        expect(JSON.parse(response.body).size).to eq(RACES_NUMBER)
      end
    end
  end

  describe 'POST /races' do
    let(:tournament) { create(:tournament) }
    let(:racer) { create(:racer)           }

    context 'when correct arguments are passed' do
      it 'returns http status 201' do
        post '/races', params: {'place': 'Piaui', 'date': Date.new(2023, 1, 1), 'tournament_id': tournament.id, 'placement_attributes': ['racer_id': racer.id, 'position': 1]}
        expect(response).to have_http_status(:created)
      end

      it 'creates a new race' do
        expect {
          post '/races', params: {'place': 'Piaui', 'date': Date.new(2023, 1, 1), 'tournament_id': tournament.id, 'placement_attributes': ['racer_id': racer.id, 'position': 1]}
        }.to change(Race, :count).by(1)
      end
    end

    context 'when wrong arguments are passed' do
      it 'returns http status 422' do
        post '/races', params: {'date': Date.new(2023, 1, 1), 'tournament_id': tournament.id, 'placement_attributes': ['racer_id': racer.id, 'position': 1]}
        expect(response).to have_http_status(:unprocessable_entity)
      end

      context "when 'place' parameter is missing" do
        it 'issues an error message telling it cannot be blank' do
          post '/races', params: {'date': Date.new(2023, 1, 1), 'tournament_id': tournament.id, 'placement_attributes': ['racer_id': racer.id, 'position': 1]}
          expect(JSON.parse(response.body)['errors']['place']).to eq(["can't be blank"])
        end
      end

      context "when 'date' parameter is missing" do
        it 'issues an error message telling it cannot be blank' do
          post '/races', params: {'place': 'anywhere', 'tournament_id': tournament.id, 'placement_attributes': ['racer_id': racer.id, 'position': 1]}
          expect(JSON.parse(response.body)['errors']['date']).to eq(["can't be blank"])
        end
      end

      context "when 'tournament_id' parameter is missing" do
        it 'issues an error message telling it must exist' do
          post '/races', params: {'place': 'anywhere', 'date': Date.new(2023, 1, 1), 'placement_attributes': ['racer_id': racer.id, 'position': 1]}
          expect(JSON.parse(response.body)['errors']['tournament']).to eq(['must exist'])
        end
      end
    end
  end

  describe 'SHOW /races/:id' do
    context 'when the record is found' do
      let!(:race) { create(:race) }
      it 'returns http status 200' do
        get "/races/#{race.id}", headers: {'Accept': 'application/json'}
        expect(response).to have_http_status(:ok)
      end

      it 'renders a race JSON object' do
        get "/races/#{race.id}", headers: {'Accept': 'application/json'}
        expect(JSON.parse(response.body)['place']).to eq(race.place)
      end
    end

    context 'when the record is not found' do
      it 'returns http status 404' do
        get '/races/1', headers: {'Accept': 'application/json'}
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE /races/:id' do
    let!(:race) { create(:race) }
    it 'returns http status 204' do
      delete "/races/#{race.id}"
      expect(response).to have_http_status(:no_content)
    end

    it 'deletes a race record' do
      expect { delete "/races/#{race.id}" }.to change(Race, :count).by(-1)
    end
  end
end
