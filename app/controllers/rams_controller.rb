class RamsController < ApplicationController
  before_action :set_ram, only: [:show, :edit, :update, :destroy]

  # GET /rams
  # GET /rams.json
  def index
    @rams = Ram.all
  end

  # GET /rams/1
  # GET /rams/1.json
  def show
  end

  # GET /rams/new
  def new
    @ram = Ram.new
  end

  # GET /rams/1/edit
  def edit
  end

  # GET /:project_id/ram
  def getramofproject
    projectId = params[:project_id]
    unsortedPbsObjects = Node.where(project_id: projectId)
    pbsObjects = sort_list_with_parent unsortedPbsObjects

    @ramobjects = Array.new
    index = 1
    pbsObjects.each do |pbs|
      pbsid = pbs.id
      pbsname = pbs.name
      level = pbs.level
      ramObject = Ram.where(project_id: projectId, node_id: pbsid).includes(:workpackage).includes(:project).first
      if ramObject
        puts "--" + ramObject.to_s
        projectname = ramObject.project.name
        workpackageid = ramObject.workpackage_id
        workpackagename = ramObject.workpackage.name
        roles = Array.new
        ramObject.roles.each do |role|
          roleHash = Hash.new
          roleHash["roleid"] = role.id
          roleHash["rolename"] = role.name
          roles << roleHash
        end


        ramHash = Hash.new
        ramHash["projectid"] = projectId
        ramHash["projectname"] = projectname
        ramHash["nodeid"] = pbsid
        ramHash["nodename"] = pbsname
        ramHash["level"] = level
        ramHash["order"] = index
        ramHash["workpackageid"] = workpackageid
        ramHash["workpackagename"] = workpackagename
        ramHash["roleArray"] = roles

        @ramobjects << ramHash
        index = index + 1
      end
    end

    respond_to do |format|
      format.json { render json: @ramobjects }
    end
  end

  # GET :project_id/ram/wbs
  def getwbsforram
    allParentIds = Workpackage.where(project_id: params[:project_id]).map { |wp| wp.parent_id }
    allParentIds.uniq

    allWorkpackages = Workpackage.where(project_id: params[:project_id]).order(:name).map {|wp| {id: wp.id, name: wp.name}}
    @workpackages = Array.new

    allWorkpackages.each do  |workpackage|
      if allParentIds.include?(workpackage["id".to_sym]) == false
        @workpackages << workpackage
      end
    end

    respond_to do |format|
      format.json { render json: @workpackages }
    end
  end

  # POST /rams
  # POST /rams.json
  def create
    @ram = Ram.new(ram_params)

    respond_to do |format|
      if @ram.save
        format.html { redirect_to @ram, notice: 'Ram was successfully created.' }
        format.json { render :show, status: :created, location: @ram }
      else
        format.html { render :new }
        format.json { render json: @ram.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rams/1
  # PATCH/PUT /rams/1.json
  def update
    respond_to do |format|
      if @ram.update(ram_params)
        format.html { redirect_to @ram, notice: 'Ram was successfully updated.' }
        format.json { render :show, status: :ok, location: @ram }
      else
        format.html { render :edit }
        format.json { render json: @ram.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rams/1
  # DELETE /rams/1.json
  def destroy
    @ram.destroy
    respond_to do |format|
      format.html { redirect_to rams_url, notice: 'Ram was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ram
      @ram = Ram.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ram_params
      params.require(:ram).permit(:workpackage_id, :node_id, :project_id, :level, :order)
    end
end
