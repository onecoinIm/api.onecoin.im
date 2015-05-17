#!/bin/sh

# set ruby GC parameters
RUBY_GC_HEAP_INIT_SLOTS=600000
RUBY_GC_HEAP_FREE_SLOTS=200000
RUBY_GC_MALLOC_LIMIT=60000000
export RUBY_GC_HEAP_INIT_SLOTS RUBY_GC_HEAP_FREE_SLOTS RUBY_GC_MALLOC_LIMIT

pid="log/rainbows.pid"

case "$1" in
  start)
    bundle exec zbatery -c config/rainbows.rb -E production -D
    ;;
  stop)
    kill `cat $pid`
    ;;
  force-stop)
    kill -9 `cat $pid`
    ;;
  restart)
    $0 stop
    sleep 2
    $0 start
    ;;
  reload)
    kill -USR2 `cat $pid`
    ;;
  *)
    echo $"Usage: $0 {start|stop|force-stop|restart|reload}"
    ;;
esac