class Subject < ApplicationRecord
  has_many :questions
  paginates_per 10

  before_destroy :get_questions_count
  after_destroy  :set_total_questions_statistic

  private
    def get_questions_count
      @questions_count = self.questions_count
    end
    
    def set_total_questions_statistic
      AdminStatistic.decreases_by_event(AdminStatistic::EVENTS[:total_questions], @questions_count)
    end
end
