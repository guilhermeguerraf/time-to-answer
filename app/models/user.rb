class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :user_profile
  accepts_nested_attributes_for :user_profile, reject_if: :all_blank

  has_many :favorites
  has_many :questions, through: :favorites

  # Callbacks
  after_create :increases_total_number_of_users

  # Validações
  # validates :first_name, presence: true, length: { minimum:2 }, on: :update
  
  # Virtual attributes
  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  private
    def increases_total_number_of_users
      AdminStatistic.increases_total_number_by_event(AdminStatistic::EVENTS[:total_users])
    end
end
