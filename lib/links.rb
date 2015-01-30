module Links
  def self.match
    Task.where({:list_id => null}).each do |task|
      task.update_attribute(list_id: 1)
  end
end
