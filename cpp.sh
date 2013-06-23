##this script compiles .cpp files
nameLen=${#1}
filename=${1:0:nameLen-4}     #striping last 4 char i.e. '.cpp'
echo " * * * g++: Compiling $filename * * *"

g++ -g -O2 -Wall -Wextra -Isrc -rdynamic $1 -o $filename.out

if [-f $filename.test]; then
  cat $filename.test | ./$filename.out
fi
echo "   * * * Done * * * "
echo "Now Do:   ./$filename.out"
