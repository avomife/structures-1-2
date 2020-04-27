unit Ubook;

interface

uses UPublication, SysUtils, UAdditionlFunction;

type
  Tbook = class(Tpublication)
  private
    Fpages : integer;

  protected
    procedure SetPages(const Value: integer);
  public
    constructor CreateEmpty;
    constructor Create(aTitle, aAuthers, ADate : string; apage:integer);

    class function GetKind : string; override;

    procedure Input; override;

    procedure SaveToFile (var f : TextFile); override;
    function LoadFromFile (var f : TextFile) : boolean;  override;

    property pages :integer read fpages write setPages;
  end;

implementation

{ Tbook }

constructor Tbook.Create(aTitle, aAuthers, aDate: string; apage:integer);
begin
  inherited Create(aTitle, aAuthers, aDate);
  fPages:=apage;
end;

constructor Tbook.CreateEmpty;
begin
  inherited CreateEmpty;
  Fpages:=0;
end;

class function Tbook.GetKind: string;
begin
  result:='Êíèãà'
end;

procedure Tbook.Input;
var BookPgInput: string; code: integer;
begin
  inherited input;
  repeat
    writeln('Ââåäèòå êîë-âî ñòðàíèö');
    readln(BookPgInput);
    val(bookPgInput, fpages, code);    
  until (code=0) and (fpages>0);
end;

function Tbook.LoadFromFile(var f: TextFile): boolean;
var
  str:string;
begin
  Result:=inherited LoadFromFile(f) and
                    GetValueFromFile(f, str) and
                    TrystrToint(str,fpages) and (FPages>0);
end;

procedure Tbook.SaveToFile(var f: TextFile);
begin
  inherited SaveToFile(f);
  writeln(f, 'Ñòðàíèö: '+intTostr(fpages));
end;

procedure Tbook.SetPages(const Value: integer);
begin
  if value>0 then
    Fpages := Value;
end;

end.
