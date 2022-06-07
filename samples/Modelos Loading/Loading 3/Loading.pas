unit Loading;

interface

uses
  System.SysUtils,
  System.UITypes,
  System.Classes,
  FMX.Types,

  FMX.Controls,
  FMX.StdCtrls,
  FMX.Objects,
  FMX.Effects,
  FMX.Layouts,
  FMX.Forms,
  FMX.Graphics,
  FMX.Ani,
  FMX.VirtualKeyboard,
  FMX.Platform;

type
  TLoading = class
  private
    class var Layout          : TLayout;
    class var Background      : TRectangle;
    class var ArcLoad         : TArc;
    class var ArcLoadMaior    : TArc;
    class var MessageLoad     : TLabel;
    class var Animation       : TFloatAnimation;
    class var AnimationMaior  : TFloatAnimation;
    class var KeyUp           : TKeyEvent;
    class procedure OnNewKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  public
    class procedure Show(const AForm : TForm; const AMessage : string);
    class procedure Hide(const AForm: TForm);

  end;

implementation

{ TLoading }


class procedure TLoading.Hide(const AForm: TForm);
begin
  if Assigned(Layout) then
  begin
    try
    if Assigned(MessageLoad) then
      MessageLoad.DisposeOf;

    if Assigned(Animation) then
      Animation.DisposeOf;

    if Assigned(ArcLoad) then
    ArcLoad.DisposeOf;

    if Assigned(Background) then
      Background.DisposeOf;

    if Assigned(Layout) then
      Layout.DisposeOf;

    except

    end;
  end;

  MessageLoad   := nil;
  Animation     := nil;
  ArcLoad       := nil;
  Layout        := nil;
  Background    := nil;

  if Assigned(AForm) and Assigned(KeyUp) then
    AForm.OnKeyUp := KeyUp;
end;

class procedure TLoading.OnNewKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkHardwareBack then
    Key := 0;
end;

class procedure TLoading.Show(const AForm : TForm; const AMessage: string);
var
  FService: IFMXVirtualKeyboardService;
begin
  KeyUp                                    := AForm.OnKeyUp; // Guardo o evento antigo
  AForm.OnKeyUp                            := OnNewKeyUp;    // Passo para ele um novo evento
  //BackGround
  Background                               := TRectangle.Create(AForm);
  Background.Opacity                       := 0.6;
  Background.Parent                        := AForm;
  Background.Visible                       := true;
  Background.Align                         := TAlignLayout.Contents;
  Background.Fill.Color                    := TAlphaColorRec.Black;
  Background.Fill.Kind                     := TBrushKind.Solid;
  Background.Stroke.Kind                   := TBrushKind.None;
  Background.Visible                       := True;

  //Layout Text
  Layout                                   := TLayout.Create(AForm);
  Layout.Opacity                           := 0;
  Layout.Parent                            := AForm;
  Layout.Visible                           := True;
  Layout.Align                             := TAlignLayout.Contents;
  Layout.Width                             := 250;
  Layout.Height                            := 78;
  Layout.Visible                           := True;

  //Arco Menor
  ArcLoad                                  := TArc.Create(AForm);
  ArcLoad.Opacity                          := 0.6;
  ArcLoad.Visible                          := true;
  ArcLoad.Parent                           := Layout;
  ArcLoad.Align                            := TAlignLayout.Center;
  ArcLoad.Margins.Bottom                   := 55;
  ArcLoad.Width                            := 25;
  ArcLoad.Height                           := 25;
  ArcLoad.EndAngle                         := 280;
  ArcLoad.Stroke.Color                     := $FF3E60FE;
  ArcLoad.Stroke.Thickness                 := 2;
  ArcLoad.Position.X                       := Trunc((Layout.Width - ArcLoad.Width) / 2);
  ArcLoad.Position.Y                       := 0;

  //Animation
  Animation                                := TFloatAnimation.Create(AForm);
  Animation.Parent                         := ArcLoad;
  Animation.StartValue                     := 0;
  Animation.StopValue                      := 360;
  Animation.Duration                       := 0.8;
  Animation.Loop                           := True;
  Animation.PropertyName                   := 'RotationAngle';
  Animation.AnimationType                  := TAnimationType.InOut;
  Animation.Interpolation                  := TInterpolationType.Linear;
  Animation.Start;

  //Arco Maior
  ArcLoadMaior                             := TArc.Create(AForm);
  ArcLoadMaior.Opacity                     := 0.6;
  ArcLoadMaior.Visible                     := true;
  ArcLoadMaior.Parent                      := Layout;
  ArcLoadMaior.Align                       := TAlignLayout.Center;
  ArcLoadMaior.Margins.Bottom              := 55;
  ArcLoadMaior.Width                       := 60;
  ArcLoadMaior.Height                      := 60;
  ArcLoadMaior.EndAngle                    := 280;
  ArcLoadMaior.Stroke.Color                := $FFAAB9FF;
  ArcLoadMaior.Stroke.Thickness            := 4;
  ArcLoadMaior.Position.X                  := Trunc((Layout.Width - ArcLoad.Width) / 2);
  ArcLoadMaior.Position.Y                  := 0;

  //Animation
  AnimationMaior                           := TFloatAnimation.Create(AForm);
  AnimationMaior.Parent                    := ArcLoadMaior;
  AnimationMaior.StartValue                := 0;
  AnimationMaior.StopValue                 := 360;
  AnimationMaior.Duration                  := 0.8;
  AnimationMaior.Loop                      := True;
  AnimationMaior.PropertyName              := 'RotationAngle';
  AnimationMaior.AnimationType             := TAnimationType.InOut;
  AnimationMaior.Inverse                   := True;
  AnimationMaior.Interpolation             := TInterpolationType.Linear;
  AnimationMaior.Start;

  // Label do texto...
  MessageLoad                              := TLabel.Create(AForm);
  MessageLoad.Opacity                      := 0.6;
  MessageLoad.Parent                       := Layout;
  MessageLoad.Align                        := TAlignLayout.Center;
  MessageLoad.Margins.Top                  := 100;
  MessageLoad.Font.Size                    := 13;
  MessageLoad.Height                       := 70;
  MessageLoad.Width                        := AForm.Width - 100;
  MessageLoad.FontColor                    := $FF031B8A;
  MessageLoad.TextSettings.HorzAlign       := TTextAlign.Center;
  MessageLoad.TextSettings.VertAlign       := TTextAlign.Leading;
  MessageLoad.StyledSettings               := [TStyledSetting.Family, TStyledSetting.Style];
  MessageLoad.Text                         := AMessage;
  MessageLoad.VertTextAlign                := TTextAlign.Leading;
  MessageLoad.Trimming                     := TTextTrimming.None;
  MessageLoad.TabStop                      := False;
  MessageLoad.SetFocus;

  //Show Controls
  Background.AnimateFloat('Opacity', 0);
  Layout.AnimateFloat('Opacity', 1);
  Layout.BringToFront;

  //Hide KeyBoard
  TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));
  if (FService <> nil) then
    FService.HideVirtualKeyboard;

  FService := nil;
end;


end.
