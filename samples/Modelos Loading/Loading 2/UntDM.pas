unit UntDM;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,

  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs,
  FireDAC.FMXUI.Wait,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,

  System.IOUtils;

type
  TDM = class(TDataModule)
    fdConn: TFDConnection;
    QryCidades: TFDQuery;
    QryCidadesCID_ID: TFDAutoIncField;
    QryCidadesCID_CODIBGE: TIntegerField;
    QryCidadesCID_NOME: TStringField;
    QryCidadesCID_LATITUDE: TFMTBCDField;
    QryCidadesCID_LONGITUDE: TFMTBCDField;
    QryCidadesCID_CAPITAL: TBooleanField;
    QryCidadesCID_ESTADO: TIntegerField;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    procedure fdConnBeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDM.fdConnBeforeConnect(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
    fdConn.Params.Values['Database'] := '$(DB_TESTE)';
  {$ELSE}
    fdConn.Params.Values['OpenMode'] := 'ReadWrite';
    fdConn.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'cpvendas.db');
  {$ENDIF}
end;

end.
