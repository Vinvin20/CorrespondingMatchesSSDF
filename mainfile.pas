unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  fpgn,frempl,fout,deleteng,frempldeb:textfile;
    lpgn,alpgn,derlpgn,lrempl,lrempldeb,nom,tempnom,proc,substrmatch:string;
    fin:string[5];
    Code , I: Integer;
    tempnbr,bourech1,bourech2,ntitre,emp,nblect,nbwh,ind,inddeb,bou,nbrempl,
    nbrempldeb,nbpart,nbnom,indbou,trouv,compt1,valrech,avalrech,nblgn,col:longint;
    rempsour,rempdebsour,rempdest,rempdebdest,nomeng,rechnom:array [0..20000] of string;
    nbpartnom,nbrechnom:array [0..20000] of longint;
    c:char;
    finfic,aff,finrempl,finrempldeb:boolean;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);

  procedure initfic;
begin
  AssignFile(fpgn,'e:\ratinglist\ssdf\long.txt');
  AssignFile(fout,'e:\ratinglist\ssdf\ssdfout.txt');
  rewrite(fout);
  reset(fpgn);
  end;


procedure init;
begin
initfic;
lpgn:='';
end;


procedure lect;
begin
   readln(fpgn,lpgn);
   inc(nblect);
   if (((nblect mod 20) = 0) and (nblect>0)) then Application.ProcessMessages;
   if  ((eof (fpgn)) {or (nblect>50 )}) then finfic:=true;
   end;


procedure fermer;
begin
   closefile (fpgn);closefile(fout)
   end;


begin
init;

repeat
   lect;
   if  LeftStr(lpgn,1)=' '
    then begin

            if (Pos('Q6600' , lpgn)>0) then begin
                                 Memo1.Lines.Add('------------- ');
                                 Memo1.Lines.Add('Q6600 2,4 GHz : '+lpgn);
                                 proc:='Q660'
                                 end

            else if (Pos(' 1200' , lpgn)>0) then begin
                                 Memo1.Lines.Add('------------- ');
                                 Memo1.Lines.Add('Athlon 1200 : '+lpgn);
                                 proc:='A1200'
                                 end

            else if (Pos(' 450' , lpgn)>0) then begin
                                 Memo1.Lines.Add('------------- ');
                                 Memo1.Lines.Add('K6-2 450 MHz : '+lpgn);
                                 proc:=' K6';
                                 end

            else if (Pos('P200' , lpgn)>0) then begin
                                 Memo1.Lines.Add('------------- ');
                                 Memo1.Lines.Add('P200 MMX : '+lpgn);
                                 proc:='P200';
                                 end

            else if (Pos(' 90 ' , lpgn)>0) then begin
                                 Memo1.Lines.Add('------------- ');
                                 Memo1.Lines.Add('Pentium 90 MHz : '+lpgn);
                                 proc:='P90';
                                 end
            else proc:='xyz';
         end
    else begin
            for col:=0 to 2 do begin
              substrmatch:= copy(lpgn,1+col*27,27);
              if (Pos(proc,substrmatch)) > 0
                then Memo1.Lines.Add(substrmatch);

            end;
          end ;

  {   writeln(fout, lpgn);   }
 until ((nblect>100000000) or (finfic));
fermer;
Memo1.Lines.Add('-----------------------');
Memo1.Lines.Add('Fin de fichier !!');

end;

end.
