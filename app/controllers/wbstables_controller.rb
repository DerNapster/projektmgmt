class WbstablesController < ApplicationController
  before_action :set_wbstable, only: [:show, :edit, :update, :destroy]

  # GET /wbstables
  # GET /wbstables.json
  def index
    @wbstables = Wbstable.all
  end

  # GET /wbstables/1
  # GET /wbstables/1.json
  def show
  end

  # GET /wbstables/new
  def new
    @wbstable = Wbstable.new
  end

  # GET /wbstables/1/edit
  def edit
  end

  # POST /wbstables
  # POST /wbstables.json
  def create
    @wbstable = Wbstable.new(wbstable_params)

    respond_to do |format|
      if @wbstable.save
        format.html { redirect_to @wbstable, notice: 'Wbstable was successfully created.' }
        format.json { render :show, status: :created, location: @wbstable }
      else
        format.html { render :new }
        format.json { render json: @wbstable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wbstables/1
  # PATCH/PUT /wbstables/1.json
  def update
    respond_to do |format|
      if @wbstable.update(wbstable_params)
        format.html { redirect_to @wbstable, notice: 'Wbstable was successfully updated.' }
        format.json { render :show, status: :ok, location: @wbstable }
      else
        format.html { render :edit }
        format.json { render json: @wbstable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wbstables/1
  # DELETE /wbstables/1.json
  def destroy
    @wbstable.destroy
    respond_to do |format|
      format.html { redirect_to wbstables_url, notice: 'Wbstable was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wbstable
      @wbstable = Wbstable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wbstable_params
      params.require(:wbstable).permit(:name, :project_id)
    end
end
