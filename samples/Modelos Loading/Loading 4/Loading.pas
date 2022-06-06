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
    class var ArcLoad         : TArc;
    class var MessageLoad     : TLabel;
    class var Animation       : TFloatAnimation;
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

    if Assigned(ArcLoad) then
    ArcLoad.DisposeOf;

    if Assigned(Background) then
      Background.DisposeOf;

    if Assigned(Layout) then
      Layout.DisposeOf;

    except

    end;
  end;

  MessageLoad := nil;
  Animation   := nil;
  ArcLoad     := nil;
  Layout      := nil;
  Background  := nil;
end;

class procedure TLoading.Show(const AForm : TForm; const AMessage: string);
var
  FService: IFMXVirtualKeyboardService;
begin
  //BackGround
  Background                               := TRectangle.Create(AForm);
  Background.Opacity                       := 0;
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

  Circle                                   := TCircle.Create(AForm);
  Circle.Parent                            := Layout;
  Circle.Width                             := 60;
  Circle.Height                            := 60;
  Circle.Visible                           := True;
  Circle.Fill.Kind                         := TBrushKind.Solid;
  Circle.Fill.Color                        := TAlphaColorRec.Black;
  Circle.Opacity                           := 0.6;
  Circle.Stroke.Kind                       := TBrushKind.None;
  Circle.Align                             := TAlignLayout.Center;

  LabelX                                   := TLabel.Create(Circle);
  LabelX.Parent                            := Circle;
  LabelX.Align                             := TAlignLayout.Center;
  LabelX.Width                             := 75;
  LabelX.TextSettings.Font.Size            := 10;
  LabelX.TextSettings.FontColor            := TAlphaColorRec.White;
  LabelX.StyledSettings                    := LabelX.StyledSettings - [TStyledSetting.Size, TStyledSetting.FontColor];
  LabelX.Text                              := 'Aguarde';
  LabelX.TextSettings.HorzAlign            := TTextAlign.Center;
  LabelX.TextSettings.VertAlign            := TTextAlign.Center;
  LabelX.BringToFront;


  //Arco Menor
  ArcLoad                                  := TArc.Create(Circle);
  ArcLoad.Opacity                          := 1;
  ArcLoad.Visible                          := true;
  ArcLoad.Parent                           := Circle;
  ArcLoad.Align                            := TAlignLayout.Center;
  ArcLoad.Margins.Bottom                   := 55;
  ArcLoad.Width                            := 60;
  ArcLoad.Height                           := 60;
  ArcLoad.EndAngle                         := 280;
  ArcLoad.Stroke.Color                     := $FFFEFFFF;
  ArcLoad.Stroke.Thickness                 := 3;
  ArcLoad.Position.X                       := Trunc((Circle.Width - ArcLoad.Width) / 2);
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

  //Show Controls
  Background.AnimateFloat('Opacity', 0.0);
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
