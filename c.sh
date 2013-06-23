##this script compiles .c files
nameLen=${#1}
filename=${1:0:nameLen-2}     #striping last 2 char i.e. '.c'
echo " * * * gcc: Compiling $filename * * *"

gcc -g -O2 -Wall -Wextra -Isrc -rdynamic $1 -o $filename.out

echo "   * * * Done * * * "
echo "Now Do:   ./$filename.out"
