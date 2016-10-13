class Followerfollowing < ActiveRecord::Base
    belongs_to :user
    belongs_to :followed_user, class_name: 'User'
end
