class Question < ApplicationRecord
  belongs_to :subject, counter_cache: true, inverse_of: :questions
  has_many :answers
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  # Callbacks
  after_create  :increases_total_number_of_questions
  after_destroy :decreases_total_number_of_questions

  # Kaminari - Set default value for pagination
  paginates_per 10

  scope :find_by_term, -> (term) {
    includes(:answers, :subject).where(
      'lower(description) LIKE ?', "%#{term.downcase}%"
    )
  }

  scope :find_by_subject, -> (subject_id) {
    includes(:answers, :subject).where(subject_id: subject_id)
  }

  scope :latest, -> {
    includes(:answers, :subject).order(created_at: :desc).first(5)
  }

  private
    def increases_total_number_of_questions
      AdminStatistic.increases_total_number_by_event(AdminStatistic::EVENTS[:total_questions])
    end

    def decreases_total_number_of_questions
      AdminStatistic.decreases_total_number_by_event(AdminStatistic::EVENTS[:total_questions])
    end
end
