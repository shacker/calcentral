class GoogleDeleteTaskProxy < GoogleTasksProxy

  def delete_task(task_list_id, task_id)
    response = request(:api => "tasks", :resource => "tasks", :method => "delete",
                       :params => {tasklist: task_list_id, task: task_id}, :vcr_id => "_tasks")[0]
    #According to the API, empty response body == successful
    response.data.blank?
  end

end
