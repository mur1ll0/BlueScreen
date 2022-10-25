unit uBS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TfrmBS = class(TForm)
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure BlockShortcuts;
  public
    { Public declarations }
  end;

var
  frmBS: TfrmBS;

implementation

{$R *.dfm}

function BlockInput(ABlockInput: boolean): Boolean; stdcall;
  external 'USER32.DLL';

procedure TfrmBS.BlockShortcuts;
var
  OldValue : LongBool;
begin
  {liga a trava}
  SystemParametersInfo(97, Word(True), @OldValue, 0);
  {desliga a trava}
  SystemParametersInfo(97, Word(False), @OldValue, 0);
end;

procedure TfrmBS.FormCreate(Sender: TObject);
begin
  BorderStyle := bsNone;
  frmBS.Top := 0;
  frmBS.Left := 0;
  frmBS.Width := Screen.Width;
  frmBS.Height := Screen.Height;
  BlockShortcuts;
  BlockInput(True);
end;

end.
