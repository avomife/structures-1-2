{����� ��������� ������������ �����. �� ���� ������ ���� ���������� ���������
��������. ���������� ����� ������ ���������, ������� ����� ������������ ���������
������ �������� �������� ������. ����������� �������� ���������� �������� � ������,
�������� �������� �� ������, ����� �������� � ������ � ������. ������ ������.

   "����������". ����������� ��������� �������� �������: ����� ���������� �����
    ��������, ������(�������) � ��� �������. ��� ����� ������ ������ ����������
    �������. ��� ������ ����������� ������ �������(��������) � �������� ��������,
    � ������� ������������ ������ ������. ����� ������ ����������. ������� �������
    ���������� ��������� ������, �������� � ������� ������������� ������� �������.}
program alg_3task;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  windows,
  UList in 'D:\pomosch\������\Algoritmy_i_struktury\������ 3 ������\UList.pas',
  uAuthorList in 'D:\pomosch\������\Algoritmy_i_struktury\������ 3 ������\uAuthorList.pas',
  UPublication in 'D:\pomosch\������\Algoritmy_i_struktury\������ 3 ������\UPublication.pas',
  UAdditionlFunction in 'D:\pomosch\������\Algoritmy_i_struktury\������ 3 ������\UAdditionlFunction.pas',
  Ubook in 'D:\pomosch\������\Algoritmy_i_struktury\������ 3 ������\Ubook.pas',
  UArticle in 'D:\pomosch\������\Algoritmy_i_struktury\������ 3 ������\UArticle.pas';

procedure PrintList (var l:TListPbl);
begin
  L.Print
end;

function InputPubl (var publ:Tpublication):boolean;
var
  ch:char;
begin
  publ:=nil;
  result:=true;
  writeln('������� A/a ��� �� �������� ������. B/b - �����');
  readln(ch);
  if ch in ['A','a','�','�'] then
    publ:=Tarticle.CreateEmpty
  else
    if ch in ['B','b','�','�'] then
      publ:=Tbook.CreateEmpty
    else
      Result:=false;
  if Result then
    publ.Input;
end;

procedure AddInfo(var l:TListPbl);
var
  p:Tpublication;
begin
  if inputPubl(p) then
      l.Add(p);
end;

procedure SaveAs(var l:TListPbl);
var
  name: string;
begin
  if PromptForFileName('������� ��� ���������� �����',name,false) then
    begin
      l.SaveToFile(name);
      ShowMessage('���� ������');
    end;
end;

procedure SaveToText(var l:TListPbl);
begin
  if L.FileName='' then
    SaveAs(l)
  else
    begin
      L.SaveToFile(L.FileName);
      ShowMessage('���� ��������');
    end;
end;

function CanCloselist(var l:TListPbl): boolean;
var
  ch:char;
begin
  result:=true;
  if (l<>nil) and (l.Modified) then
  begin
    writeln('���� �������'#13#10'A/a - ��������� ��������� � �����'#13#10'B/b - ������'#13#10'������ - �����');
    readln(ch);
    if ch in ['A','a','�','�'] then
      begin
       SaveToText(l);
       result:=not l.Modified
      end
    else
      if ch in ['B','b','�','�'] then
          result:=false
  end;
  if Result then
    FreeAndNil(L)
end;

procedure CreateList(var L:TListPbl);
begin
  if canCloselist(L) then
    begin
      L:=TListPbl.Create;
      if InputQuery('������ ��������� �������� (Y/N)', YesOrNo) in Yes then
        repeat
          AddInfo(l);
        until not (InputQuery('������ ��� ��������� �������� (Y/N)', YesOrNo) in Yes);
      ShowMessage('������ ������');
    end;
end;

procedure DeleteInfo(var l:TListPbl);
var
  ind:integer;
begin
  ind:=InputNumber('������� ����� ��������� ����������', 1, l.Count);
  l.Delete(ind-1);
end;

procedure ChangeInfo(var l:TListPbl);
var
  ind:integer;
  p:Tpublication;
begin
  ind:=InputNumber('������� ����� ���������� ����������', 1, l.Count);
  if InputPubl(p) then
    l.Publication[ind-1]:=p;
end;

procedure LoadFromFile(var l:TListPbl);
var
  name : string;
begin
  if PromptForFileName('������� ��� ���������� �����',name,true) and
     CanCloseList(l)
  then
    begin
      L:=TListPbl.Create;
      if not l.LoadFromFile(Name)  then
        begin
          FreeAndNil(L);
          writeln('�� ������� ��������� ������ �� �����');
          writeln;
        end;
    end;
end;


//������� ������
procedure MainTask(var l:TListPbl);
var
  res:TListPbl;
  author, sdat, endat:string;
begin
  res:=TListPbl.Create;
  writeln('������� ��� ������');
  readln(author);
  writeln('������� ���� ������� � ������� ����� ����� ����������');
  readln(sdat);
  writeln('������� �� ������� ������');
  readln(endat);
  res:=l.Exist(author,strTodate(sdat), strTodate(endat));
  PrintList(res);
  if InputQuery('��������� ��������� � ����? (Y/N)', YesOrNo) in Yes then
    SaveToText(res);
  res.free;
end;

//����� �� ���������
procedure exit(l:TListPbl; var item:integer);
begin
  if not cancloseList(l) then
    item:=-1;
end;

//����
var
  l:TListPbl;
  item:integer;

function GetMenuItem:integer;
var
  MaxItem:integer;
begin
  writeln('1-������� ������');
  writeln('2-��������� �� �����');
  MaxItem:=2;
  if l<>nil then
    begin
      writeln('3-������ ������');
      writeln('4-���������');
      writeln('5-��������� ���');
      writeln('6-���������� ������');
      writeln('7-�������� ������');
      writeln('8-�������������� ������');
      writeln('9-������� �������� ������');
      MaxItem:=9;
    end;
  writeln('0-�����');
  result:=InputNumber('',0,MaxItem);
end;

begin{main}
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);
  L:=nil;
  repeat
    item:=GetMenuItem;
    case item of
      1:CreateList(l);   //!!!!!!!
      2:LoadFromFile(l); //!!!!!!!!!
      3:PrintList(l);
      4:SaveToText(l);
      5:SaveAs(l);
      6:AddInfo(l);
      7:Deleteinfo(l);
      8:ChangeInfo(l);
      9:MainTask(l);
      0:Exit(l,item);
    end;
  until item=0;
  readln;
end.

