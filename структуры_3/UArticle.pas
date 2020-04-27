unit UArticle;

interface

uses UPublication, SysUtils, UAdditionlFunction;

type
  TArticle = class(Tpublication)
  private
    fnameArt:string;
    fstartPg, fendPg:integer;
  protected
    procedure SetPg(astartPg, aendPg:integer);
  public
    constructor CreateEmpty;
    constructor Create(aTitle, aAuthers, ADate, anameArt : string; astartPg, aendPg:integer);

    class function GetKind : string; override;

    procedure Input; override;

    procedure SaveToFile (var f : TextFile); override;
    function LoadFromFile (var f : TextFile) : boolean;  override;

    property startPg :integer read fstartPg write fstartPg;
    property lastPg :integer read fendPg write fendPg;
    property nameart : string read fnameArt write fnameArt;
  end;

implementation

{ TArticle }

constructor TArticle.Create(aTitle, aAuthers, ADate, anameArt : string; astartPg, aendPg:integer);
begin
  inherited Create(aTitle, aAuthers, aDate);
  FnameArt:=anameArt;
  FstartPg:=astartPg;
  FendPg:=aendPg;
end;

constructor TArticle.CreateEmpty;
begin
  inherited CreateEmpty;
  fnameArt:='';
  FstartPg:=0;
  FendPg:=0;
end;

class function TArticle.GetKind: string;
begin
  result:='Ñòàòÿ'
end;

procedure TArticle.Input;
var
  hel: integer;
  input1, input2: string;
begin
  inherited input;
  writeln('Ââåäèòå íàçâàíèå æóðíàëà');
  readln(fnameArt);
  repeat
    writeln('Ââåäèòå ñòðàíèöó íà÷àëà');
    readln(input1);
    trystrtoint(input1, fstartPg);
    
    writeln('Ââåäèòå ñòðàíèöó êîíöà');
    readln(input2);
    trystrtoint(input2, fendPg);
  until (fstartPg>0) and (fendPg>0);
  if fendPg < fstartPg then
    begin
      hel := fstartPg;
      fstartPg := fendPg;
      fendPg:= hel
    end;
end;

function TArticle.LoadFromFile(var f: TextFile): boolean;
var
  str, str2:string;
begin
    Result:=inherited LoadFromFile(f) and
                    GetValueFromFile(f, fnameArt) and
                    GetValueFromFile(f, str) and
                    GetValueFromFile(f, str2) and
                    TrystrToint(str,fstartPg) and (fstartPg>0) and
                    TrystrToint(str,fendPg) and (fendPg>0) and
                    (fstartPg <= fendPg);
end;

procedure TArticle.SaveToFile(var f: TextFile);
begin
  inherited SaveToFile(f);
  writeln(f, 'Íàçâàíèå æóðíàëà: '+fnameArt);
  writeln(f, 'Íà÷àëî: '+intTostr(fstartPg));
  writeln(f, 'Êîíåö: '+intTostr(fendPg));
end;

procedure TArticle.SetPg(astartPg, aendPg:integer);
begin
  if (astartPg>0) and (aendPg>0) then
    if astartPg <= aendPg then
      begin
         fstartPg:=astartPg;
         fendPg:= aendPg;
      end
    else
      begin
         fstartPg:=aendPg;
         fendPg:= astartPg;
      end;
end;

end.
