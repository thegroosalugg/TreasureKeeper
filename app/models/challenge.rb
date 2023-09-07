class Challenge < ApplicationRecord
  # belongs_to :player
  belongs_to :treasure_chest
  has_many :expenses, dependent: :destroy
  has_many :monsters, dependent: :destroy
  # validates :name, :description, :monster, :end_date, :status, presence: true
  validates :description, :status, :budget, :end_date, presence: true
  validate :end_date_cannot_be_in_past
  validates :budget, numericality:{other_than: 0}

  CATEGORIES = ["Coffee", "Gummibärchen", "tiny pizzas", "fake mustaches", "lava lamps"]
  validates :name, inclusion: { in: CATEGORIES, message: "is not included in the list" }, presence: true


  def end_date_cannot_be_in_past
    if end_date.present? && end_date < Date.today
      errors.add(:end_date, "can't be in the past")
    end
  end
  def budget_cannot_be_zero
    if budget.present? && budget.zero?
      errors.add(:budget, "can't be zero")
    end
  end
  enum status: %i[ongoing lost won]
end
