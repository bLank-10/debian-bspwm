
#!/usr/bin/env bash

killall -q polybar

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
#polybar main 2>&1 | tee -a /tmp/polybar1.log & disown
polybar bar1 2>&1 | tee -a /tmp/polybar1.log & disown
echo "Bars launched..."
