unit Unit15;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, JsonDataObjects;

type
  TForm15 = class(TForm)
    edtFolder: TEdit;
    Button1: TButton;
    Memo1: TMemo;
    edtMask: TEdit;
    edtClassname: TEdit;
    Memo2: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    procedure GenerateHTMLLibrary;
    procedure ScanFolder(const aFolder: string; var aFileList: TStrings; const aMask: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form15: TForm15;

implementation

uses
  System.IOUtils;

{$R *.dfm}

procedure TForm15.Button1Click(Sender: TObject);
begin
  GenerateHTMLLibrary;
end;

procedure TForm15.ScanFolder(const aFolder: string; var aFileList: TStrings; const aMask: string);
var
  SR : TSearchRec;
begin
  if FindFirst(IncludeTrailingPathDelimiter(aFolder) + '*.*', faAnyFile, SR) = 0 then
    repeat
      if (SR.Attr AND faDirectory) = 0 then
      begin
        if TPath.GetExtension(SR.Name) = '.png' then
          aFileList.add( IncludeTrailingPathDelimiter(aFolder) + SR.Name )
      end
      else if (SR.Name <> '.') and (SR.Name <> '..') then
        ScanFolder( IncludeTrailingPathDelimiter(aFolder) + SR.Name, aFileList, aMask );
    until FindNext(SR) <> 0;
end;

procedure TForm15.GenerateHTMLLibrary;
var
  jParent, J, jFile : TJsonObject;
  JA, JA1 : TJsonArray;
  FileList: TStrings;
  JsonStrings: TStringList;
  I: Integer;
  aNewCat, aCategory: string;
  Counter : integer;
const
  C_IMG_FOLDER = 'img/';
  C_IMG_TAG = '<div class="%s"><img class="%s" src="%s" alt="%d" title="%s"></div>';

  function GetCssGridClass(const aItemNum: integer; const MaxCols: integer = 10): string;
  begin
    result := 'item' + IntToStr(((aItemNum) mod MaxCols) + 1);
  end;

begin
  JsonStrings := nil;
  FileList := TStringList.create;
  try

    ScanFolder(edtFolder.text, FileList, edtMask.text);

    if FileList.Count = 0 then
      ABORT;

    TStringList(FileList).Sort;

    JsonStrings := TStringList.Create;
    JsonStrings.AddStrings(FileList);
    for I := 0 to JsonStrings.Count-1 do
    begin
        // at this point we have a list of files with full path - and I need to strip the source folder
      JsonStrings[i] := StringReplace(JsonStrings[i], IncludeTrailingPathDelimiter(edtFolder.Text), '', [rfIgnoreCase]);
      // and fix fwd/backslash
      JsonStrings[i] := StringReplace(JsonStrings[i], '\', '/', [rfReplaceAll]);
    end;

    jsonStrings.Sort;
    // Zo, the JsonStrings are now in the format Database/24px/Large/filename.png
    // I need to get the first folder name as the "Category" name
    aCategory := '';

    Counter := 1;
    jParent := TJsonObject.Create;
    JA1 := TJsonArray.Create;
    for I := 0 to JsonStrings.Count-1 do
    begin
      aNewCat := JsonStrings[i].Substring(0, Pos('/', JsonStrings[I])-1);
      if aNewCat <> aCategory then
      begin
        Counter := 1;
        J := TJsonObject.Create;
        JA1.Add(J);
        J.S['category'] := aNewCat;
        ja := TJsonArray.Create;
        J.A['files'] := ja;
        aCategory := aNewCat;
      end;
      jFile := TJsonObject.create;
      jFile.S['fileName'] := C_IMG_FOLDER + JsonStrings[i];
      jFile.S['className'] := GetCssGridClass(counter);
      jFile.I['counter'] := counter;
      jFile.S['displayName'] := StringReplace(TPath.GetFileNameWithoutExtension(JsonStrings[i]), '-', ' ', [rfReplaceAll]);
      inc(Counter);
      JA.Add(jFile);
    end;
    jParent.A['icons'] := JA1;

    // I need to create a Json File with the info subdivided into

    for I := 0 to Filelist.Count-1 do
    begin
      FileList[i] := format(C_IMG_TAG, [GetCssGridClass(i), edtClassName.text, FileList[I], I + 1, TPath.GetFileNameWithoutExtension(FileList[I]), TPath.GetFileNameWithoutExtension(FileList[I]) ]);
      FileList[i] := StringReplace(FileList[i], edtFolder.text, C_IMG_FOLDER, [rfIgnoreCase]);
      FileList[i] := StringReplace(FileList[i], '\', '/', [rfReplaceAll]);
    end;

    memo1.lines.clear;
    memo1.lines.addstrings(FileList);

    memo2.lines.clear;
    memo2.lines.add(jParent.ToJSON(false));


  finally
    FileList.Free;
    JsonStrings.Free;
  end;
end;

end.
