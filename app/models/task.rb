class Task < ApplicationRecord
  PRIORITIES = {
    "Low" => 1,
    "Medium" => 2,
    "High" => 3
  }.freeze

  belongs_to :user

  validates :description, presence: true, length: { maximum: 180 }
  validates :due_date, presence: true
  validates :priority, inclusion: { in: PRIORITIES.values }

  scope :active, -> { where(completed: false) }
  scope :due_today, -> { active.where(due_date: Date.current) }
  scope :ordered_by, lambda { |sort|
    case sort
    when "description"
      order(Arel.sql("LOWER(description) ASC"), due_date: :asc, priority: :desc)
    when "priority"
      order(priority: :desc, due_date: :asc, description: :asc)
    else
      order(due_date: :asc, priority: :desc, description: :asc)
    end
  }

  before_save :stamp_completion_change

  def priority_name
    PRIORITIES.key(priority)
  end

  private

  def stamp_completion_change
    return unless will_save_change_to_completed?

    self.completed_at = completed? ? Time.current : nil
  end
end
