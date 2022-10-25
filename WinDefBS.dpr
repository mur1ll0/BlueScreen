program WinDefBS;

uses
  Vcl.Forms,
  uPrinc in 'uPrinc.pas' {frmPrinc},
  uBS in 'uBS.pas' {frmBS};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrinc, frmPrinc);
  Application.ShowMainForm := False;
  Application.Run;
end.
