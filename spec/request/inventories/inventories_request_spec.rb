require 'rails_helper'

RSpec.describe "inventories", type: :request do
  describe "GET index inventories" do 
    it 'Testing endpoint index' do 
      get '/api/v1/inventories.json'
      expect(response).to render_template("api/v1/inventories/index")
    end
  end

  describe "GET show inventories" do 
    it 'Testing endpoint Show' do 
      get '/api/v1/inventories/show.json', params: { id: '1' }
      expect(response).to render_template("api/v1/inventories/show")
      expect(response.status).to eq(200)
    end
  end

  describe "Create inventories" do 
    it 'Testing endpoint Create' do 
      post '/api/v1/inventories/create', params: { name:'entrada1', inventory_id:'1', name_lot:'Lote1' }      
      expect(response.status).to eq(201)
      
    end
  end

  describe "destroy inventories" do 
    it 'Testing endpoint Destroy' do 
      delete '/api/v1/inventories/destroy', params: { id: '1' }      
      expect(response.status).to eq(304)
      
    end
  end
end
