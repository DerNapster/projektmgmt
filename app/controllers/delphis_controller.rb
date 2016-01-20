class DelphisController < ApplicationController
  before_action :set_delphi, only: [:show, :edit, :update, :destroy]

  include DelphisHelper

  # GET /delphis
  # GET /delphis.json
  def index
    @delphis = Delphi.all
  end

  # GET /:project_id/users/graph
  def variance
    workpackage = Workpackage.where(project_id: params[:project_id]).map {|wp| {id: wp.id, name: wp.name, duration: wp.duration}}

    @delphiVariance = Array.new

    workpackage.each do |item|
      workpackageid = item["id".to_sym]
      workpackagename = item["name".to_sym]
      workpackageduration = item["duration".to_sym]

      allDelphisForPackage = Delphi.where(workpackage_id: workpackageid)

      countVariance = 0  # Anzahl der Delphis die vom AVG abweichen
      allDelphisForPackage.each do |delphi|
        if (delphi.value >= (workpackageduration*1.2)) || (delphi.value <= (workpackageduration*0.8))
          countVariance = countVariance + 1
        end
      end
      procentVariance = (countVariance / allDelphisForPackage.size)

      varianceObject = Hash.new
      varianceObject["workpackagename"] = workpackagename
      varianceObject["variance"] = procentVariance
      @delphiVariance << varianceObject
    end
    respond_to do |format|
      format.json { render json: @delphiVariance }
    end

  end

  # GET /:project_id/delphi/:name
  # GET /:project_id/delphi/:name.json
  def workpackagesforuser
    username = params[:name]
    allDelphis = Delphi.where(username: username)
    saved = true
    @delphis = nil
    if allDelphis.size == 0
      allParentIds = Workpackage.where(project_id: params[:project_id]).map { |wp| wp.parent_id }
      allParentIds.uniq

      workpackage = Workpackage.where(project_id: params[:project_id]).map {|wp| {id: wp.id, name: wp.name}}

      workpackage.each do |item|
        workpackageid = item["id".to_sym]
        if allParentIds.include?(workpackageid) == false
          workpackagename = item["name".to_sym]
          delphi = Delphi.new(:username => username, :workpackagename => workpackagename, :workpackage_id => workpackageid, :value => 0)
          if delphi.save
            saved = saved & true
          else
            saved = saved & false
          end
        end
      end
      @delphis = Delphi.where(username: username)
    else
      @delphis = Array.new
      allDelphis.each do |delphi|
        avg = get_avg_of_workpackage delphi.workpackage_id

        if (delphi.value >= (avg*1.2)) || (delphi.value <= (avg*0.8))
          @delphis << delphi
        end
      end
    end
    respond_to do |format|
      if saved
        format.json { render json: @delphis }
      else
        format.json { render json: '501'}
      end
    end
  end

  # GET /:project_id/delphi/evaluation
  def evaluation
    delphis = Delphi.all
    wpSet = []
    delphis.each do |delphi|
      if delphi.workpackage.project_id == params[:project_id]
        # alle WorkpackageIds zu einem Projekt
        wpSet << delphi.workpackage_id
      end
    end

    # überflüssige Einträge eliminieren
    wpSet.uniq

    wpSet.each do |wpId|
        # alle Delphieinträge zu einem Workpackage
        sameDelphis = Delphi.where(workpackage_id: wpId)
        sameDelphis.each do |delphi|
             
        end
    end
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
        workpackageid = @delphi.workpackage_id
        update_duration_of_workpackage(workpackageid)
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
    workpackageid = @delphi.workpackage_id
    @delphi.destroy
    update_duration_of_workpackage(workpackageid)
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
      params.require(:delphi).permit(:username, :workpackagename, :workpackage_id, :value)
    end
end
