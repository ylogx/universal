##this script compiles .c & .cpp files
#clear
echo    #newline
nameLen=${#1}
compiled=true
#echo " * * * Compiling $filename * * *"
if test "${1:nameLen-2}" == '.c' ;  then
#if [["${1:nameLen-2}"=="*.c"]] ; then
    filename=${1:0:nameLen-2}     #striping last 2 char i.e. '.c'
    echo " = = = = = = GCC: Compiling $filename .c file = = = = = ="
    echo "gcc -g -O2 -Wall -Wextra -Isrc -rdynamic -O2 -fomit-frame-pointer -o $filename.out $1"
    echo    #newline
    gcc -g -O2 -Wall -Wextra -Isrc -rdynamic -O2 -fomit-frame-pointer -o $filename.out $1
    #gcc -Werror -pedantic-errors -std=c99 -O2 -fomit-frame-pointer -o prog prog.c #C99 strict (gcc-4.3.2)
    #echo ".c file found"
elif test "${1:nameLen-4}" == '.cpp' ; then #first arg: crop till nameLen-4
#elif [["${1:nameLen-4}"=="*.cpp"]] ; then
    filename=${1:0:nameLen-4}     #striping last 2 char i.e. '.c' i.e keep from 0 till nameLen -4
    echo " - - - - - - G++: Compiling $filename .cpp file - - - - - -"
    echo "g++ -g -O2 -Wall -Wextra -Isrc -rdynamic -O2 -fomit-frame-pointer -o $filename.out $1" 
    echo    #newline
    g++ -g -O2 -Wall -Wextra -Isrc -rdynamic -O2 -fomit-frame-pointer -o $filename.out $1
    #echo ".cpp file found"
elif test "$1" == '' ; then
    compiled=false
else 
    echo "NOTICE: Unknown File format \"$1\""
    echo    #newline
    compiled=false
fi
if test $compiled == true ; then
    if test -f $filename.test && test "$2" == "t" ; then
        echo " * * * Valgrind Test: $filename.test found * * *"
        time cat $filename.test | valgrind ./$filename.out
    elif test -f $filename.test && test "$2" == "t1" ; then
        echo " * * * Valgrind Test: $filename.test found * * *"
        time cat $filename.test | valgrind --leak-check=full ./$filename.out
    elif test -f $filename.test && test "$2" == "t2" ; then
        echo " * * * Valgrind Test: $filename.test found * * *"
        time cat $filename.test | valgrind --leak-check=full -v ./$filename.out
    elif test -f $filename.test && test "$2" == "t3" ; then
        echo " * * * Valgrind Test: $filename.test found * * *"
        time cat $filename.test | valgrind --leak-check=full --show-reachable=yes --track-origins=yes -v ./$filename.out
    else    #No test
        echo    #newline
        echo "= = = Now Do = = = "
        echo "time cat $filename.test | valgrind ./$filename.out                                                                 #[ t  ]"
        echo "time cat $filename.test | valgrind --leak-check=full ./$filename.out                                               #[ t1 ]"
        echo "time cat $filename.test | valgrind --leak-check=full -v ./$filename.out                                            #[ t2 ]"
        echo "time cat $filename.test | valgrind --leak-check=full --show-reachable=yes --track-origins=yes -v ./$filename.out   #[ t3 ]"
    fi
    #gcc -g -O2 -Wall -Wextra -Isrc -rdynamic $1 -o $filename.out
    echo    #newline
    #echo "   * * * Done * * * "
else    #Show Usage & Help	
    echo "######################################################"
    #echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # #"
    echo "# - - - $0 Help - - -" 
    echo "#"    #newline
    echo "# USAGE:  chaudhary.sh <filename> <test option>" 
    echo "#         test option: t, t1, t2, t3 "
    echo "# Currently able to compile '.c' and '.cpp' files only"
    #echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # #"
    echo "######################################################"
    echo    #newline
fi


