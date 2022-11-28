class AdminStatistic < ApplicationRecord
  EVENTS = {
    total_users: "TOTAL_USERS",
    total_questions: "TOTAL_QUESTIONS"
  }

  # Scopes
  scope :total_users, -> {
    find_by_event(EVENTS[:total_users]).value
  }

  scope :total_questions, -> {
    find_by_event(EVENTS[:total_questions]).value
  }

  # Métodos da classe
  private
    def self.set_statistic_by_event(event, total_count = 1)
      admin_statistic = AdminStatistic.find_or_create_by(event: event)

      if $action_params == "create"
        admin_statistic.value += total_count
      else
        admin_statistic.value -= total_count
      end
      
      admin_statistic.save
    end
end
