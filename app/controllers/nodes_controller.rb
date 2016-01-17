class NodesController < ApplicationController
  before_action :set_node, only: [:show, :edit, :update, :destroy]


  # GET /nodes
  # GET /nodes.json
  def index
    nodeList = Node.where(project_id: params[:project_id])
    @nodes = sort_list_with_parent nodeList

    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'ID' )
    data_table.new_column('string', 'Parent')
    data_table.new_column('string', 'ToolTip')

    puts "----Nodessize: " + nodeList.size.to_s
    nodeList.each do |nodeItem|
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
    @pbsChart = generate_organisation_graph data_table

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

    @node.level = @node.parent.level+1

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
      params.require(:node).permit(:name, :description, :level, :duration, :startdate, :enddate, :milestone, :project_id, :parent_id)
    end

    def sort_list_with_parent(list)
      puts "----List size: " + list.size.to_s
      rootElementList = list.where(parent_id: nil)
      puts "----RootElementList size: " + rootElementList.size.to_s
      sortedList = Array.new
      rootElement = rootElementList.first
      puts "----Neues Array: " + sortedList.size.to_s
      add_to_sorted_array sortedList, rootElement
      puts "----Neues Array nach einfügen: " + sortedList.size.to_s
      sortedList
    end

    def add_to_sorted_array array, element
      array << element
      if element != nil
        puts "----Element ist nicht null"
        if element.children != nil
          element.children.each do |childElement|
            add_to_sorted_array array, childElement
          end
        end
      else
        puts "----Element is null"
      end
    end
end
