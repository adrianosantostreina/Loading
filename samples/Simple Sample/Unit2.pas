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
    Label1: TLabel;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    private
      { Private declarations }
    public
      { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}


procedure TForm2.Button1Click(Sender: TObject);
var
  LThread: TThread;
begin
  TLoading.Show('Loading customer...');
  Timer1.Enabled := True;
end;

procedure TForm2.Timer1Timer(Sender: TObject);
begin
  TLoading.Hide;
  Timer1.Enabled := False;
end;

end.
