class ProjectTime < ActiveRecord::Base
  belongs_to :project
  has_many :rankings

end
