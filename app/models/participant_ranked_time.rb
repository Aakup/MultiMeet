class ParticipantRankedTime < ActiveRecord::Base
  belongs_to :participant
  belongs_to :project_time
end
