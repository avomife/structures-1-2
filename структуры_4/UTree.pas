{ Модуль с описанием дерева }
unit UTree;

interface

uses
  ComCtrls, Math, SysUtils, UNode, Contnrs;

type
  TTree = class
  private
    FRoot: TNode;
  public
    constructor Create;
    destructor Destroy; override;
    constructor BuildRandom(n: integer);
    procedure Clear;
    procedure View(TV: TTreeView);
    function Copy: TTree;
    function IsEqual_R(Tree : TTree): boolean;
    function IsEqual_I(Tree : TTree): boolean;
    function Print(Tree : TTree): string;
  end;

implementation

constructor TTree.Create;
begin
  FRoot:=nil;
end;

constructor TTree.BuildRandom(n: integer);
begin
  Clear;
  if n>0 then
    FRoot:=TNode.BuildRandom(n);
end;

function TTree.Copy: TTree;
begin
  result:=TTree.Create;
  if Froot<>nil then
    Result.FRoot:=FRoot.Copy;
end;


destructor TTree.Destroy;
begin
  Clear;
  inherited;
end;

procedure TTree.Clear;
begin
  FreeAndNil(FRoot);
end;

procedure TTree.View(TV: TTreeView);
begin
  TV.Items.Clear;
  if FRoot<>nil then
    FRoot.View(TV,nil);
  TV.FullExpand;
end;

function TTree.IsEqual_R(Tree : TTree): boolean;
begin
  Result:=((self.FRoot=nil) and (Tree.Froot=nil)) or self.FRoot.IsEqual(Tree.FRoot);
end;

function TTree.IsEqual_I(Tree : TTree): boolean;
var
  Q : TQueue;
  node1,node2 : TNode;
begin
  Result:=((Froot=nil) and (Tree.FRoot=nil)) or ((FRoot<>nil) and (Tree.FRoot<>nil)) ;
  if (FRoot<>nil) and Result  then
    begin
      Q:=TQueue.Create;
      Q.Push(self.FRoot);
      Q.Push(Tree.FRoot);
      while (Q.Count>0) and result do
        begin
          node1:=Q.Pop;
          node2:=Q.Pop;
          Result:=(node1.Info)=(node2.Info);
          if (node1.Left<>nil) and (node2.Left<>nil) then
            begin
              Q.Push(node1.Left);
              Q.Push(node2.Left);
            end;
          if (node1.Right<>nil) and (node2.Right<>nil) then
            begin
              Q.Push(node1.Right);
              Q.Push(node2.Right);
            end;
        end;
      Q.Free
    end;
end;

function TTree.Print(Tree : TTree): string;
var
  Q : TQueue;
  node1,node2 : TNode;
begin
  Result:='';
  if (FRoot<>nil) and (Tree.FRoot<>nil)  then
    begin
      Q:=TQueue.Create;
      Q.Push(self.FRoot);
      Q.Push(Tree.FRoot);
      while (Q.Count>0) do
        begin
          node1:=Q.Pop;
          node2:=Q.Pop;
          Result:=Result+inttostr(node1.Info)+inttostr(node2.Info);
          if (node1.Left<>nil) and (node2.Left<>nil) then
            begin
              Q.Push(node1.Left);
              Q.Push(node2.Left);
            end;
          if (node1.Right<>nil) and (node2.Right<>nil) then
            begin
              Q.Push(node1.Right);
              Q.Push(node2.Right);
            end;
        end;
      Q.Free
    end;
end;
end.

