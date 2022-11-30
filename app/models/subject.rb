class Subject < ApplicationRecord
  has_many :questions
  paginates_per 10

  after_destroy  :set_total_questions_statistic

  scope :more_popular, -> { order(questions_count: :desc).limit(6) }

  private
    def set_total_questions_statistic
      AdminStatistic.set_statistic_by_event(AdminStatistic::EVENTS[:total_questions], self.questions_count)
    end
end
