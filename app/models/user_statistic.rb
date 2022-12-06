class UserStatistic < ApplicationRecord
  belongs_to :user

  def total_questions
    self.right_questions + self.wrong_questions
  end

  def self.set_statistic_by_answer(user, correct_answer)
    user_statistic = UserStatistic.find_or_create_by(user: user)
    
    if correct_answer
      user_statistic.right_questions += 1
    else
      user_statistic.wrong_questions += 1
    end

    user_statistic.save!
  end
end
