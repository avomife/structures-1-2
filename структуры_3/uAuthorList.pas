unit uAuthorList;

interface

uses Classes,SysUtils,windows,StrUtils, UAdditionlFunction;

type
  TAuthorList = class(TstringList)
  public
    procedure Print;
    procedure SaveToText (var f : TextFile);
    function  LoadFromText (var f : TextFile): boolean;
    function ToString : string;
    function FromString (str : string) : boolean;
  end;

implementation

{ TAuthor }

procedure TAuthorList.Print;
var
  i : integer;
begin
  if Count = 0 then
    writeln('Авторы не известны')
  else
    begin
      writeln('Авторы');
      for i:=0 to Count-1 do
        writeln(' - '+Strings[i])
    end;
end;

function TAuthorList.FromString(str: string): boolean;
var
  s:string;
  p, count:integer;
begin
  p:=pos(',', str);
  while p>0 do
    begin
      s:=trim(copy(str,1,p-1));//берем автора
      self.Add(s);  // добавляем
      system.Delete(str, 1, p);
      p:=POs(',', str); //переходим к следующему
      count:=count+1;
    end;
  result:=Count>0;
end;

function TAuthorList.ToString: string;
var
  i:integer;
begin
  Result:='';
  for i:=0 to Count-1 do
    Result:=Result+Strings[i]+', ';
end;

procedure TAuthorList.SaveToText(var f: TextFile);
begin
  writeln(f, 'Авторы: ', ToString);
end;

function TAuthorList.LoadFromText(var f: TextFile): boolean;
var
  val:string;
begin
  Result:=GetValueFromFile(f, val) and FromString(val);
end;

end.
