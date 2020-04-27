program task_4;

uses
  Forms,
  Form_Main in 'D:\pomosch\помощь\Zadachi\Ст и алг 4\Form_Main.pas' {FormMain},
  UTree in 'D:\pomosch\помощь\Zadachi\Ст и алг 4\UTree.pas',
  UNode in 'D:\pomosch\помощь\Zadachi\Ст и алг 4\UNode.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
