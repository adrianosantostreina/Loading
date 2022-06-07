unit Unit1;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,

  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.StdCtrls,
  FMX.Controls.Presentation,
  FMX.Objects,
  FMX.ListBox,
  FMX.Layouts,
  FMX.TabControl,
  FMX.DialogService,
  FMX.Edit,
  FMX.Effects,
  FMX.Filter.Effects,

  Data.Db,

  UntLib,
  UntAguarde

;

type
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    Button1: TButton;
    Rectangle1: TRectangle;
    vertLista: TVertScrollBox;
    recItemCIdade: TRectangle;
    recItem: TRectangle;
    lytItemCidade: TLayout;
    lytDados: TLayout;
    lblCodIBGE: TLabel;
    lblDescCidade: TLabel;
    lytAccessory: TLayout;
    pthBtnAccess: TPath;
    speAccessCli: TSpeedButton;
    edtCidade: TEdit;
    Rectangle2: TRectangle;
    procedure Button1Click(Sender: TObject);
  private
    procedure OnSelecionarCidade(Sender: TObject);
    procedure LimparLista(Sender: TObject; AVertScroll: TVertScrollBox;
      ARectBase: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  UntDM;

{$R *.fmx}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  TLibrary.CustomThread(
    procedure ()
    begin
      //Start do processamento
      TThread.Synchronize(
        TThread.CurrentThread,
        procedure ()
        begin
          TAguarde.Show('Carregando cidades...');
          Self.vertLista.Visible := False;
          Self.vertLista.BeginUpdate;
          Self.LimparLista(Sender, vertLista, lytItemCidade.Name);
          DM.QryCidades.DisableControls;
        end
      );
    end,
    procedure ()
    var
      LFrame        : TLayout;
      LPos          : Single;
    begin
      //Processamento principal
      LPos                      := 8;
      lytItemCidade.Visible     := False;

      if not Self.edtCidade.Text.Equals(EmptyStr) then
      begin

        DM.QryCidades.Active := False;
        DM.QryCidades.SQL.Clear;
        DM.QryCidades.SQL.Text := 'SELECT * FROM MOB006 WHERE CID_ESTADO IN (23, 29, 31, 33, 35, 55)';
        DM.QryCidades.Active := True;
      end
      else
      begin
        DM.QryCidades.Active := False;
        DM.QryCidades.SQL.Clear;
        DM.QryCidades.SQL.Text := 'SELECT * FROM MOB006';
        DM.QryCidades.Active := True;
      end;

      DM.QryCidades.First;
      while not DM.QryCidades.EOF do
      begin
        //Preencher os dados
        Self.lblCodIBGE.Text    := Format('%6.6d', [DM.QryCidadesCID_CODIBGE.AsInteger]);
        Self.lblDescCidade.Text := DM.QryCidadesCID_NOME.AsString;
        lytItemCidade.Tag       := DM.QryCidadesCID_ID.AsInteger;

        LFrame                  := TLayout(lytItemCidade.Clone(vertLista));
        LFrame.Parent           := vertLista;
        LFrame.Height           := lytItemCidade.Height - 4;
        LFrame.Width            := lytItemCidade.Width;

        LFrame.Position.X       := 4;
        LFrame.Position.Y       := LPos;
        LFrame.Margins.Left     := 4;
        LFrame.Margins.Top      := 4;
        LFrame.Margins.Bottom   := 4;
        LFrame.Margins.Right    := 4;


        for var I : Integer := 0 to Pred(LFrame.ComponentCount) do
        begin
          if LFrame.Components[I] is TSpeedButton then
          begin
            TThread.Synchronize(
              TThread.CurrentThread,
              procedure ()
              begin
                TSpeedButton(LFrame.Components[I]).OnClick := OnSelecionarCidade;
              end
            );
            break;
          end;
        end;

        LFrame.Visible          := True;

        LPos                    := LPos + lytItemCidade.Height + 4;

        DM.QryCidades.Next;
      end;

    end,
    procedure ()
    begin
      //Complete
      TThread.Synchronize(
        TThread.CurrentThread,
        procedure ()
        begin
          TAguarde.Hide;
          Self.vertLista.EndUpdate;
          Self.vertLista.Visible := True;
          DM.QryCidades.EnableControls;
        end
      );
    end,
    procedure (const AException : string)
    begin
      //Start do processamento
    end,
    True
  );

end;

procedure TForm1.LimparLista(Sender: TObject; AVertScroll: TVertScrollBox; ARectBase: string);
var
  I      : Integer;
  lFrame : TRectangle;
begin
  //Pesquisar e deixar isso no formulário padrão de listas.
  AVertScroll.BeginUpdate;
  for I := Pred(AVertScroll.Content.ChildrenCount) downto 0 do
  begin
    if (AVertScroll.Content.Children[I] is TRectangle) then
    begin
      if not (TRectangle(AVertScroll.Content.Children[I]).Name = ARectBase) then
      begin
        lFrame := (AVertScroll.Content.Children[I] as TRectangle);
        lFrame.DisposeOf;
        lFrame := nil;
      end;
    end;
  end;
  AVertScroll.EndUpdate;
end;

procedure TForm1.OnSelecionarCidade(Sender: TObject);
begin
  DM.QryCidades.Locate('CID_ID', TLayout(TSpeedButton(Sender).Owner).Tag, []);
  ShowMessage('Clicou na cidade : ' +
    DM.QryCidadesCID_NOME.AsString);
end;

end.

