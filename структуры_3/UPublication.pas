unit UPublication;

interface

uses uAuthorList, classes, DateUtils, SysUtils, UAdditionlFunction;

type
  Tpublication = class
  private
    FTitle: string;
    FAuthor: TAuthorList;
    FDate: TDateTime;
  protected
    procedure SetTitle(value : string);
  public
    constructor CreateEmpty;
    constructor Create(aTitle, aAuthers, ADate : string);
    destructor Destroy; override;

    class function GetKind : string; virtual; abstract;

    procedure Input; virtual;
    procedure Print;

    procedure SaveToFile (var f : TextFile); virtual;
    function LoadFromFile (var f : TextFile) : boolean;  virtual;

    property Title : string read FTitle write SetTitle;
    property Date: TDateTime read Fdate write Fdate;
    property Author: TAuthorList read FAuthor write FAuthor;
  end;

implementation

constructor Tpublication.Create(aTitle, aAuthers, aDate: string);
begin
  FTitle:=aTitle;
  FAuthor:=TAuthorList.Create;
  FAuthor.FromString(aAuthers);
  FDate:=strTodate(aDate);
end;

constructor Tpublication.CreateEmpty;
begin
  FTitle:='';
  FAuthor:=TAuthorList.Create;
  FDate:=Today();
end;

destructor Tpublication.Destroy;
begin
  FAuthor.Destroy;
  inherited;
end;

procedure Tpublication.Input;
var
  str:string;
begin
  writeln('Введите название публикации');
  repeat
    readln(Ftitle);
    FTitle:=Trim(FTitle)
  until FTitle<>'';
  repeat
    str:=InputString('Введите авторов');
  until FAuthor.FromString(str);
  repeat
  until TrystrTodate(InputString('Введите дату **.**.**'), FDate);
end;

procedure Tpublication.Print;
begin
  SaveToFile(output)
end;

procedure Tpublication.SaveToFile(var f: TextFile);
begin
   writeln(f, GetKind);
   writeln(f, 'Название: '+Ftitle);
   writeln(f, 'Авторы: '+Fauthor.ToString);
   writeln(f, 'Дата: '+DateToStr(FDate));
end;

function Tpublication.LoadFromFile(var f: TextFile): boolean;
var
  str:string;
begin
  Result:= GetValueFromFile(f, Ftitle) and
           FAuthor.LoadFromText(f) and
           GetValueFromFile(f, str) and TryStrToDate(str, FDate)
end;

procedure Tpublication.SetTitle(value: string);
begin
  if value<>'' then
    Ftitle:=value;
end;

end.

