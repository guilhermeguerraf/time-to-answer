class Question < ApplicationRecord
  belongs_to :subject, counter_cache: true, inverse_of: :questions
  has_many :answers
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true
  paginates_per 10

  scope :search_by_term, -> (term) {
    includes(:answers, :subject).where(
      'lower(description) LIKE ?', "%#{term.downcase}%"
    )
  }

  scope :search_by_subject, -> (subject_id) {
    includes(:answers, :subject).where(subject_id: subject_id)
  }

  scope :latest, -> { includes(:answers, :subject).order(created_at: :desc).first(5) }
end
