unit uPrinc;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Winapi.TlHelp32,
  JvComponentBase, JvTrayIcon;

type
  TfrmPrinc = class(TForm)
    Timer1: TTimer;
    JvTrayIcon1: TJvTrayIcon;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    timercombo: Integer;
  end;

var
  frmPrinc: TfrmPrinc;

implementation

{$R *.dfm}

uses
  uBS;

//Matar processo pelo nome
function KillTask(ExeFileName: string): Integer;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  Result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);

  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(ExeFileName))) then
      Result := Integer(TerminateProcess(
                        OpenProcess(PROCESS_TERMINATE,
                                    BOOL(0),
                                    FProcessEntry32.th32ProcessID),
                                    0));
     ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

procedure TfrmPrinc.FormCreate(Sender: TObject);
begin
  timercombo := 0;
  Timer1.Enabled := True;

  SetCursorPos(20000, 20000); //set cursor to Start menu coordinates
  Application.CreateForm(TfrmBS, frmBS);
  frmBS.ShowModal;
end;

procedure TfrmPrinc.Timer1Timer(Sender: TObject);
begin
  if timercombo = 0 then
  begin
    frmBS.Image1.Visible := False;
    timercombo := 1;
  end
  else
    KillTask('WinDefBS.exe');
end;

end.
