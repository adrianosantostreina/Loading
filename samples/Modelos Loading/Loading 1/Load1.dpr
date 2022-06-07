program Load1;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  UntDM in 'UntDM.pas' {DM: TDataModule},
  UntLib in 'UntLib.pas',
  UntAguarde in 'UntAguarde.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
