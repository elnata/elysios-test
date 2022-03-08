require "rails_helper"
RSpec.describe "Este teste é para validar o model Input" do
    it "testa a instancia do estoque" do
        expect(Input.new).to be_present  
    end

    it "testa o metodo_save" do
        inputs = Input.new
        inputs.name = 'teste'
        inputs.weight = '60'
        inputs.unit_measurement = 'KG'
        expect(inputs.save).to be_truthy
    end 
end