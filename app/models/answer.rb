class Answer < ApplicationRecord
  belongs_to :question

  after_create :set_into_redis
  before_destroy :delete_from_redis
  after_update :update_redis

  private
    def set_into_redis
      Rails.cache.write(self.id, "#{self.question_id}@@#{self.correct}")
    end

    def delete_from_redis
      Rails.cache.delete_matched("#{self.id}")
    end

    def update_redis
      Rails.cache.fetch(self.id, force: true) { "#{self.question_id}@@#{self.correct}" }
    end
end
