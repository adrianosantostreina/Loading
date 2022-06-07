<p align="center">
  <a href="https://github.com/adrianosantostreina/Loading/blob/main/image/logo.png">
    <img alt="Loading" src="https://github.com/adrianosantostreina/Loading/blob/main/image/logo.png">
  </a>  
</p>

# Loading
This class was built to make it easy to load images and thumbnails using the file's URL.

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
```

## Documentation Languages
[English (en)](https://github.com/adrianosantostreina/Loading/blob/main/README.md)<br>
[Português (ptBR)](https://github.com/adrianosantostreina/Loading/blob/main/README-ptBR.md)<br>

## ⚠️ License
`Loading` is free and open-source library licensed under the [MIT License](https://github.com/adrianosantostreina/Loading/blob/main/LICENSE.md). 