class WorkpackagesController < ApplicationController
  before_action :set_workpackage, only: [:show, :edit, :update, :destroy]

  # GET /workpackages
  # GET /workpackages.json
  def index
    workpackageList = Workpackage.where(project_id: params[:project_id])
    @workpackages = sort_list_with_parent workpackageList
  end

  def graph
    workpackageList = Workpackage.where(project_id: params[:project_id])

    # data_table = GoogleVisualr::DataTable.new
    # data_table.new_column('string', 'ID' )
    # data_table.new_column('string', 'Parent')
    # data_table.new_column('string', 'ToolTip')

    res= Array.new

    # Im Moment Workpackage.all später aber nur noch die workpackages zu einer WBSTable, dann muss bei dem Aufruf eine WBSTable-ID mitgegeben werden
    workpackageList.each do |workpackage|
      workpackageId = workpackage.id.to_s
      workpackageName = workpackage.name
      workpackageDescription = workpackage.description
      workpackageParent = workpackage.parent
      workpackageParentId = ''
      if workpackageParent != nil
        workpackageParentId = workpackageParent.id.to_s
      end
      if workpackageDescription == nil
        workpackageDescription = ''
      end

      res.push([{v: workpackageId, f: workpackageName}, workpackageParentId, workpackageDescription]);
      # data_table.add_row([{v: workpackageId, f: workpackageName}, workpackageParentId, workpackageDescription])

    end

    respond_to do |format|
      format.html { render :new }
      format.json { render json: res }
    end
    #@wbsChart = generate_organisation_graph data_table
  end

  # GET /workpackages/1
  # GET /workpackages/1.json
  def show
  end

  # GET /workpackages/new
  def new
    @workpackage = Workpackage.new
  end

  # GET /workpackages/1/edit
  def edit
  end

  # POST /workpackages
  # POST /workpackages.json
  def create
    @workpackage = Workpackage.new(workpackage_params)
    @workpackage.level = @workpackage.parent.level + 1

    respond_to do |format|
      if @workpackage.save
        format.html { redirect_to @workpackage, notice: 'Workpackage was successfully created.' }
        format.json { render :show, status: :created, location: @workpackage }
      else
        format.html { render :new }
        format.json { render json: @workpackage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workpackages/1
  # PATCH/PUT /workpackages/1.json
  def update
    respond_to do |format|
      if @workpackage.update(workpackage_params)
        format.html { redirect_to @workpackage, notice: 'Workpackage was successfully updated.' }
        format.json { render :show, status: :ok, location: @workpackage }
      else
        format.html { render :edit }
        format.json { render json: @workpackage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workpackages/1
  # DELETE /workpackages/1.json
  def destroy
    @workpackage.destroy
    respond_to do |format|
      format.html { redirect_to workpackages_url, notice: 'Workpackage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workpackage
      @workpackage = Workpackage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def workpackage_params
      params.require(:workpackage).permit(:name, :description, :result, :interfaces, :purchaser, :level, :duration, :startdate, :enddate, :activities, :requirements, :costs, :work, :workPerformed, :project_id, :parent_id)
    end
end
