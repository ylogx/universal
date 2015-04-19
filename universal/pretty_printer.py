from universal.ansi import Fore, Back, Style

BLACK = '\033[30m'
RED = '\033[31m'
GREEN = '\033[32m'
YELLOW = '\033[33m'
BLUE = '\033[34m'
MAGENTA = '\033[35m'
CYAN = '\033[36m'
WHITE = '\033[37m'
RESET = '\033[39m'

def helpFun():
    print("")  # newline
    # print( "# # # # # # # # # # # # # # # # # # # # # # # # # # # #"
    print("    #######################################################")
    print("    #        + + + ", Fore.YELLOW, "Universal Compiler Help", \
          Fore.RESET, " + + +      (c) #", sep='')
    print("    #                                                     #")
    print("    # Aliases: '", GREEN, "universal", RESET, "' and '", GREEN, "u", \
          RESET, "' and '", GREEN, "c", RESET, "'                #", sep='')
    print("    # That means you may also use:                        #")
    print("    #       `u --help`   or   `universal --help`          #")
    print("    #                                                     #")
    print("    # USAGE:  universal <filename>                        #")
    print("    #         universal <filename> <test option>          #")
    print("    # e.g      'universal hello.cpp'                      #")
    print("    #          'universal HelloWorld.java'                #")
    print("    # Automated Testing options: t, t1, t2, t3            #")
    print("    # For this full help:  'universal -h'                 #")
    print("    #                                                     #")
    # print( "    # Supports with '.c' '.cpp' '.py' '.java' '.pl' '.sh' #")
    print("    # File Extensions: ", BLUE, "*.c .cpp .py .java .pl .sh", \
          RESET, "         #", sep='')
    print("    #                                                     #")
    print("    # ", RED, "Update Version", RESET, ": `", MAGENTA, "universal -u", \
          RESET, "` i.e. `", MAGENTA, "u -u", RESET, "`          #", sep='')
    print("    #              Or see README.md to get download link  #")
    print("    #                                                     #")
    print("    #######################################################")
    print("    # Program: Universal Competitive Programming Suite    #")
    print("    #######################################################")
    # print( "# # # # # # # # # # # # # # # # # # # # # # # # # # # #"
    print("")  # newline
