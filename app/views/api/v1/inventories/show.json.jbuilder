
    json.set! "data" do    
        if @inventories.present?
            json.inventories @inventories.id
            json.name @inventories.name
            json.weight @inventories.weight
            json.unit_measurement @inventories.unit_measurement
            json.data @inventories.created_at
    
            json.inputs @inputs.each do |input|
                if input.inventory_id == @inventories.id
                    json.id input.id
                    json.name input.name
                    json.weight input.weight
                    json.unit_measurement input.unit_measurement
                    json.inventory_id input.inventory_id
                    json.data input.created_at
                end
            end
        else
            json.erro 'data not found'
        end 


    end
