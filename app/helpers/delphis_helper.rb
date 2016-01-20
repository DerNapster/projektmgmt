module DelphisHelper

  def get_avg_of_workpackage(workpackageId)
    delphis = Delphi.where(workpackage_id: workpackageId).map { |d| d.value }
    count = delphis.size
    sum = delphis.inject(:+)
    avg = (sum/count)
  end
end
