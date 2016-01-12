class NodesController < ApplicationController
  before_action :set_node, only: [:show, :edit, :update, :destroy]

  # GET /nodes
  # GET /nodes.json
  def index
    @nodes = Node.all

    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'ID' )
    data_table.new_column('string', 'Parent')
    data_table.new_column('string', 'ToolTip')

    # Im Moment Nodes.all später aber nur noch die notes zu einer PBSTable, dann muss bei dem Aufruf eine PBSTable-ID mitgegeben werden
    @nodes.each do |nodeItem|
      puts "iiii"
      nodeId = nodeItem.id.to_s
      nodeName = nodeItem.name
      nodeDescription = nodeItem.description
      nodeParent = nodeItem.parent
      nodeParentId = ''
      if nodeParent != nil
        nodeParentId = nodeParent.id.to_s
      end
      if nodeDescription == nil
        nodeDescription = ''
      end

      data_table.add_row([{v: nodeId, f: nodeName}, nodeParentId, nodeDescription])

    end

    option = { width: 400, height: 400, title: 'Product Breakdown Structure', version: '1.1', allowHtml: true, size: 'large' }
    @pbsChart = GoogleVisualr::Interactive::OrgChart.new(data_table, option)
  end

  # GET /nodes/1
  # GET /nodes/1.json
  def show
  end

  # GET /nodes/new
  def new
    @node = Node.new
  end

  # GET /nodes/1/edit
  def edit
  end

  # POST /nodes
  # POST /nodes.json
  def create
    @node = Node.new(node_params)

    respond_to do |format|
      if @node.save
        format.html { redirect_to @node, notice: 'Node was successfully created.' }
        format.json { render :show, status: :created, location: @node }
      else
        format.html { render :new }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nodes/1
  # PATCH/PUT /nodes/1.json
  def update
    respond_to do |format|
      if @node.update(node_params)
        format.html { redirect_to @node, notice: 'Node was successfully updated.' }
        format.json { render :show, status: :ok, location: @node }
      else
        format.html { render :edit }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nodes/1
  # DELETE /nodes/1.json
  def destroy
    @node.destroy
    respond_to do |format|
      format.html { redirect_to nodes_url, notice: 'Node was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_node
      @node = Node.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def node_params
      params.require(:node).permit(:name, :description, :level, :duration, :startdate, :enddate, :milestone, :pbstable_id, :parent_id)
    end
end
