# goDLL
Project to show people how to create MS Windows golang DLL, then load it into lazarus program, or a plain fpc command line program or another golang exe.  This implies you can also use the DLL in plain C or C++ Visual Studio or GCC project. Should also be able to port this to bsd/linux/macOS

Current way of making a DLL:
* compile go code with regular go compiler and put that puts code into .a and .h files for you. These are just like C code that GCC can use, but stored in compiled .a and .h files
* then build a dll based on the dummy .c file (CGO) that just links the .a and .h files (go code) into a dll, using CGO (GCC automatically from go) to build the dll

Well known issues with Go DLL's:

* AFAIK you can only add one go dll to a program, and only once, as multiple go dlls in the same program will confluct each other's go runtime at this time
* Unloading a dll will crash program... But one go dll loaded, and kept loaded, works..
* This may improve in the future as golang repairs these issues if they can.  
* A go runtime (which is included in all golang programs/code) is similar to a borland BPL or a .net runtime: multiple runtimes can be tricky/conflicting. It can even overwrite data if multiple runtimes exist, possibly even more tricky than a BPL. This again could be fixed in the future by golang authors if they work on dll's and unloading more in the future.
* regarding unix dll/so: I have not tested or read about it enough to know the details. This project is just a Microsoft Windows DLL project example, could also work on unix
* Go DLL, not "God II"

Other ideas:
* Try statically linking go code into fpc, instead of dll put the code right into the exe directly using .a files, and making an fpc .h equivalent (should be easy)
* show its use also in a plain c program since not all people interested in go dll's are using fpc/lazarus
* try come up with solutions to fix "multiple go runtime" problems (multiple go DLLs loaded) and "unloading" (of dll) problems. See golang open issues 11100 and 11058
  * https://github.com/golang/go/issues/11100
  * https://github.com/golang/go/issues/11058
