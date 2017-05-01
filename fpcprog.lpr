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

  // problem: if you put a readln here at the end of the program after
  // unloadlib, the program will still exit before any readln is processed
  // (enter key is pressed) possible causes?? fpc stdout conflicting with go
  // stdout?? go runtime?
end.

