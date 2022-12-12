class Answer < ApplicationRecord
  belongs_to :question

  after_create :set_into_redis
  before_destroy :delete_from_redis

  private
    def set_into_redis
      Rails.cache.write(self.id, "#{self.question_id}@@#{self.correct}")
    end

    def delete_from_redis
      Rails.cache.delete("#{self.id}")
    end
end
