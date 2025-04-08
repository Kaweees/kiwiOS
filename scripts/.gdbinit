set arch i386:x86-64:intel
symbol-file target/x86_64/release/kiwios-x86_64.bin

# # Enable pretty printing of C++ STL containers
# python
# import sys
# sys.path.insert(0, '/usr/share/gcc/python')
# from libstdcxx.v6.printers import register_libstdcxx_printers
# register_libstdcxx_printers(None)
# end

# # Set the source code directory
# directory src
# directory include

# # Set the assembly language format to Intel
# set disassembly-flavor intel

# # Enable pretty printing
# set print pretty on

# # Set the number of elements to print in arrays
# set print elements 100

# # Set the maximum string length to print
# set print characters 1000

# # Enable automatic symbol loading
# set auto-load safe-path /

# # Set the prompt
# set prompt (kiwiOS)

# # Define some useful aliases
# define pstruct
#     print *($arg0)
# end

# define pvector
#     print *($arg0)._M_impl._M_start@$arg1
# end

# # Set breakpoint on main
# break main

# # Enable logging
# set logging on
# set logging file gdb.log

# # Show the current frame information
# frame

# # Print the current source line
# list
