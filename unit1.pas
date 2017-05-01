unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    status: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

uses
  DynLibs;

{ TForm1 }

type
  TProc = procedure(); cdecl;
  TIntFunc = function(): int32; cdecl;
var
  h: TLibHandle;
  PrintBye: TProc;
  GetIntFromDLL: TIntFunc;
const
  GO_LIB = 'goDLL.dll';
  PROC1 = 'PrintBye';
  PROC2 = 'GetIntFromDLL';

procedure StatusLn(s: string); overload;
begin
  Form1.Status.Lines.Add(s);
end;

procedure StatusLn(s: string; i: integer); overload;
begin
  StatusLn(s + inttostr(i));
end;


function LoadLib: boolean;
var p: pointer;
begin
  h := LoadLibrary(GO_LIB);
  if h = NilHandle then result := false else result := true;
  StatusLn('Handle: ', h);
  p := GetProcAddress(h, PROC1);
  if p = nil then begin
    StatusLn('Error getting procedure address: '+ PROC1);
    result := false;
  end;
  PrintBye := TProc(p);

  p := nil;
  p := GetProcAddress(h, PROC2);
  if p = nil then begin
    StatusLn('Error getting procedure address: '+ PROC2);
    result := false;
  end;
  GetIntFromDLL := TIntFunc(p);
end;

procedure UnloadLib;
begin
  UnloadLibrary(h);
end;

procedure TryGoDLL;
var
  c: char;
  i: integer;
begin
  StatusLn('Loading library: '+ GO_LIB);
  if LoadLib then begin
    i := GetIntFromDLL();
    StatusLn('Integer from DLL: ', i);
  end else begin
    StatusLn('Error loading library or proc address not found in: '+ GO_LIB);
  end;

  // PROBLEM: can't unload library because it crashes the program?
  // only can unload it at the end of the program.
  // Go runtime conflicting with fpc?

  // StatusLn('Unloading library: '+ GO_LIB);
  // UnloadLib;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  TryGoDLL;
end;

end.

