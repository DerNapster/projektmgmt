class PbstablesController < ApplicationController
  before_action :set_pbstable, only: [:show, :edit, :update, :destroy]

  # GET /pbstables
  # GET /pbstables.json
  def index
    @pbstables = Pbstable.all
  end

  # GET /pbstables/1
  # GET /pbstables/1.json
  def show
  end

  # GET /pbstables/new
  def new
    @pbstable = Pbstable.new
  end

  # GET /pbstables/1/edit
  def edit
  end

  # POST /pbstables
  # POST /pbstables.json
  def create
    @pbstable = Pbstable.new(pbstable_params)

    respond_to do |format|
      if @pbstable.save
        format.html { redirect_to @pbstable, notice: 'Pbstable was successfully created.' }
        format.json { render :show, status: :created, location: @pbstable }
      else
        format.html { render :new }
        format.json { render json: @pbstable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pbstables/1
  # PATCH/PUT /pbstables/1.json
  def update
    respond_to do |format|
      if @pbstable.update(pbstable_params)
        format.html { redirect_to @pbstable, notice: 'Pbstable was successfully updated.' }
        format.json { render :show, status: :ok, location: @pbstable }
      else
        format.html { render :edit }
        format.json { render json: @pbstable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pbstables/1
  # DELETE /pbstables/1.json
  def destroy
    @pbstable.destroy
    respond_to do |format|
      format.html { redirect_to pbstables_url, notice: 'Pbstable was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pbstable
      @pbstable = Pbstable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pbstable_params
      params.require(:pbstable).permit(:name, :project_id)
    end
end
