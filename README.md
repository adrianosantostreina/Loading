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

```delphi
procedure TForm5.Button1Click(Sender: TObject);
var
  LThread: TThread;
begin
  LThread :=
    TThread.CreateAnnonymousThread(
      procedure()
      begin
        TLoading.Show;
        //Your Code
        
        TThread.Synchronize(
          TThread.CurrentThread,
          procedure ()
          begin
            TLoading.Hide(Self);
          end;
        );
      end
    )
end;
```

## Documentation Languages
[English (en)](https://github.com/adrianosantostreina/Loading/blob/main/README.md)<br>
[Português (ptBR)](https://github.com/adrianosantostreina/Loading/blob/main/README-ptBR.md)<br>

## ⚠️ License
`Loading` is free and open-source library licensed under the [MIT License](https://github.com/adrianosantostreina/Loading/blob/main/LICENSE.md). 