<p align="center">
  <a href="https://github.com/adrianosantostreina/Loading/blob/main/image/logo.png">
    <img alt="Loading" src="https://github.com/adrianosantostreina/Loading/blob/main/image/logo.png">
  </a>  
</p>

# Loading
This class is intended to show a Loading image on the device's screen.

## Installation
Just register in the Library Path of your Delphi the path of the SOURCE folder of the library, or if you prefer, you can use Boss (dependency manager for Delphi) to perform the installation:
```
boss install github.com/adrianosantostreina/Loading
```

## Use
Use
Declare Loading in the Uses section of the unit where you want to make the call to the class's method.
```delphi
use
   Loading;
```

<ul>
  <li>Drag a TButtom control onto the Form</li>
  <li>Drag a TTimer control onto the Form*</li>
  <li>Set Enable property to False in TTimer</li>
  <li>Code TButtom's OnClick event as below</li>
  <li>Code Ttimer's OnTimer event as below</li>
</ul>

*The use of Timer in this example is merely didactic, prefer to use TThreads instead of Timers

```delphi
procedure TForm2.Button1Click(Sender: TObject);
begin
  TLoading.Show('Loading customer...');
  Timer1.Enabled := True;
end;

procedure TForm2.Timer1Timer(Sender: TObject);
begin
  TLoading.Hide;
  Timer1.Enabled := False;
end;
```

Compile the project, run it and click the Load button.<br>
<p align="center">
  <img alt="Print" src="https://github.com/adrianosantostreina/Loading/blob/Sample/image/print.png">
</p>  

## Change Messaging
If you need to modify the message during the display of Loading, just use the ChangeMessage method passing the new message. Use the Synchornize method for this.

<ul>
  <li>Drag a new TButtom control onto the Form</li>
  <li>Drag a new TTimer control onto the Form*</li>
  <li>Code TButtom's OnClick event as below</li>
  <li>Code Ttimer's OnTimer event as below</li>
</ul>

```delphi
[...]
  private
    LTime : Integer;
[...]

procedure TForm2.ChangeClick(Sender: TObject);
begin
  TLoading.Show('Loading customer...');
  Timer2.Enabled := True;
end;

[...]

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
```

<p align="center">
  <img alt="Print" src="https://github.com/adrianosantostreina/Loading/blob/Sample/image/print3.png">
  <img alt="Print" src="https://github.com/adrianosantostreina/Loading/blob/Sample/image/print4.png">
</p>  

## Customizing the Load Circle
If you are interested in modifying the Loading colors or increasing/decreasing the radius of the circles, it is entirely possible**.

> ** Make a backup of Loading.pas if you want to keep your customizations. New installations and/or updates through Boss will cause the unit to be downloaded with the default values from our GitHub

Open the Loading.pas unit and find the Show method
```delphi
class procedure TLoading.Show(const AMessage: string; AForm: TFMXObject = nil);
```

The Show method contains all the code to create the circles at runtime. Just make adjustments where you want.
```delphi
  [...]
  //Arco menor (Inner Arc)
  ArcLoad.Stroke.Color                     := TAlphaColorRec.White;

  [...]
  //Arco maior (Outer Arc)
  ArcLoadMaior.Stroke.Color                := TAlphaColorRec.White;;
```

<p align="center">
  <img alt="Print" src="https://github.com/adrianosantostreina/Loading/blob/Sample/image/print2.png">
</p>



## Documentation Languages
[English (en)](https://github.com/adrianosantostreina/Loading/blob/main/README.md)<br>
[Português (ptBR)](https://github.com/adrianosantostreina/Loading/blob/main/README-ptBR.md)<br>

## ⚠️ License
`Loading` is free and open-source library licensed under the [MIT License](https://github.com/adrianosantostreina/Loading/blob/main/LICENSE.md). 