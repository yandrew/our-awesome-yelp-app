require_relative '../../config/application'


module Controller
  def self.argv_to_s(argv)
    argv.join(' ').strip
  end
  def self.options(arg, *task_data)
    case arg
    when "add"
      Task.create(name: (self.argv_to_s(task_data))) unless self.argv_to_s(task_data) == ""
    when "delete"
      index_to_delete = task_data[0][0].to_i - 1
      Task.all[index_to_delete].delete
    when "list"
      Task.all.each_with_index do |task, index|
        puts "#{ index + 1 }: #{task.name}"
      end
    when "complete"
     p index_to_complete = task_data[0][0].to_i - 1
     Task.all[index_to_complete].update_attribute(:completed, true)
        #puts so you can see complete next to list. #{index + 1}: #{task.name} - complete
      end
    end

  end

