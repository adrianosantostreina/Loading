<p align="center">
  <a href="https://github.com/adrianosantostreina/Loading/blob/main/image/logo.png">
    <img alt="Loading" src="https://github.com/adrianosantostreina/Loading/blob/main/image/logo.png">
  </a>
</p>

# Carregando
Esta classe destina-se a mostrar uma imagem de carregamento na tela do dispositivo.

## Instalação
Basta cadastrar no Library Path do seu Delphi o caminho da pasta SOURCE da biblioteca, ou se preferir, você pode usar o Boss (gerenciador de dependências do Delphi) para realizar a instalação:
```
chefe instale github.com/adrianosantostreina/Loading
```

## Usar
Declare Loading na seção Uses da unidade onde você deseja fazer a chamada para o método da classe.

```delphi
usar
   Carregando;
```

<ul>
  <li>Arraste um controle TButtom para o formulário</li>
  <li>Arraste um controle TTimer para o formulário*</li>
  <li>Defina a propriedade Enable como False no TTimer</li>
  <li>Codifique o evento OnClick do TButtom conforme abaixo</li>
  <li>Codifique o evento OnTimer do Ttimer conforme abaixo</li>
</ul>

*O uso de Timer neste exemplo é meramente didático, prefira usar TThreads ao invés de Timers

```delphi
procedimento TForm2.Button1Click(Remetente: TObject);
começar
  TLoading.Show('Carregando cliente...');
  Timer1.Enabled := Verdadeiro;
fim;

procedimento TForm2.Timer1Timer(Remetente: TObject);
começar
  TLoading.Hide;
  Timer1.Enabled := False;
fim;
```

Compile o projeto, execute-o e clique no botão Carregar.<br>
<p align="center">
  <img alt="Print" src="https://github.com/adrianosantostreina/Loading/blob/Sample/image/print.png">
</p>

## Alterar mensagens
Caso seja necessário modificar a mensagem durante a exibição do Loading, basta utilizar o método ChangeMessage passando a nova mensagem. Use o método Synchornize para isso.

<ul>
  <li>Arraste um novo controle TButtom para o formulário</li>
  <li>Arraste um novo controle TTimer para o formulário*</li>
  <li>Codifique o evento OnClick do TButtom conforme abaixo</li>
  <li>Codifique o evento OnTimer do Ttimer conforme abaixo</li>
</ul>

```delphi
[...]
  private
    LTime : Inteiro;
[...]

procedure TForm2.ChangeClick(Sender: TObject);
begin
  TLoading.Show('Carregando cliente...');
  Timer2.Enabled := True;
end;

[...]

procedure TForm2.Timer2Timer(Sender: TObject);
begin
  Inc(LTime);
  if LTime = 2 then
    TLoading.ChangeMessage('Carregando produtos...')
  else if LTime = 5 then
    TLoading.ChangeMessage('Carregando configurações...')
  else if LTime = 7 then
    TLoading.ChangeMessage('Terminando...')
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

## Personalizando o Círculo de Carga
Se você estiver interessado em modificar as cores de carregamento ou aumentar/diminuir o raio dos círculos, é perfeitamente possível**.

> ** Faça um backup do Loading.pas se quiser manter suas personalizações. Novas instalações e/ou atualizações através do Boss farão com que a unidade seja baixada com os valores padrão do nosso GitHub

Abra a unidade Loading.pas e encontre o método Show
```delphi
procedimento de classe TLoading.Show(const AMessage: string; AForm: TFMXObject = nil);
```

O método Show contém todo o código para criar os círculos em tempo de execução. Basta fazer ajustes onde quiser.
```delphi
  [...]
  //Arco menor (Inner Arc)
  ArcLoad.Stroke.Color := TAlphaColorRec.White;

  [...]
  //Arco maior (Arco Exterior)
  ArcLoadMaior.Stroke.Color := TAlphaColorRec.White;;
```

<p align="center">
  <img alt="Print" src="https://github.com/adrianosantostreina/Loading/blob/Sample/image/print2.png">
</p>



## Idiomas da documentação
[Inglês (en)](https://github.com/adrianosantostreina/Loading/blob/main/README.md)<br>
[Português (ptBR)](https://github.com/adrianosantostreina/Loading/blob/main/README-ptBR.md)<br>

## ⚠️ Licença
`Loading` é uma biblioteca gratuita e de código aberto licenciada sob a [Licença MIT](https://github.com/adrianosantostreina/Loading/blob/main/LICENSE.md).
