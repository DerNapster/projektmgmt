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
      ramHash = Hash.new
      pbsid = pbs.id
      pbsname = pbs.name
      level = pbs.level
      ramHash["node_id"] = pbsid
      ramHash["nodename"] = pbsname
      ramHash["level"] = level
      ramHash["order"] = index
      ramHash["project_id"] = projectId
      ramHash["projectname"] = Project.where(id: projectId).first.name
      ramHash["roleArray"] = Array.new
      ramObject = Ram.where(project_id: projectId, node_id: pbsid).includes(:workpackage).first

      if ramObject
        if ramObject.allocatable == true
          workpackageid = ramObject.workpackage_id
          workpackagename = ramObject.workpackage.name
          roles = Array.new
          ramObject.roles.each do |role|
            roleHash = Hash.new
            roleHash["roleid"] = role.id
            roleHash["rolename"] = role.name
            roles << roleHash
          end
          # Leeres Feld im Array mitgeben, für Update
          roleHash = Hash.new
          roleHash["roleid"] = ''
          roleHash["rolename"] = ''
          roles << roleHash
          ramHash["workpackage_id"] = workpackageid
          ramHash["workpackagename"] = workpackagename
          ramHash["roleArray"] = roles
        end
      else
        allNodeParentIds = getnodeparentids(projectId)
        if allNodeParentIds.inculde?(pbsid)
          ramObject = Ram.new(:order => index, :level => level, :node_id => pbs, :project_id => projectId, :allocatable => false)
        else
          ramObject = Ram.new(:order => index, :level => level, :node_id => pbs, :project_id => projectId, :allocatable => true)
        end
        ramObject.save
        # Leeres Feld im Array mitgeben, für Update
        roleHash = Hash.new
        roleHash["roleid"] = ''
        roleHash["rolename"] = ''
        roles << roleHash
        ramHash["roleArray"] = roles
      end
      ramHash["id"] = ramObject.id
      ramHash["allocatable"] = ramObject.allocatable
      @ramobjects << ramHash
      index = index + 1
    end
    respond_to do |format|
      format.json { render json: @ramobjects }
    end
  end

    # GET :project_id/ram/wbs
  def getwbsforram
    allParentIds = getworkpackageparentids params[:project_id]

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

  # GET :project_id/ram/wbs
  def getpbsforram
    allParentIds = Node.where(project_id: params[:project_id]).map { |wp| wp.parent_id }
    allParentIds.uniq

    allNodes = Node.where(project_id: params[:project_id]).order(:name).map {|wp| {id: wp.id, name: wp.name}}
    @nodes = Array.new

    allNodes.each do  |node|
      if allParentIds.include?(node["id".to_sym]) == false
        @nodes << node
      end
    end
    respond_to do |format|
      format.json { render json: @nodes }
    end
  end

  # GET :project_id/ram/rbs
  def getrbsforram
    allParentIds = Role.where(project_id: params[:project_id]).map { |wp| wp.parent_id }
    allParentIds.uniq

    allRoles = Role.where(project_id: params[:project_id]).order(:name).map {|wp| {id: wp.id, name: wp.name}}
    @roles = Array.new

    allRoles.each do  |role|
      if allParentIds.include?(role["id".to_sym]) == false
        @roles << role
      end
    end
    respond_to do |format|
      format.json { render json: @roles }
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
        roleArray = params[:roleArray]
        if roleArray != nil
          roleArray.each do |roleParam|
            @ram.roles << Role.find(roleParam["id"])
          end
        end
        @ram.workpackage_id = params[:workpackage_id]
        @ram.save
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
      params.require(:ram).permit(:workpackage_id, :node_id, :project_id, :level, :order, :allocatable, :roleArray)
    end

end
