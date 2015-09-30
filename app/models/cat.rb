class Cat < ActiveRecord::Base
  has_many :cat_rental_requests, dependent: :destroy
  belongs_to :owner, class_name: "User", foreign_key: "user_id"

  COLORS = ["Cream", "Black", "White", "Gray", "Silver", "Brown", "Gold", "Ginger", "Golden Tabby", "Gray Tabby", "Silver Tabby", "Brown Tabby", "Light Brown Tabby", "Ginger Tabby", "Pale Ginger Tabby", "Calico"].sort
  validates :color, inclusion: { in: COLORS }
  SEXES = ["M", "F"]
  validates :sex, inclusion: { in: SEXES }
  validates :birth_date, :description, :name, :owner, presence: true


  def age
    now = Date.today
    dob = self.birth_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

end
