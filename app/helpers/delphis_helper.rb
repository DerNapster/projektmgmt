module DelphisHelper

  def get_avg_of_workpackage(workpackageId)
    delphis = Delphi.where(workpackage_id: workpackageId).map { |d| d.value }
    count = delphis.size
    sum = delphis.inject(:+)
    avg = (sum/count)
  end

  def update_duration_of_workpackage(workpackageid)
    avg = get_avg_of_workpackage(workpackageid)
    workpackage = Workpackage.find_by(id: workpackageid)
    workpackage.update(duration: avg)
  end
end
