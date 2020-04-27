{Çàäàí íåêîòîðûé ðîäèòåëüñêèé êëàññ. Îò íåãî äîëæíî áûòü îïðåäåëåíî íåñêîëüêî
ïîòîìêîâ. Îïðåäåëèòü êëàññ Ñïèñîê ýëåìåíòîâ, êîòîðûé ìîæåò îäíîâðåìåííî ñîäåðæàòü
ðàçíûõ ïîòîìêîâ áàçîâîãî êëàññà. Ðåàëèçîâàòü îïåðàöèè äîáàâëåíèÿ ýëåìåíòà â ñïèñîê,
óäàëåíèå ýëåìåíòà èç ñïèñêà, ïîèñê ýëåìåíòà â ñïèñêå è äðóãèå. Ðåøèòü çàäà÷è.

   "Ïóáëèêàöèè". Ðåàëèçîâàòü ñëåäóþùóþ èåðàðõèþ êëàññîâ: ëþáàÿ ïóáëèêàöèÿ èìååò
    íàçâàíèå, àâòîðà(àâòîðîâ) è ãîä èçäàíèÿ. Äëÿ êíèãè âñåãäà çàäàíî êîëè÷åñòâî
    ñòðàíèö. Äëÿ ñòàòüè óêàçûâàþòñÿ íîìåðà ñòðàíèö(äèàïàçîí) è íàçâàíèå ñáîðíèêà,
    â êîòîðîì îïóáëèêîâàíà äàííàÿ ñòàòüÿ. Çàäàí ñïèñîê ïóáëèêàöèé. Ñäåëàòü âûáîðêó
    ïóáëèêàöèé çàäàííîãî àâòîðà, âûøåäøèõ â òå÷åíèå îïðåäåëåííîãî ïåðèîäà âðåìåíè.}
program alg_3task;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  windows,
  UList in 'UList.pas',
  uAuthorList in 'uAuthorList.pas',
  UPublication in 'UPublication.pas',
  UAdditionlFunction in 'UAdditionlFunction.pas',
  Ubook in 'Ubook.pas',
  UArticle in 'UArticle.pas';

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
  writeln('Ââåäèòå A/a ÷òî áû äîáàâèòü ñòàòüþ. B/b - êíèãó');
  readln(ch);
  if ch in ['A','a','Ô','ô'] then
    publ:=Tarticle.CreateEmpty
  else
    if ch in ['B','b','È','è'] then
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
  if PromptForFileName('Ââåäèòå èìÿ òåêñòîâîãî ôàéëà',name,false) then
    begin
      l.SaveToFile(name);
      ShowMessage('Ôàéë ñîçäàí');
    end;
end;

procedure SaveToText(var l:TListPbl);
begin
  if L.FileName='' then
    SaveAs(l)
  else
    begin
      L.SaveToFile(L.FileName);
      ShowMessage('Ôàéë ñîõðàíåí');
    end;
end;

function CanCloselist(var l:TListPbl): boolean;
var
  ch:char;
begin
  result:=true;
  if (l<>nil) and (l.Modified) then
  begin
    writeln('Ôàéë èçìåíåí'#13#10'A/a - ñîõðàíèòü èçìåíåíèÿ è âûéòè'#13#10'B/b - îòìåíà'#13#10'Äðóãîå - âûõîä');
    readln(ch);
    if ch in ['A','a','Ô','ô'] then
      begin
       SaveToText(l);
       result:=not l.Modified
      end
    else
      if ch in ['B','b','È','è'] then
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
      if InputQuery('Áóäåòå äîáàâëÿòü ýëåìåíòû (Y/N)', YesOrNo) in Yes then
        repeat
          AddInfo(l);
        until not (InputQuery('Áóäåòå åùå äîáàâëÿòü ýëåìåíòû (Y/N)', YesOrNo) in Yes);
      ShowMessage('Ñïèñîê ñîçäàí');
    end;
end;

procedure DeleteInfo(var l:TListPbl);
var
  ind:integer;
begin
  ind:=InputNumber('Ââåäèòå íîìåð óäàëÿåìîé ïóáëèêàöèè', 1, l.Count);
  l.Delete(ind-1);
end;

procedure ChangeInfo(var l:TListPbl);
var
  ind:integer;
  p:Tpublication;
begin
  ind:=InputNumber('Ââåäèòå íîìåð èçìåíÿåìîé ïóáëèêàöèè', 1, l.Count);
  if InputPubl(p) then
    l.Publication[ind-1]:=p;
end;

procedure LoadFromFile(var l:TListPbl);
var
  name : string;
begin
  if PromptForFileName('Ââåäèòå èìÿ òåêñòîâîãî ôàéëà',name,true) and
     CanCloseList(l)
  then
    begin
      L:=TListPbl.Create;
      if not l.LoadFromFile(Name)  then
        begin
          FreeAndNil(L);
          writeln('Íå óäàëîñü çàãðóçèòü äàííûå èç ôàéëà');
          writeln;
        end;
    end;
end;


//ãëàâíàÿ çàäà÷à
procedure MainTask(var l:TListPbl);
var
  res:TListPbl;
  author, sdat, endat:string;
begin
  res:=TListPbl.Create;
  writeln('Ââåäèòå èìÿ àâòîðà');
  readln(author);
  writeln('Ââåäèòå äàòó íà÷èíàÿ ñ êîòîðîé íóæíî íàéòè ïóáëèêàöèè');
  readln(sdat);
  writeln('Ââåäèòå ïî êîòîðóþ èñêàòü');
  readln(endat);
  res:=l.Exist(author,strTodate(sdat), strTodate(endat));
  PrintList(res);
  if InputQuery('Ñîõðàíèòü ðåçóëüòàò â ôàéë? (Y/N)', YesOrNo) in Yes then
    SaveToText(res);
  res.free;
end;

//âûõîä èç ïðîãðàììû
procedure exit(l:TListPbl; var item:integer);
begin
  if not cancloseList(l) then
    item:=-1;
end;

//ìåíþ
var
  l:TListPbl;
  item:integer;

function GetMenuItem:integer;
var
  MaxItem:integer;
begin
  writeln('1-ñîçäàòü ñïèñîê');
  writeln('2-çàãðóçèòü èç ôàéëà');
  MaxItem:=2;
  if l<>nil then
    begin
      writeln('3-ïå÷àòü ñïèñêà');
      writeln('4-ñîõðàíèòü');
      writeln('5-ñîõðàíèòü êàê');
      writeln('6-äîáàâëåíèå äàííûõ');
      writeln('7-óäàëåíèå çàïèñè');
      writeln('8-ðåäàêòèðîâàíèå çàïèñè');
      writeln('9-ðåøåíèå îñíîâíîé çàäà÷è');
      MaxItem:=9;
    end;
  writeln('0-âûõîä');
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

