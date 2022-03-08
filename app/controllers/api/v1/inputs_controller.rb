class Api::V1::InputsController < Api::V1::ApiController
    before_action :set_inputs, only: [:show, :update, :destroy]
 
    # before_action :require_authorization!, only: [:show, :update, :destroy]
    
    # GET /api/v1/inputs
    
    def index
        
        @inputs = Input.all
    
    end
    
    # GET /api/v1/inputs/1
    
    def show
       
      @inputs = Input.where(id: params[:id])
      if @inputs.present?
        @lots = Lot.where(input_id: @inputs.ids)
      end
    
    end
    
    # POST /api/v1/inputs
    
    def create        

       if !inputs_params[:inventory_id].present?
            render_send('Required inventory_id', :unprocessable_entity)
       else
            unless inputs_params[:unit_measurement_lot].upcase == 'KG' || inputs_params[:unit_measurement_lot].upcase == 'T'
                render json: 'only "KG" or "T" values are allowed', status: :unprocessable_entity
            else
                validate_create(inputs_params)
                soma_lote(inputs_params)
            end
       end
    
    end
    
    # PATCH/PUT /api/v1/inputs/1
    
    def update
    
        if @inputs.update(inputs_params)        
            render json: @inputs        
        else        
            render json: @inputs.errors, status: :unprocessable_entity        
        end
    
    end
    
    # DELETE /api/v1/inputs/1
    
    def destroy
 
        if @inputs.present?
            remove_lot_entrada(@inputs)
            @inputs.destroy
            render_send('successfully deleted', :no_content)
        else
            render_send('not successfully deleted', :not_modified)    
        end  
    
    end
    
    private

    def remove_lot_entrada(inputs)

        weight_inputs =  inputs.weight
        inventory = Inventory.find_by(id: inputs.inventory_id)
      
        inventory_weight = inventory.weight.to_f - weight_inputs.to_f

        Inventory.update(inputs.inventory_id, :weight => inventory_weight)
    end

    def soma_lote(inputs_params)
        
        inventories = Inventory.where(id: inputs_params[:inventory_id])
        
        inventories.each do |inventory|
            weight_total = inventory.weight.to_f
            unit_measurement_total = inventory.unit_measurement 

            if inputs_params[:unit_measurement].upcase == 'T'
                inputs_weight = inputs_params[:weight].to_f * 1000
            else
                inputs_weight = inputs_params[:weight]
            end

            if unit_measurement_total.upcase == 'T'
                total = weight_total * 1000
                total = total + inputs_weight.to_f
                total = total / 1000            
            else
                total = weight_total + inputs_weight.to_f
                if total >= 1000
                    total = total / 1000 
                    unit_measurement_total = 'T'
                end
                
            end
            Inventory.update(inventory.id, :weight => total, :unit_measurement => unit_measurement_total.upcase)
        end

        
    end

    def validate_create(inputs_params)
        inventories = Inventory.where(id: inputs_params[:inventory_id])     

        inventories.each do |inventory|
            
            if  !inventory.present?
                render_send('Required valid inventory_id', :unprocessable_entity)
            else             
                @inputs = Input.new
                @inputs.name = inputs_params[:name]
                @inputs.weight = inputs_params[:weight_lot]
                @inputs.unit_measurement = inputs_params[:unit_measurement_lot].upcase
                @inputs.inventory_id = inventory.id
    
                if @inputs.save 
    
                    @lots = Lot.new
                    @lots.name = inputs_params[:name_lot]
                    @lots.weight = inputs_params[:weight_lot]
                    @lots.unit_measurement = inputs_params[:unit_measurement_lot].upcase 
                    @lots.input_id = @inputs.id
                    
    
                    if @lots.save
                        puts 'salvou'
                        render json: @inputs, status: :created
                    else
                        puts 'erro'
                        @inputs.destroy
                        render json: @lots.errors, status: :unprocessable_entity
                    end
                    
                
                else
                    puts 'erro'
                    render json: @inputs.errors, status: :unprocessable_entity
                
                end
            end 
        end
        
    end
    

    def render_send(msg, status)

        render json: msg, status: status
        
    end
    
    # Use callbacks to share common setup or constraints between actions.
    
    def set_inputs
    
        @inputs = Input.find_by(id: params[:id])
    
    end
    
    # Only allow a trusted parameter "white list" through.
    
    def inputs_params
    
        params.permit(:name, :inventory_id, :name_lot, :weight_lot, :unit_measurement_lot)
    
    end
    
    def require_authorization!
    
        if !current_user.present?    

        render json: {}, status: :forbidden
    
        end
    
    end
end
