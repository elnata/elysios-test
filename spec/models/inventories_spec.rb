require "rails_helper"
RSpec.describe "Este teste é para validar o model inventories" do
    it "testa a instancia do estoque" do
        expect(Inventory.new).to be_present  
    end

    it "testa o metodo_save" do
        inventory = Inventory.new
        inventory.name = 'teste'
        expect(inventory.save).to be_truthy
    end 
end