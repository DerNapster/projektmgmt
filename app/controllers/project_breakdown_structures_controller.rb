class ProjectBreakdownStructuresController < ApplicationController
  before_action :set_project_breakdown_structure, only: [:show, :edit, :update, :destroy]

  # GET /project_breakdown_structures
  # GET /project_breakdown_structures.json
  def index
    @project_breakdown_structures = ProjectBreakdownStructure.all
  end

  # GET /project_breakdown_structures/1
  # GET /project_breakdown_structures/1.json
  def show
  end

  # GET /project_breakdown_structures/new
  def new
    @project_breakdown_structure = ProjectBreakdownStructure.new
  end

  # GET /project_breakdown_structures/1/edit
  def edit
  end

  # POST /project_breakdown_structures
  # POST /project_breakdown_structures.json
  def create
    @project_breakdown_structure = ProjectBreakdownStructure.new(project_breakdown_structure_params)

    respond_to do |format|
      if @project_breakdown_structure.save
        format.html { redirect_to @project_breakdown_structure, notice: 'Project breakdown structure was successfully created.' }
        format.json { render :show, status: :created, location: @project_breakdown_structure }
      else
        format.html { render :new }
        format.json { render json: @project_breakdown_structure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /project_breakdown_structures/1
  # PATCH/PUT /project_breakdown_structures/1.json
  def update
    respond_to do |format|
      if @project_breakdown_structure.update(project_breakdown_structure_params)
        format.html { redirect_to @project_breakdown_structure, notice: 'Project breakdown structure was successfully updated.' }
        format.json { render :show, status: :ok, location: @project_breakdown_structure }
      else
        format.html { render :edit }
        format.json { render json: @project_breakdown_structure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_breakdown_structures/1
  # DELETE /project_breakdown_structures/1.json
  def destroy
    @project_breakdown_structure.destroy
    respond_to do |format|
      format.html { redirect_to project_breakdown_structures_url, notice: 'Project breakdown structure was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_breakdown_structure
      @project_breakdown_structure = ProjectBreakdownStructure.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_breakdown_structure_params
      params.require(:project_breakdown_structure).permit(:title)
    end
end
