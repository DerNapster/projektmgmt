class RbstablesController < ApplicationController
  before_action :set_rbstable, only: [:show, :edit, :update, :destroy]

  # GET /rbstables
  # GET /rbstables.json
  def index
    @rbstables = Rbstable.all
  end

  # GET /rbstables/1
  # GET /rbstables/1.json
  def show
  end

  # GET /rbstables/new
  def new
    @rbstable = Rbstable.new
  end

  # GET /rbstables/1/edit
  def edit
  end

  # POST /rbstables
  # POST /rbstables.json
  def create
    @rbstable = Rbstable.new(rbstable_params)

    respond_to do |format|
      if @rbstable.save
        format.html { redirect_to @rbstable, notice: 'Rbstable was successfully created.' }
        format.json { render :show, status: :created, location: @rbstable }
      else
        format.html { render :new }
        format.json { render json: @rbstable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rbstables/1
  # PATCH/PUT /rbstables/1.json
  def update
    respond_to do |format|
      if @rbstable.update(rbstable_params)
        format.html { redirect_to @rbstable, notice: 'Rbstable was successfully updated.' }
        format.json { render :show, status: :ok, location: @rbstable }
      else
        format.html { render :edit }
        format.json { render json: @rbstable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rbstables/1
  # DELETE /rbstables/1.json
  def destroy
    @rbstable.destroy
    respond_to do |format|
      format.html { redirect_to rbstables_url, notice: 'Rbstable was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rbstable
      @rbstable = Rbstable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rbstable_params
      params.require(:rbstable).permit(:name, :project_id)
    end
end
