{Сравнить два дерева}
unit Form_Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,StdCtrls, ExtCtrls, ComCtrls,Unode,Utree,Contnrs;

type
  TFormMain = class(TForm)
    TV1: TTreeView;
    TV2: TTreeView;
    Panel1: TPanel;
    BtnOd: TButton;
    BtnRand: TButton;
    btnRez: TButton;
    edRez: TLabeledEdit;
    Razmer: TLabel;
    btnClear: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BtnRandClick(Sender: TObject);
    procedure BtnOdClick(Sender: TObject);
    procedure btnRezClick(Sender: TObject);
  private
    { Private declarations }
  public
    Tree1,Tree2:TTree;
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

procedure TFormMain.FormCreate(Sender: TObject);
begin
  Randomize;
end;

procedure TFormMain.BtnRandClick(Sender: TObject);
begin
  Tree1:=TTree.BuildRandom(3);
  Tree1.View(TV1);
  Tree2:=TTree.BuildRandom(3);
  Tree2.View(TV2);
end;

procedure TFormMain.BtnOdClick(Sender: TObject);
begin
  Tree1:=TTree.BuildRandom(3);
  Tree1.View(TV1);
  FreeAndNil(Tree2);
  Tree2:=Tree1.Copy;
  Tree2.View(TV2);
end;

procedure TFormMain.btnRezClick(Sender: TObject);
begin
  edrez.Text:=Tree1.Print(Tree2);
  if Tree1.IsEqual_I(Tree2) then
    edrez.Text:='Одинаковые'
  else
    edrez.Text:='Разные'
end;

end.
