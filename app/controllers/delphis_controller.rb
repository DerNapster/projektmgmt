class DelphisController < ApplicationController
  before_action :set_delphi, only: [:show, :edit, :update, :destroy]

  include DelphisHelper

  # GET /delphis
  # GET /delphis.json
  def index
    @delphis = Delphi.all
  end

  # GET /:project_id/delphi/:name
  # GET /:project_id/delphi/:name.json
  def workpackagesforuser
    allDelphis = Delphi.where(name: params[:name])
    if allDelphis.size == 0
      @delphis = Workpackage.where(project_id: params[:project_id]).map {|wp| {id: wp.id, name: wp.name, value: ''}}
    else
      @delphis = Array.new

      allDelphis.each do |delphi|
        avg = get_avg_of_workpackage delphi.workpackage_id
        if (delphi.value > (avg*1.2)) || (delphi.value < (avg*0.8))
          @delphis << delphi
        end
      end

    end
    respond_to do |format|
      format.json { render json: @delphis }
    end
  end

  def savedelphis
    saved = true
    username = params[:username]
    workpackageArray = params[:array]
    workpackageArray.each do |item|
      workpackageid = item["workpackageid"]
      duration = item["duration"]
      delphi = Delphi.new(:name => username, :workpackage_id => workpackageid, :value => duration)
      if delphi.save
        saved = saved & true
      else
        saved = saved & false
      end
    end

    respond_to do |format|
      if saved
        format.json { render json: '200'}
      else
        format.json { render json: '501'}
      end
    end

  end

  def evaluation

  end

  # GET /delphis/1
  # GET /delphis/1.json
  def show
  end

  # GET /delphis/new
  def new
    @delphi = Delphi.new
  end

  # GET /delphis/1/edit
  def edit
  end

  # POST /delphis
  # POST /delphis.json
  def create
    @delphi = Delphi.new(delphi_params)

    respond_to do |format|
      if @delphi.save
        format.html { redirect_to @delphi, notice: 'Delphi was successfully created.' }
        format.json { render :show, status: :created, location: @delphi }
      else
        format.html { render :new }
        format.json { render json: @delphi.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /delphis/1
  # PATCH/PUT /delphis/1.json
  def update
    respond_to do |format|
      if @delphi.update(delphi_params)
        format.html { redirect_to @delphi, notice: 'Delphi was successfully updated.' }
        format.json { render :show, status: :ok, location: @delphi }
      else
        format.html { render :edit }
        format.json { render json: @delphi.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /delphis/1
  # DELETE /delphis/1.json
  def destroy
    @delphi.destroy
    respond_to do |format|
      format.html { redirect_to delphis_url, notice: 'Delphi was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_delphi
      @delphi = Delphi.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def delphi_params
      params.require(:delphi).permit(:name, :workpackage_id, :value)
    end
end
