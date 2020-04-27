{Задан некоторый родительский класс. От него должно быть определено несколько
потомков. Определить класс Список элементов, который может одновременно содержать
разных потомков базового класса. Реализовать операции добавления элемента в список,
удаление элемента из списка, поиск элемента в списке и другие. Решить задачи.

   "Публикации". Реализовать следующую иерархию классов: любая публикация имеет
    название, автора(авторов) и год издания. Для книги всегда задано количество
    страниц. Для статьи указываются номера страниц(диапазон) и название сборника,
    в котором опубликована данная статья. Задан список публикаций. Сделать выборку
    публикаций заданного автора, вышедших в течение определенного периода времени.}
program alg_3task;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  windows,
  UList in 'D:\pomosch\помощь\Algoritmy_i_struktury\Задача 3 Классы\UList.pas',
  uAuthorList in 'D:\pomosch\помощь\Algoritmy_i_struktury\Задача 3 Классы\uAuthorList.pas',
  UPublication in 'D:\pomosch\помощь\Algoritmy_i_struktury\Задача 3 Классы\UPublication.pas',
  UAdditionlFunction in 'D:\pomosch\помощь\Algoritmy_i_struktury\Задача 3 Классы\UAdditionlFunction.pas',
  Ubook in 'D:\pomosch\помощь\Algoritmy_i_struktury\Задача 3 Классы\Ubook.pas',
  UArticle in 'D:\pomosch\помощь\Algoritmy_i_struktury\Задача 3 Классы\UArticle.pas';

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
  writeln('Введите A/a что бы добавить статью. B/b - книгу');
  readln(ch);
  if ch in ['A','a','Ф','ф'] then
    publ:=Tarticle.CreateEmpty
  else
    if ch in ['B','b','И','и'] then
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
  if PromptForFileName('Введите имя текстового файла',name,false) then
    begin
      l.SaveToFile(name);
      ShowMessage('Файл создан');
    end;
end;

procedure SaveToText(var l:TListPbl);
begin
  if L.FileName='' then
    SaveAs(l)
  else
    begin
      L.SaveToFile(L.FileName);
      ShowMessage('Файл сохранен');
    end;
end;

function CanCloselist(var l:TListPbl): boolean;
var
  ch:char;
begin
  result:=true;
  if (l<>nil) and (l.Modified) then
  begin
    writeln('Файл изменен'#13#10'A/a - сохранить изменения и выйти'#13#10'B/b - отмена'#13#10'Другое - выход');
    readln(ch);
    if ch in ['A','a','Ф','ф'] then
      begin
       SaveToText(l);
       result:=not l.Modified
      end
    else
      if ch in ['B','b','И','и'] then
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
      if InputQuery('Будете добавлять элементы (Y/N)', YesOrNo) in Yes then
        repeat
          AddInfo(l);
        until not (InputQuery('Будете еще добавлять элементы (Y/N)', YesOrNo) in Yes);
      ShowMessage('Список создан');
    end;
end;

procedure DeleteInfo(var l:TListPbl);
var
  ind:integer;
begin
  ind:=InputNumber('Введите номер удаляемой публикации', 1, l.Count);
  l.Delete(ind-1);
end;

procedure ChangeInfo(var l:TListPbl);
var
  ind:integer;
  p:Tpublication;
begin
  ind:=InputNumber('Введите номер изменяемой публикации', 1, l.Count);
  if InputPubl(p) then
    l.Publication[ind-1]:=p;
end;

procedure LoadFromFile(var l:TListPbl);
var
  name : string;
begin
  if PromptForFileName('Введите имя текстового файла',name,true) and
     CanCloseList(l)
  then
    begin
      L:=TListPbl.Create;
      if not l.LoadFromFile(Name)  then
        begin
          FreeAndNil(L);
          writeln('Не удалось загрузить данные из файла');
          writeln;
        end;
    end;
end;


//главная задача
procedure MainTask(var l:TListPbl);
var
  res:TListPbl;
  author, sdat, endat:string;
begin
  res:=TListPbl.Create;
  writeln('Введите имя автора');
  readln(author);
  writeln('Введите дату начиная с которой нужно найти публикации');
  readln(sdat);
  writeln('Введите по которую искать');
  readln(endat);
  res:=l.Exist(author,strTodate(sdat), strTodate(endat));
  PrintList(res);
  if InputQuery('Сохранить результат в файл? (Y/N)', YesOrNo) in Yes then
    SaveToText(res);
  res.free;
end;

//выход из программы
procedure exit(l:TListPbl; var item:integer);
begin
  if not cancloseList(l) then
    item:=-1;
end;

//меню
var
  l:TListPbl;
  item:integer;

function GetMenuItem:integer;
var
  MaxItem:integer;
begin
  writeln('1-создать список');
  writeln('2-загрузить из файла');
  MaxItem:=2;
  if l<>nil then
    begin
      writeln('3-печать списка');
      writeln('4-сохранить');
      writeln('5-сохранить как');
      writeln('6-добавление данных');
      writeln('7-удаление записи');
      writeln('8-редактирование записи');
      writeln('9-решение основной задачи');
      MaxItem:=9;
    end;
  writeln('0-выход');
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

