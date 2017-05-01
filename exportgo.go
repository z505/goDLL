/*
 GoLang DLL example. Goals: load golang dll into fpc/lazarus, and load golang
 dll into another go executable.

 The syntax
   //export SomeFunc
 needs to be used above the function you want to export

 To compile this program run:
   go build -buildmode=c-archive exportgo.go
 then compile goDLL.c that exports the functions for GCC to link, and run:
   gcc -shared -pthread -o goDLL.dll goDLL.c exportgo.a -lWinMM -lntdll -lWS2_32

*/

package main

import "C"
import "fmt"

//export GetIntFromDLL
func GetIntFromDLL() int32 {
	return 42
}

//export PrintHello
func PrintHello(name string) {
	fmt.Printf("From DLL: Hello, %s!\n", name)
}

//export PrintBye
func PrintBye() {
	fmt.Println("From DLL: Bye!")
}

func main() {
	// Need a main function to make CGO compile package as C shared library
}