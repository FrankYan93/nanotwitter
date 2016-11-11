class Followerfollowing < ActiveRecord::Base
  include ActiveRecord::Calculations

    belongs_to :user
    belongs_to :followed_user, class_name: 'User'
end
