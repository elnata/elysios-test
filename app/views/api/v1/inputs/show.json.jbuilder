
    json.set! "data" do
        json.inputs @inputs.each do |input|
            json.input input.id
            json.name input.name
            json.weight input.weight
            json.unit_measurement input.unit_measurement
            json.inventory_id input.inventory_id
            json.data input.created_at

            json.lots @lots.each do |lot|
                if lot.input_id == input.id
                    json.id lot.id
                    json.name lot.name
                    json.weight lot.weight
                    json.unit_measurement lot.unit_measurement
                    json.input_id lot.input_id
                    json.data lot.created_at
                end
            end
        end        
    end

