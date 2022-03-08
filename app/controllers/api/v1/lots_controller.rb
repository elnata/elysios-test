class Api::V1::LotsController < Api::V1::ApiController
    before_action :set_lots, only: [:show, :update, :destroy]
 
    # before_action :require_authorization!, only: [:show, :update, :destroy]
    
    # GET /api/v1/lots
    
    def index
        
        @lots = Lot.all
    
    end
    
    # GET /api/v1/lots/1
    
    def show
    
        @lots
    
    end
    
    # POST /api/v1/lots
    
    def create

        unless lots_params[:unit_measurement].upcase == 'KG' || lots_params[:unit_measurement].upcase == 'T'
            render json: 'only "KG" or "T" values are allowed', status: :unprocessable_entity
        else
            soma_lote(lots_params)
            @lots = Lot.new
            @lots.name = lots_params[:name]
            @lots.weight = lots_params[:weight]
            @lots.unit_measurement = lots_params[:unit_measurement].upcase
            @lots.input_id = lots_params[:input_id]
            
            if @lots.save
            
                render json: @lots, status: :created
            
            else
            
                render json: @lots.errors, status: :unprocessable_entity
            
            end
        end
        

        

    end
    
    # PATCH/PUT /api/v1/lots/1
    
    def update
    
        if @lots.update(lots_params)
        
            render json: @lots
        
        else
        
            render json: @lots.errors, status: :unprocessable_entity
        
        end
    
    end
    
    # DELETE /api/v1/lots/1
    
    def destroy
    
        if @lots.present?
            remove_lot_entrada(@lots)
            @lots.destroy
            render_send('successfully deleted', :no_content)
        else
            render_send('not successfully deleted', :not_modified)    
        end        
    
    end

    
    
    private

    def remove_lot_entrada(lots)

        weight_lot =  lots.weight
        input = Input.find_by(id: lots.input_id)
        inventory = Inventory.find_by(id: input.inventory_id)

        input_weight = input.weight.to_f - weight_lot.to_f
        inventory_weight = inventory.weight.to_f - weight_lot.to_f

        Input.update(input.id, :weight => input_weight)
        Inventory.update(input.inventory_id, :weight => inventory_weight)
        
    end

    def render_send(msg, status)

        render json: msg, status: status

    end

    def soma_lote(lots_params)

        input = Input.find_by(id: lots_params[:input_id])  

        weight_total = input.weight.to_f
        unit_measurement_total = input.unit_measurement 

        if lots_params[:unit_measurement].upcase == 'T'
            lots_weight = lots_params[:weight].to_f * 1000
        else
            lots_weight = lots_params[:weight]
        end

        if unit_measurement_total.upcase == 'T'
            
            
            total = weight_total * 1000
            total = total + lots_weight.to_f
            total = total / 1000            
        else
            total = weight_total + lots_weight.to_f
            if total >= 1000
                total = total / 1000 
                unit_measurement_total = 'T'
            end
            
        end

       

        Input.update(input.id, :weight => total, :unit_measurement => unit_measurement_total.upcase)
        Inventory.update(input.inventory_id, :weight => total, :unit_measurement => unit_measurement_total.upcase)
        
        
    end
    
    # Use callbacks to share common setup or constraints between actions.
    
    def set_lots
    
        @lots = Lot.find_by(id: params[:id])
    
    end
    
    # Only allow a trusted parameter "white list" through.
    
    def lots_params
    
        params.permit(:name, :weight, :unit_measurement, :input_id)
    
    end
    
    def require_authorization!
    
        if !current_user.present?

    
        render json: {}, status: :forbidden
    
        end
    
    end
end
