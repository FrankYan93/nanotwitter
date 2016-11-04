require 'thread'
@userLock=Mutex.new
@tweetLock=Mutex.new
@followLock=Mutex.new
#likeLock=Mutex.new
# mentionLock=Mutex.new
# replyLock=Mutex.new
# hashtagLock=Mutex.new
# notificationLock=Mutex.new
