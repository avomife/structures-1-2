program LongNumberOperations;
{������� ������, ����������� ������������� �������� ������ �����
� ���� ������ ��������, � ����� �������� ��������, ���������, ���������,
������� ������ � ���������� ������� �� ������� ������. �������� ���������,
�������������� ������ ����������� ������}

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Windows,
  LongIntStrings in 'LongIntStrings.pas';

type
  TLong = string;
var
  num1, num2, result: TLong;
  i: longint;
  ok: Boolean;
  code, c: integer;

begin
   SetConsoleCP(1251);
   SetConsoleOutputCP(1251);

   repeat
    Writeln('������� num1');
    Readln(num1);
    code:=0;
    i:=1;
    while (code=0) and (i<=Length(num1)) do
      begin
        Val(num1[i], c, code);
        i:=i+1;
      end;
    until code=0;

    repeat
    Writeln('������� num2');
    Readln(num2);
    code:=0;
    i:=1;
    while (code=0) and (i<=Length(num2)) do
      begin
        Val(num2[i], c, code);
        i:=i+1;
      end;
    until code=0;

   result:= Sign_Sub(num1, num2);
   Writeln('result ', result);

     readln;

  { TODO -oUser -cConsole Main : Insert code here }
end.
