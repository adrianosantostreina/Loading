unit Loading;

interface

uses
  System.SysUtils,
  System.UITypes,
  System.Classes,
  System.SyncObjs,

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
    class var FCriSection: TCriticalSection;
    class procedure OnNewKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
  public
    class constructor OnCreate;
    class destructor OnDestroy;

    class procedure Show(const AMessage : string; AForm: TFMXObject = nil);
    class procedure Hide(const AForm: TForm);
    class procedure ChangeText(ANewText: string); static;
end;

implementation

{ TLoading }

class constructor TLoading.OnCreate;
begin
  FCriSection := TCriticalSection.Create;
end;

class destructor TLoading.OnDestroy;
begin
  if Assigned(FCriSection) then
  begin
    FCriSection.Enter;
    FCriSection.Leave;
  end;
  FreeAndNil(FCriSection);
end;

class procedure TLoading.Hide(const AForm: TForm);
begin
  FCriSection.Enter;
  try
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

    if Assigned(Application.MainForm) and Assigned(KeyUp) then
      Application.MainForm.OnKeyUp := KeyUp;
  finally
    FCriSection.Leave;
  end;
end;

class procedure TLoading.OnNewKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkHardwareBack then
    Key := 0;
end;

class procedure TLoading.Show(const AMessage: string; AForm: TFMXObject = nil);
var
  FService: IFMXVirtualKeyboardService;
begin
  FCriSection.Enter;
  try
    if AForm = nil then
      AForm := Application.MainForm;

    KeyUp                                    := Application.MainForm.OnKeyUp; // Guardo o evento antigo
    Application.MainForm.OnKeyUp             := OnNewKeyUp;    // Passo para ele um novo evento
    //BackGround
    Background                               := TRectangle.Create(AForm);
    Background.Opacity                       := 0.6;
    Background.Fill.Color                    := $FF049A04;
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
    ArcLoad.Stroke.Color                     := TAlphaColorRec.White;;
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
    ArcLoadMaior.Stroke.Color                := TAlphaColorRec.White;;
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
    MessageLoad.Width                        := Application.MainForm.Width - 100;
    MessageLoad.FontColor                    := TAlphaColorRec.White;;
    MessageLoad.TextSettings.HorzAlign       := TTextAlign.Center;
    MessageLoad.TextSettings.VertAlign       := TTextAlign.Leading;
    MessageLoad.StyledSettings               := [TStyledSetting.Family, TStyledSetting.Style];
    MessageLoad.Text                         := AMessage;
    MessageLoad.VertTextAlign                := TTextAlign.Leading;
    MessageLoad.Trimming                     := TTextTrimming.None;
    MessageLoad.TabStop                      := False;
    MessageLoad.SetFocus;

    //Show Controls
    Background.AnimateFloat('Opacity', 0.4);
    Layout.AnimateFloat('Opacity', 1);
    Layout.BringToFront;

    //Hide KeyBoard
    TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));
    if (FService <> nil) then
      FService.HideVirtualKeyboard;

    FService := nil;
  finally
    FCriSection.Leave;
  end;
end;

class procedure TLoading.ChangeText(ANewText: string);
begin
  FCriSection.Enter;
  try
    if Assigned(Layout) then
    begin
      try
        if Assigned(MessageLoad) then
          MessageLoad.Text := ANewText;
      except
      end;
    end;
  finally
    FCriSection.Leave;
  end;
end;


end.
