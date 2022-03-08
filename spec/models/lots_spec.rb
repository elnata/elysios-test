require "rails_helper"
RSpec.describe "Este teste é para validar o model Lot" do
    it "testa a instancia do estoque" do
        expect(Lot.new).to be_present  
    end

    it "testa o metodo_save" do
        lots = Lot.new
        lots.name = 'teste'
        lots.weight = '60'
        lots.unit_measurement = 'KG'
        expect(lots.save).to be_truthy
    end 
    
end