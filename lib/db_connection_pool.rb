# 在非rails下，会出现错误：
# could not obtain a database connection within 5 seconds (waited 5.000176738 seconds). The max pool size is currently 16; consider increasing it. (ActiveRecord::ConnectionTimeoutError)
#
# http://stackoverflow.com/questions/11248808/connection-pool-issue-with-activerecord-objects-in-rufus-scheduler
#
# 沒有效果
def db
  ActiveRecord::Base.connection_pool.with_connection do
    logger.info("hello db")
    yield
  end
end

# def db(&block)
#   begin
#     ActiveRecord::Base.connection_pool.clear_stale_cached_connections!
#     #ActiveRecord::Base.establish_connection    # this didn't help either way
#     yield block
#   rescue Exception => e
#     raise e
#   ensure
#     ActiveRecord::Base.connection.close if ActiveRecord::Base.connection
#     ActiveRecord::Base.clear_active_connections!
#   end
# end