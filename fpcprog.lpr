program fpcprog;  {$mode objfpc}{$H+}

uses
  SysUtils, DynLibs;

var h: TLibHandle;

type
  TProc = procedure(); cdecl;
var
  PrintBye: TProc;
const
  GO_LIB = 'goDLL.dll';
  PROC1 = 'PrintBye';


function LoadLib: boolean;
var p: pointer;
begin
  h := LoadLibrary(GO_LIB);
  writeln('handle: ', h);
  p := GetProcAddress(h, PROC1);
  if p = nil then begin
    writeln('error getting procedure address: ', PROC1);
    result := false;
  end;
  PrintBye := TProc(p);
end;

procedure UnloadLib;
begin
  UnloadLibrary(h);
end;

var
  c: char;
begin
  writeln('Loading library: ', GO_LIB);
  if LoadLib then begin
    PrintBye();
  end;

  writeln('Press enter to exit');
  readln;

  writeln('Unloading library: ', GO_LIB);
  UnloadLib;

  // problem: if you put code here after unloadlib, the program will exit 
  // before code is run to completion. Possible causes: go runtime (garbage
  // collection, goroutines, etc.) is *not* meant for unloading dynamically
  // in a dll any time you want. GoLang authors may fix this in the future
end.

