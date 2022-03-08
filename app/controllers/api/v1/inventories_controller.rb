class Api::V1::InventoriesController < Api::V1::ApiController
    before_action :set_inventories, only: [:show, :update, :destroy]

    
    # GET /api/v1/inventories
    
    def index
        
        @inventories = Inventory.all
    
    end
    
    # GET /api/v1/inventories/1
    
    def show
    
        @inventories
        if @inventories.present?
            @inputs = Input.where(inventory_id: @inventories.id)
        end       
    
    end
    
    # POST /api/v1/inventories
    
    def create
    
        @inventories = Inventory.new
        @inventories.name = inventories_params[:name]
        @inventories.weight = 0
        @inventories.unit_measurement = 'KG'
        
        if @inventories.save
        
            render json: @inventories, status: :created
        
        else
        
            render json: @inventories.errors, status: :unprocessable_entity
        
        end
    
    end
    
    # PATCH/PUT /api/v1/inventories/1
    
    def update
    
        if @inventories.update(inventories_params)
        
            render json: @inventories
        
        else
        
            render json: @inventories.errors, status: :unprocessable_entity
        
        end
    
    end
    
    # DELETE /api/v1/inventories/1
    
    def destroy

        if @inventories.present?
            @inventories.destroy
            render_send('successfully deleted', :no_content)
        else
            render_send('not successfully deleted', :not_modified)    
        end
    
    end
    
    private

    def render_send(msg, status)

        render json: msg, status: status
        
    end
    
    # Use callbacks to share common setup or constraints between actions.
    
    def set_inventories
    
        @inventories = Inventory.find_by(id: params[:id])
    
    end
    
    # Only allow a trusted parameter "white list" through.
    
    def inventories_params
    
        params.permit(:name, :weight, :unit_measurement)
    
    end
  
end
