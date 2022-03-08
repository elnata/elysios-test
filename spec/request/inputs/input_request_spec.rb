require 'rails_helper'

RSpec.describe "Inputs", type: :request do
    
  describe "GET index inputs" do 
    it 'Testing endpoint index' do 
      get '/api/v1/inputs.json'
      expect(response).to render_template("api/v1/inputs/index")
    end
  end

  describe "GET show inputs" do 
    it 'Testing endpoint Show' do 
      get '/api/v1/inputs/show.json', params: { id: '1' }
      expect(response).to render_template("api/v1/inputs/show")
      expect(response.status).to eq(200)
    end
  end

  describe "Create inputs" do 
    it 'Testing endpoint Create' do 
      post '/api/v1/inputs/create', params: { name:'entrada1', inventory_id:'1', name_lot:'Lote1', weight_lot:'60', unit_measurement_lot:'t' }      
      expect(response.status).to eq(204)
      
    end
  end

  describe "destroy inputs" do 
    it 'Testing endpoint Destroy' do 
      delete '/api/v1/inputs/destroy', params: { id: '1' }      
      expect(response.status).to eq(304)
      
    end
  end
end


