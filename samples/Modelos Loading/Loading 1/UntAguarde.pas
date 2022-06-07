unit UntAguarde;

interface

uses
  System.UITypes,
  System.SysUtils,

  FMX.Types,
  FMX.Controls,
  FMX.StdCtrls,
  FMX.Objects,
  FMX.Forms,
  FMX.Effects,
  FMX.Layouts,
  FMX.Edit,
  FMX.Graphics,
  FMX.Dialogs;

type
  TAguarde = class
    private
      class var FAguarde      : TRectangle;
      class var FLytEdit      : TLayout;
      class var FFundo        : TPanel;
      class var FAniLoading   : TAniIndicator;
      class var FLabelMessage : TLabel;

      class procedure TrocaCorPFundo(Sender: TObject);
    public

      class procedure Show(const AMessage: string = '');
      class procedure ChangeMessage(const aMessage: string = '');
      class procedure Hide;
  end;

implementation


{ TAguarde }

class procedure TAguarde.ChangeMessage(const AMessage: string);
begin
  if (Assigned(FLabelMessage)) and(FLabelMessage <> nil) then
    try
      FLabelMessage.Text := AMessage;
    except

    end;
end;

class procedure TAguarde.Hide;
begin
  if (Assigned(FAguarde)) then
  begin
    FFundo.AnimateFloat('OPACITY', 0);
    FAguarde.AnimateFloatWait('OPACTIY', 0);

    try
      if Assigned(fAniLoading) then
        fAniLoading.DisposeOf;
      if Assigned(fLabelMessage) then
        fLabelMessage.DisposeOf;
      if Assigned(FFundo) then
        FFundo.DisposeOf;
      if Assigned(FAguarde) then
        FAguarde.DisposeOf;
    except on E:Exception do
      begin
        ShowMessage(E.Message);
      end;
    end;

    FFundo        := nil;
    FAguarde      := nil;
    FAniLoading   := nil;
    FLabelMessage := nil;
  end;
end;

class procedure TAguarde.Show(const AMessage: string);
begin
  FFundo                       := TPanel.Create(Application.MainForm);
  FFundo.Parent                := Application.MainForm;//AParent;

  FFundo.Visible               := True;
  FFundo.Align                 := TAlignLayout.Contents;
  FFundo.OnApplyStyleLookup    := TrocaCorPFundo;

  FAguarde                     := TRectangle.Create(Application.MainForm);
  FAguarde.Parent              := Application.MainForm;
  FAguarde.Visible             := True;
  FAguarde.Height              := 75;
  FAguarde.Width               := 275;
  FAguarde.XRadius             := 10;
  FAguarde.YRadius             := 10;
  FAguarde.Position.X          := (TForm(Application.MainForm).ClientWidth - FAguarde.Width) / 2;
  FAguarde.Position.Y          := (TForm(Application.MainForm).ClientHeight - FAguarde.Height) / 2;
  FAguarde.Stroke.Kind         := TBrushKind.None;

  FAniLoading                  := TAniIndicator.Create(Application.MainForm);
  FAniLoading.Visible          := False;
  FAniLoading.Enabled          := False;
  FAniLoading.Align            := TAlignLayout.Left;
  FAniLoading.Parent           := FAguarde;
  FAniLoading.Margins.Right    := 10;
  FAniLoading.Align            := TAlignLayout.MostRight;
  FAniLoading.Enabled          := True;
  FAniLoading.Visible          := True;

  with TLabel.Create(FAguarde) do
  begin
    Parent                     := FAguarde;
    Align                      := TAlignLayout.Top;
    Margins.Left               := 10;
    Margins.Top                := 10;
    Margins.Right              := 10;
    Height                     := 28;
    StyleLookup                := 'embossedlabel';
    Text                       := 'Por favor, aguarde!';
    Trimming                   := TTextTrimming.Character;
  end;

  FLabelMessage                := TLabel.Create(Application.MainForm);
  FLabelMessage.Parent         := FAguarde;
  FLabelMessage.Align          := TAlignLayout.Client;
  FLabelMessage.Margins.Left   := 10;
  FLabelMessage.Margins.Top    := 10;
  FLabelMessage.Margins.Right  := 10;
  FLabelMessage.Font.Size      := 12;
  FLabelMessage.StyledSettings := [TStyledSetting.Family, TStyledSetting.Style, TStyledSetting.FontColor];
  FLabelMessage.Text           := AMessage;
  FLabelMessage.VertTextAlign  := TTextAlign.Leading;
  FLabelMessage.Trimming       := TTextTrimming.Character;

  with TShadowEffect.Create(FAguarde) do
  begin
    Parent                     := FAguarde;
    Enabled                    := True;
  end;

  FFundo.Opacity               := 0;
  FAguarde.Opacity             := 0;

  FFundo.Visible               := True;
  FAguarde.Visible             := True;

  FFundo.AnimateFloat('OPACITY', 0.5);
  FAguarde.AnimateFloatWait('OPACITY', 1);
  FAguarde.BringToFront;
  FAguarde.SetFocus;
end;

class procedure TAguarde.TrocaCorPFundo(Sender: TObject);
var
  Rectangle : TRectangle;
begin
  Rectangle := (Sender as TFmxObject).Children[0] as TRectangle;
  Rectangle.Fill.Color := TAlphaColors.Black;
end;

end.















