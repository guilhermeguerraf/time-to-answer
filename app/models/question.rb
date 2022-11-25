class Question < ApplicationRecord
  belongs_to :subject, counter_cache: true, inverse_of: :questions
  has_many :answers
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  # Callbacks
  after_create  :set_statistic
  after_destroy :decreases_one_to_statistic

  # Kaminari - Set default value for pagination
  paginates_per 10

  scope :search_by_term, -> (term) {
    includes(:answers, :subject).where(
      'lower(description) LIKE ?', "%#{term.downcase}%"
    )
  }

  scope :search_by_subject, -> (subject_id) {
    includes(:answers, :subject).where(subject_id: subject_id)
  }

  scope :latest, -> {
    includes(:answers, :subject).order(created_at: :desc).first(5)
  }

  private
    def set_statistic
      AdminStatistic.adds_one_to_event(AdminStatistic::EVENTS[:total_questions])
    end
    
    def decreases_one_to_statistic
      AdminStatistic.decreases_one_to_event(AdminStatistic::EVENTS[:total_questions])
    end
end
