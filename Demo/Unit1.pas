unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  Loading;

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
begin
  {
  Thread is essential for the correct way to use TLoading.
  It is necessary that you already have some knowledge about how Thread works,
  if you don't have, please go to it
  }
  TThread.CreateAnonymousThread(
  procedure
  var
    LCount: Integer;
  begin
    try
      try
        LCount := 0;
        {
        Voce nao precisa SEMPRE usar o primeiro parametro como TThread.CurrentThread
        ou passar a variavel da Thread.
        Voce so precisa usar este parametro de se realmente for usar este
        parametro, obviamente no caso do TLoading ele naoa eh necessario
        }
        TThread.Synchronize(nil,
        procedure
        begin
          TLoading.Show('Aguarde');
        end);

        {
        Please, do not use Sleep if it is not needed, here we did just for simulate
        some slowly procces
        }
        TThread.Sleep(1000);

        while LCount < 5 do
        begin
          Inc(LCount, 1);
          {
          Call ChangeMessage is just possible without using Synchronize or Queue
          because we are using into the prcedure alrady.
          Take a look on its source code
          }
          TLoading.ChangeMessage('Aguarde [' + LCount.ToString + ']');

          {
          Please, do not use Sleep if it is not needed, here we did just for simulate
          some slowly procces
          }
          TThread.Sleep(1000);
        end;

      finally
        TThread.Synchronize(nil,
        procedure
        begin
          TLoading.Hide;
        end);
      end;
    except
      on E:Exception do
      begin
        {
        we know it is not needed here on this demo project, you can copy it though
        }
        TThread.Synchronize(nil,
        procedure
        begin
          ShowMessage(E.Message);
        end);
      end;
    end;
  end).Start;
end;

end.
