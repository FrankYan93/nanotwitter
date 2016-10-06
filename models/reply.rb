class Reply < ActiveRecord::Base
  belongs_to :user
  belongs_to :tweet
  belongs_to :reply
end
