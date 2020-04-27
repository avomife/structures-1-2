{ Модуль с описанием узла дерева }
unit UNode;

interface

uses
  ComCtrls, SysUtils, Math;

const
  MinElem = 0;
  MaxElem = 100;

type
  TElem = MinElem..MaxElem;
  TNode = class
  private
    FInf: TElem;
    FLeft, FRight: TNode;
  public
    constructor Create(el : TElem = MinElem);
    destructor Destroy; override;
    constructor BuildRandom(n: integer);
    procedure View(TV:TTreeView; ParentNode: TTreeNode);
    function Copy : TNode;
    function IsEqual (node : tNode): boolean;

    property Info : Telem
      read FInf;
    property Left : TNode
      read FLeft write FLeft;
    property Right : TNode
      read FRight write FRight;
  end;

implementation

constructor TNode.Create(el:TElem = MinElem);
begin
  inherited Create;
  FInf:= el;
  FLeft:= nil;
  FRight:= nil;
end;

destructor TNode.Destroy;
begin
  FreeAndNil(FLeft);
  FreeAndNil(FRight);
end;

constructor TNode.BuildRandom(n: integer);
var
  x: TElem;
  nl,nr: integer;
begin
  x:=Random(100);
  Create(x);
  n:=n-1;
  if n>0 then
    begin
      nl:=Random(n+1);
      if nl>0 then
        FLeft:= TNode.BuildRandom(nl);
      nr:=n-nl;
      if nr>0 then
        FRight:= TNode.BuildRandom(nr);
    end;
end;

function TNode.Copy: TNode;
begin
  Result:=TNode.Create(Self.FInf);
  if self.FLeft<>nil then
    Result.FLeft:=Self.FLeft;
  if self.FRight<>nil then
    Result.FRight:=self.FRight;
end;

procedure TNode.View(TV: TTreeView; ParentNode: TTreeNode);
 var node: TTreeNode;
begin
  if Self = nil then
    TV.Items.AddChild(ParentNode, 'x')
  else
    begin
      node:= TV.Items.AddChild(ParentNode, IntToStr(FInf));
      if (FLeft<>nil) or(FRight<>nil) then
        begin
          FLeft.View(TV, node);
          FRight.View(TV, node);
        end;
    end;
end;

function TNode.IsEqual(node: tNode): boolean;
begin
  if (self=nil) and (node=nil) then
    result:=true
  else
    if self.FInf=node.FInf then
      result:=self.FLeft.IsEqual(node.FLeft) and self.FRight.IsEqual(node.FRight)
    else
      result:=false;
end;

end.

