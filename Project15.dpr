program Project15;

uses
  Vcl.Forms,
  Unit15 in 'Unit15.pas' {Form15},
  JsonDataObjects in 'D:\Components\JsonDataObjects\Source\JsonDataObjects.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm15, Form15);
  Application.Run;
end.
