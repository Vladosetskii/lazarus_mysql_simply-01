unit Unit1; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, mysql50conn, sqldb, db, FileUtil, LResources, Forms,
  Controls, Graphics, Dialogs, DBGrids, StdCtrls, ComCtrls, DbCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button5: TButton;
    Datasource1: TDatasource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    MySQL50Connection1: TMySQL50Connection;
    PageControl1: TPageControl;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form1: TForm1; 

implementation

var
   num_sql : Integer;

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
    str_sql : string;
begin
// Connect...1111
 try
   MySQL50Connection1.Connected:=true;
 except
   ShowMessage(' Не могу подключиться к базе данных');
   exit;
 end;

// Transaction...
 try
   SQLTransaction1.Active:=true;
 except
   ShowMessage(' Не могу создать транзакцию');
   exit;
 end;

 // SQL... (1)
  try
   SQLQuery1.Active := false;
   SQLQuery1.SQL.Clear;
   str_sql := 'SET character_set_client='+#39+'utf8'+#39+',character_set_connection='+#39+'cp1251'+#39+',character_set_results='+#39+'utf8'+#39+';';
   SQLQuery1.sql.add(str_sql);
   SQLQuery1.ExecSQL;
   SQLQuery1.SQL.Clear;
  except
   ShowMessage(' Ошибка при выполнении SQL запроса.');
   exit;
 end;

end;

// Transaction
procedure TForm1.Button2Click(Sender: TObject);
var
    str_sql : string;
begin
 DBEdit1.DataField := '';
 DBEdit2.DataField := '';
  try
   SQLQuery1.Active := false;
   SQLQuery1.SQL.Clear;
   str_sql := Memo1.Lines.Text;
   Memo1.Clear;
   Inc(num_sql);
   Memo2.Lines.Append(IntToStr(num_sql) + ') ' + str_sql);
   SQLQuery1.sql.add(str_sql);
//   SQLQuery1.sql.add('SELECT * FROM student;');
   SQLQuery1.Open;
  except
   ShowMessage(' Ошибка при выполнении SQL запроса.');
   exit;
 end;
end;

// SQL: student
procedure TForm1.Button3Click(Sender: TObject);
var
    str_sql : string;
begin
  try
   SQLQuery1.Active := false;
   SQLQuery1.SQL.Clear;
   str_sql := 'SELECT * FROM student;';
   SQLQuery1.sql.add(str_sql);
   SQLQuery1.Open;
   DBEdit1.DataField := 'student_id';
   DBEdit2.DataField := 'name';
  except
   ShowMessage(' Ошибка при выполнении SQL запроса!!!');
   exit;
 end;
end;

initialization
  {$I unit1.lrs}
    num_sql := 0;

end.

