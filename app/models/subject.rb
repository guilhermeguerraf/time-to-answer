class Subject < ApplicationRecord
  has_many :questions
  paginates_per 10

  validates :description, presence: true, length: { minimum: 2 }

  after_destroy  :decreases_total_number_of_questions

  scope :more_popular, -> { order(questions_count: :desc).limit(6) }

  scope :find_all_questions_paged_by_subject_id, -> (id, page) {
    find(id).questions.includes(:answers).page(page).per(10)
  }

  private
    def decreases_total_number_of_questions
      AdminStatistic.decreases_total_number_by_event(AdminStatistic::EVENTS[:total_questions], self.questions_count)
    end
end
