class Project < ApplicationRecord
  has_many :tasks
  belongs_to :user


  def status
    if tasks.none?
      'not-started'
    elsif tasks.all? {|task| task.complete?}
      'complete'
    elsif tasks.any? {|task| task.in_progress?}
      'in-progress'
    else
      'not-started'
    end
  end

  def percent_complete
    count = tasks.count
    return 0 if count <= 0
    complete_tasks = tasks.select {|task| task.complete?}.count.to_f
    ((complete_tasks / count) * 100).round
  end

  def tasks_completed
    count = tasks.count
    complete_tasks = tasks.select {|task| task.complete?}.count

    "(" + count.to_s + "/" + complete_tasks.to_s + " tasks)"
  end

  def status_color
    percent = self.percent_complete

    if percent < 10
      'badge-red'
    elsif percent < 30
      'badge-orange'
    elsif percent < 60
      'badge-yellow'
    elsif percent < 90
      'badge-light-green'
    else
      'badge-green'
    end
  end


end
