unit Unit2;

interface

uses
  Loading,

  FMX.Controls,
  FMX.Controls.Presentation,
  FMX.Dialogs,
  FMX.Forms,
  FMX.Graphics,
  FMX.StdCtrls,
  FMX.Types,

  System.Classes,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Variants;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Timer1: TTimer;
    Change: TButton;
    Timer2: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure ChangeClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    private
      { Private declarations }
      LTime : Integer;
    public
      { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}


procedure TForm2.Button1Click(Sender: TObject);
begin
  TLoading.Show('Loading customer...');
  Timer1.Enabled := True;
end;

procedure TForm2.ChangeClick(Sender: TObject);
begin
  TLoading.Show('Loading customer...');
  Timer2.Enabled := True;
end;

procedure TForm2.Timer1Timer(Sender: TObject);
begin
  TLoading.Hide;
  Timer1.Enabled := False;
end;

procedure TForm2.Timer2Timer(Sender: TObject);
begin
  Inc(LTime);
  if LTime = 2 then
    TLoading.ChangeMessage('Loading products...')
  else if LTime = 5 then
    TLoading.ChangeMessage('Loading settings...')
  else if LTime = 7 then
    TLoading.ChangeMessage('Ending...')
  else if LTime = 10 then
  begin
    TLoading.Hide;
    Timer2.Enabled := False;
  end;
end;

end.
