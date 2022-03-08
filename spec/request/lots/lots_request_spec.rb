require 'rails_helper'

RSpec.describe "Lots", type: :request do
  describe "GET index lots" do 
    it 'Testing endpoint index' do 
      get '/api/v1/lots.json'
      expect(response).to render_template("api/v1/lots/index")
    end
  end

  describe "GET show lots" do 
    it 'Testing endpoint Show' do 
      get '/api/v1/lots/show.json', params: { id: '1' }
      expect(response).to render_template("api/v1/lots/show")
      expect(response.status).to eq(200)
    end
  end

  describe "destroy lots" do 
    it 'Testing endpoint Destroy' do 
      delete '/api/v1/lots/destroy', params: { id: '1' }      
      expect(response.status).to eq(304)
      
    end
  end
end
