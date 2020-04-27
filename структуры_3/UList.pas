unit Ulist;

interface

uses
  SysUtils, Types, Classes, Upublication, UBook, UArticle;

type

  TListPbl = class(TList)
  private
    FFileName : string;
    FModified : boolean;
  protected
    function GetPubl(index: integer): TPublication;
    procedure SetPubl(index: integer; const Value: Tpublication);
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Print;

    function Exist(aAuthor : string; StartD, FinishD : TDateTime) : TListPbl;

    function LoadFromFile(aFileName : string) : boolean;

    procedure SaveToFile(aFileName : string);

    property FileName : string read FFileName;
    property Modified : boolean read FModified ;
    property Publication [index : integer] : TPublication
      read GetPubl write SetPubl;
  end;

implementation

function TListPbl.GeTPubl(index: integer): TPublication;
begin
  Result:=inherited Items[index];
end;

procedure TListPbl.SeTPubl(index: integer; const Value: TPublication);
begin
  inherited Items[index]:=Value;
  FModified:=true;
end;

constructor TListPbl.Create;
begin
  inherited Create;
  FFileName:='';
  FModified:=false;
end;

destructor TListPbl.Destroy;
begin
  Finalize(FFileName);
  inherited Destroy;
end;

procedure TListPbl.Print;
var
  i : integer;
begin
  if (Count < 0) then
    writeln('Список пуст')
  else
    for i:=0 to Count-1 do
      begin
        write(' ',i+1,') ');
        Publication[i].Print;
        writeln
      end;
end;

function TListPbl.LoadFromFile(aFileName : string) : boolean;
var
  f : TextFile;
  str : string;
  publ : TPublication;
begin
  assignfile(f,aFileName);
  reset(f);
  Result:=not eof(f);
  while not eof(f) and Result do
    begin
      readln(f,str);
      if str=Tbook.GetKind then
        Publ:=Tbook.CreateEmpty
      else
        if str=TArticle.GetKind then
          Publ:=TArticle.CreateEmpty
        else
          Result:=false;
      if Result then
        begin
          Result:=Publ.LoadFromFile(f);
          if Result then
            Add(Publ)
          else
            publ.Free;
        end;
      if Result and not eof(f) then
        readln(f)
    end;
  close(f);
  FFileName:=aFileName;
  FModified:=false;
end;

procedure TListPbl.SaveToFile(aFileName : string);
var
  f : TextFile;
  i : integer;
begin
  assignfile(f,aFileName);
  rewrite(f);
  for i:=0 to Count-1 do
    begin
      Publication[i].SaveToFile(f);
      writeln(f);
    end;
  close(f);
  FFileName:=aFileName;
  FModified:=false;
end;

procedure TListPbl.Notify(Ptr: Pointer; Action: TListNotification);
begin
  inherited;
  if Action = lnDeleted then
    TPublication(Ptr).Free;
  FModified:=true;
end;

function TListPbl.Exist(aAuthor: string; StartD, FinishD: TDateTime): TListPbl; //переделать на compare date / dateUtils
var
  i:integer;
begin
  result:=TListPbl.Create;
  for i := 0 to Count-1 do
      if (Publication[i].Author.IndexOf(aAuthor)<>-1) and
         (Publication[i].Date>=startD) and
         (Publication[i].Date<=FinishD)
      then
        result.Add(Publication[i]);

end;

end.
