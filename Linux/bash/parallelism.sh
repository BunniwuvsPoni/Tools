#                             Online Bash Shell.
#                 Code, Compile, Run and Debug Bash script online.
# Write your code in this editor and press "Run" button to execute it.
# https://www.onlinegdb.com/online_bash_shell

task(){
   sleep 0.5; echo "$1";
}

for thing in a b c d e f g; do
   task "$thing" &
   task "$thing" #&
done

wait
