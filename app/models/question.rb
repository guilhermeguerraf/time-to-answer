class Question < ApplicationRecord
  belongs_to :subject, inverse_of: :questions
  has_many :answers
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  scope :search_by_term, -> (term) {
    includes(:answers).where(
      'lower(description) LIKE ?', "%#{term.downcase}%"
    )
  }

  scope :search_by_subject, -> (subject_id) {
    includes(:answers, :subjects).where(subject_id: subject_id)
  }

  scope :latest, -> { includes(:answers).last(5).reverse }
end
