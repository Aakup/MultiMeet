class ProjectTime < ActiveRecord::Base
  belongs_to :project
  has_many :participant_ranked_time
end
