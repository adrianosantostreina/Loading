unit Loading;

interface

uses
  System.SysUtils,
  System.UITypes,
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
    class var MessageLoad     : TLabel;
    class var Animation       : TFloatAnimation;
    class var ColorAnimation  : TColorAnimation;
    class var Circle          : TCircle;
    class var LabelX          : TLabel;
  public
    class procedure Show(const AForm : TForm; const AMessage : string);
    class procedure Hide;
  end;

implementation

{ TLoading }


class procedure TLoading.Hide;
begin
  if Assigned(Layout) then
  begin
    try
    if Assigned(MessageLoad) then
      MessageLoad.DisposeOf;

    if Assigned(Animation) then
      Animation.DisposeOf;

    if Assigned(ColorAnimation) then
      ColorAnimation.DisposeOf;

    if Assigned(Circle) then
      Circle.DisposeOf;

    if Assigned(LabelX) then
      LabelX.DisposeOf;

    if Assigned(Background) then
      Background.DisposeOf;

    if Assigned(Layout) then
      Layout.DisposeOf;

    except

    end;
  end;

  MessageLoad := nil;
  Animation   := nil;
  Circle      := nil;
  LabelX      := nil;
  Layout      := nil;
  Background  := nil;
end;

class procedure TLoading.Show(const AForm : TForm; const AMessage: string);
var
  FService: IFMXVirtualKeyboardService;
begin
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
  Layout.Align                             := TAlignLayout.Center;
  Layout.Width                             := 110;
  Layout.Height                            := 45;
  Layout.Visible                           := True;

  Circle                                   := TCircle.Create(Layout);
  Circle.Parent                            := Layout;
  Circle.Width                             := 15;
  Circle.Height                            := 15;
  Circle.Visible                           := True;
  Circle.Fill.Kind                         := TBrushKind.Solid;
  Circle.Fill.Color                        := $FF23FFE8;
  Circle.Stroke.Kind                       := TBrushKind.None;
  Circle.Position.X                        := 0;
  Circle.Position.Y                        := 0;

  LabelX                                   := TLabel.Create(Layout);
  LabelX.Parent                            := Layout;
  LabelX.Align                             := TAlignLayout.Bottom;
  LabelX.TextSettings.Font.Size            := 10;
  LabelX.TextSettings.FontColor            := TAlphaColorRec.White;
  LabelX.StyledSettings                    := LabelX.StyledSettings - [TStyledSetting.Size, TStyledSetting.FontColor];
  LabelX.Text                              := 'Aguarde';
  LabelX.TextSettings.HorzAlign            := TTextAlign.Center;
  LabelX.TextSettings.VertAlign            := TTextAlign.Center;

  //Animation
  Animation                                := TFloatAnimation.Create(Circle);
  Animation.Parent                         := Circle;
  Animation.StartValue                     := 0;
  Animation.StopValue                      := 110;
  Animation.Duration                       := 2;
  Animation.Loop                           := True;
  Animation.PropertyName                   := 'Position.X';
  Animation.AutoReverse                    := True;
  Animation.AnimationType                  := TAnimationType.InOut;
  Animation.Interpolation                  := TInterpolationType.Elastic;
  Animation.Loop                           := True;
  Animation.Start;

  ColorAnimation                           := TColorAnimation.Create(Circle);
  ColorAnimation.Parent                    := Circle;
  ColorAnimation.Loop                      := True;
  ColorAnimation.AutoReverse               := True;
  ColorAnimation.StartValue                := $FF23FFE8;
  ColorAnimation.StopValue                 := $FF0A03C4;
  ColorAnimation.Duration                  := 2;
  ColorAnimation.AnimationType             := TAnimationType.&In;
  ColorAnimation.Interpolation             := TInterpolationType.Linear;
  ColorAnimation.PropertyName              := 'Fill.Color';
  ColorAnimation.Start;

  //Show Controls
  Background.AnimateFloat('Opacity', 0.6);
  Layout.AnimateFloat('Opacity', 1);
  Layout.BringToFront;

  //Hide KeyBoard
  TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService,
                                                    IInterface(FService));
  if (FService <> nil) then
    FService.HideVirtualKeyboard;

  FService := nil;
end;


end.
