unit UAdditionlFunction;

interface

uses Classes,SysUtils,windows,StrUtils;

const
  Yes=['Y','y','Н','н'];
  No=['N','n','Т','т'];
  YesOrNo=Yes+No;

type
  Tset=set of char;

function GetValueFromFile(var f:TextFile; var value:string):boolean;

function InputString(txt:string):string;

function InputNumber(txt:string; min,max:integer):integer;

function PromptForFileName(txt:string; var Filename:string; MustExist:boolean):boolean;

function CheckFileName(var s:string) : boolean;

procedure ShowMessage(txt:string);

function InputQuery(txt:string; ES:TSet):char;

implementation

function InputQuery(txt:string; ES:TSet):char;
begin
  writeln(txt);
  repeat
    readln(result)
  until result in ES;
end;

procedure ShowMessage(txt:string);
begin
  writeln(txt);
  readln;
end;

function CheckFileName(var s:string) : boolean;
const
  DS = ['/','\', '|', '?', '*', '"','<','>'];
var
  i : integer;
  ok:boolean;
begin
  i:=1;
  ok:=true;
  while(i<=length(s))and ok do
    begin
      if s[i] in DS then
        ok:=false;
      inc(i);
    end;
 result:=ok;
end;

function PromptForFileName(txt:string; var Filename:string; MustExist:boolean):boolean;
var
  fn:string;
begin
  result:=true;
  writeln(txt,' (пустая строка - отмена)');
  readln(fn);
  fn:=trim(fn);
  if fn='' then
    result:=false
  else
    if not CheckFileName(fn) then
      begin
        showMessage('В названии присутствуют недопустимые символы');
        Result:=false
      end
    else
      if MustExist then
      //если файл существует
        if FileExists(fn) then
          FileName:=fn
        else
          begin
            showMessage('Файл не найден');
            Result:=false;
          end
      else
        if FileExists(fn) then
          if InputQuery('Файл существует, заменить?(Y/N)', YesOrNo) in Yes then
            FileName:=fn
          else
            result:=false
        else
          FileName:=fn;
end;

function InputString(txt:string):string;
begin
  writeln(txt);
  readln(result);
end;

function GetValueFromFile(var f:TextFile; var value:string):boolean;
var
  p:integer;
begin
  if eof(f) then
    result:=false
  else
    begin
      readln(f,value);
      p:=pos(':',value);
      if p=0 then
        result:=false
      else
        begin
          Delete(value,1,p);
          value:=trim(value);
          Result:=value<>''
        end;
    end;
end;


function InputNumber(txt:string; min,max:integer):integer;
begin
  writeln(txt);
  repeat
    readln(result);
  until (result>=min) and (result<=max);
end;

end.
