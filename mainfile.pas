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
    lpgn,alpgn,derlpgn,lrempl,lrempldeb,nom,tempnom,proc,substrmatch,engine,score,score1,score2:string;
    fin:string[5];
    tempnbr,bourech1,bourech2,ntitre,emp,nblect,nbwh,ind,inddeb,bou,nbrempl,
    nbrempldeb,nbpart,nbnom,indbou,trouv,compt1,valrech,avalrech,nblgn,col,draw1,draw2,win1white,win1black,win2white,win2black:longint;
    score1num,score2num:Extended;
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
DecimalSeparator:=',';
end;



procedure lect;
begin
   readln(fpgn,lpgn);
   inc(nblect);
   if (((nblect mod 20) = 0) and (nblect>0)) then Application.ProcessMessages;
  { if nblect mod 100000 = 0 then write('*'); ('nblect : ', nblect,' ');}
   if  ((eof (fpgn)) or (nblect>50000 )) then finfic:=true;
   end;


procedure fermer;
begin
   closefile (fpgn);closefile(fout)
   end;

procedure masterdetails;
begin
Memo1.Lines.Add('------------- ');
Memo1.Lines.Add(lpgn);

   end;

begin
init;

repeat
   lect;
   if  LeftStr(lpgn,1)=' '
    then begin

            if (Pos('Q6600' , lpgn)>0) then begin
                                 masterdetails;
                                 {Memo1.Lines.Add('Q6600 2,4 GHz : '+lpgn); }
                                 proc:='Q660'
                                 end

            else if (Pos(' 1200' , lpgn)>0) then begin
                                masterdetails;
                               {  Memo1.Lines.Add('Athlon 1200 : '+lpgn);  }
                                 proc:='A1200'
                                 end

            else if (Pos(' 450' , lpgn)>0) then begin
                                 masterdetails;
                               {  Memo1.Lines.Add('K6-2 450 MHz : '+lpgn);}
                                 proc:=' K6';
                                 end

            else if (Pos('P200' , lpgn)>0) then begin
                                masterdetails;
                               {  Memo1.Lines.Add('P200 MMX : '+lpgn);   }
                                 proc:='P200';
                                 end

            else if (Pos(' 90 ' , lpgn)>0) then begin
                                 masterdetails;
                              {   Memo1.Lines.Add('Pentium 90 MHz : '+lpgn); }
                                 proc:='P90';
                                 end
            else proc:='xyz';
           { Memo1.Lines.Add('proc : '+proc);  }
         end
    else begin
            for col:=0 to 2 do begin
              substrmatch:= copy(lpgn,1+col*27,27);
             { Memo1.Lines.Add('Rech : '+proc+' dans ' + substrmatch +' '+inttostr(Pos(proc,substrmatch)));  }
              if (Pos(proc,substrmatch)) > 0
                then begin
                       { Memo1.Lines.Add(substrmatch);}
                        engine:= leftstr(substrmatch,15);
                        score:= copy(substrmatch,16,20);

                        score1:= trimleft(copy(score, 1, pos('-', score)-1));
                        score2:= trimright( copy(score, pos('-', score)+1 , 20));

                        score1num:=StrToFloat(score1);
                        score2num:=StrToFloat(score2);

                        if score1num <> trunc(score1num) then draw1:=1 else draw1:=0 ;
                        win1white:=(round(score1num) div 2);
                        win1black:= (round(score1num)-win1white) div 2;
                        draw1:= draw1 + (trunc(score1num) - win1white - win1black)*2 ;

                        if score2num <> trunc(score2num) then draw2:=1 else draw2:=0;
                        win2white:=(round(score2num) div 2);
                        win2black:= (round(score2num)-win2white) div 2 ;
                        draw2:= draw2 + (trunc(score2num) - win2white - win2black)*2 ;


                        Memo1.Lines.Add(engine+', score : '+score+' '+score1+' à '+score2+' w'+inttostr(win1white)+' b'+inttostr(win1black)+' ='+inttostr(draw1)+' (w'+inttostr(win2white)+' b'+inttostr(win2black)+' ='+inttostr(draw2)+')');
                     end;
                end;

            end;

  {   writeln(fout, lpgn);   }
 until ((nblect>100000000) or (finfic));
fermer;
Memo1.Lines.Add('-----------------------');
Memo1.Lines.Add('Fin de fichier !!');
{writeln;
write ('- nbpart:',nbpart div 2,'  nblgn:',nblect,'  Nb eng:',nbnom,' -');
 writeln ('END !!!');}


end;

end.
