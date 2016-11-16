require 'bunny'
conn=Bunny.new
conn.start
ch=conn.create_channel

q=ch.queue('task_queue'， ：durable => true)
# ch.default_exchange.publish("Hello,World...!", :routing_key=>q.name)
# puts "[x] Sent 'Hello World'"
msg  = ARGV.empty? ? "Hello World!" : ARGV.join(" ")

q.publish(msg, :persistent => true)
puts " [x] Sent #{msg}"
conn.close
