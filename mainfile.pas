unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,math ,
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
    lpgn,alpgn,derlpgn,lout,lrempl,lrempldeb,nom,tempnom,proc,substrmatch,engine,score,score1,score2,nomeng:string;
    fin:string[5];
    tempnbr,bourech1,bourech2,ntitre,emp,nblect,nbwh,ind,inddeb,bou,nbrempl, draw , wbdiff  ,
    nbrempldeb,nbpart,nbnom,indbou,trouv,compt1,valrech,avalrech,nblgn,col,draw1,draw2,win1white,win1black,win2white,win2black:longint;
    score1num,score2num,resumutu:Extended;
    rempsour,rempdebsour,rempdest,rempdebdest,rechnom:array [0..20000] of string;
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
   if ((nblect mod 100) = 0) then Application.ProcessMessages;
  { if nblect mod 100000 = 0 then write('*'); ('nblect : ', nblect,' ');}
   if  ((eof (fpgn)) {or (nblect>50)}) then finfic:=true;
   end;


procedure fermer;
begin
   closefile (fpgn);closefile(fout)
   end;

procedure masterdetails;
begin
{Memo1.Lines.Add('------------- ');   }
Memo1.Lines.Add(lpgn);
nomeng:= copy (lpgn , 2 , 100 );
for bou:=1 to 4 do
   if (((nomeng [1]>='0') and (nomeng[1]<='9')) or (nomeng [1]=' ')) then nomeng:= copy (nomeng , 2 , 100 );

for bou:=1 to 7 do
   if (((nomeng [length(nomeng)]>='0') and (nomeng[length(nomeng)]<='9')) or (nomeng [length(nomeng)]=' ')) then nomeng:= copy (nomeng , 1 , length(nomeng)-1 );

   if (nomeng [length(nomeng)]=',') then nomeng:= copy (nomeng , 1 , length(nomeng)-1 );
   nomeng:='Master : '+nomeng;
Memo1.Lines.Add(nomeng);
{Application.ProcessMessages;  }
   end;

procedure ecrirepgn;
begin

for bou:=1 to win1white  do
   begin
    lout:= '[White "'+nomeng+'"]';
    writeln(fout, lout);
    lout:= '[Black "'+engine+'"]';
    writeln(fout, lout);
    lout:='[Result "1-0"]';
    writeln(fout, lout);
    lout:='1-0';
    writeln(fout, lout);
    lout:=' ';
    writeln(fout, lout);
   end;

for bou:=1 to win1black do
   begin
    lout:= '[White "'+engine+'"]';
    writeln(fout, lout);
    lout:= '[Black "'+nomeng+'"]';
    writeln(fout, lout);
    lout:='[Result "0-1"]';
    writeln(fout, lout);
    lout:='0-1';
    writeln(fout, lout);
    lout:=' ';
    writeln(fout, lout);
   end;

for bou:=1 to draw1 do
   begin
    lout:= '[White "'+engine+'"]';
    writeln(fout, lout);
    lout:= '[Black "'+nomeng+'"]';
    writeln(fout, lout);
    lout:='[Result "1/2-1/2"]';
    writeln(fout, lout);
    lout:='1/2-1/2';
    writeln(fout, lout);
    lout:=' ';
    writeln(fout, lout);
   end;


for bou:=1 to win2white  do
   begin
    lout:= '[White "'+engine+'"]';
    writeln(fout, lout);
    lout:= '[Black "'+nomeng+'"]';
    writeln(fout, lout);
    lout:='[Result "1-0"]';
    writeln(fout, lout);
    lout:='1-0';
    writeln(fout, lout);
    lout:=' ';
    writeln(fout, lout);
   end;

for bou:=1 to win2black do
   begin
    lout:= '[White "'+nomeng+'"]';
    writeln(fout, lout);
    lout:= '[Black "'+engine+'"]';
    writeln(fout, lout);
    lout:='[Result "0-1"]';
    writeln(fout, lout);
    lout:='0-1';
    writeln(fout, lout);
    lout:=' ';
    writeln(fout, lout);
   end;

for bou:=1 to draw2 do
   begin
    lout:= '[White "'+engine+'"]';
    writeln(fout, lout);
    lout:= '[Black "'+nomeng+'"]';
    writeln(fout, lout);
    lout:='[Result "1/2-1/2"]';
    writeln(fout, lout);
    lout:='1/2-1/2';
    writeln(fout, lout);
    lout:=' ';
    writeln(fout, lout);
   end;


end;

begin
init;

repeat
   lect;
   {Application.ProcessMessages; }
   if  LeftStr(lpgn,1)=' '
    then begin
            masterdetails;
          {  Memo1.Lines.Add(' New engine '+lpgn); }
           {
            if (Pos('Q6600' , lpgn)>0) then begin
                                 masterdetails;
                                 {Memo1.Lines.Add('Q6600 2,4 GHz : '+lpgn); }
                                 proc:='Q660'
                                 end

            else if (Pos('1200' , lpgn)>0) then begin
                                masterdetails;
                               {  Memo1.Lines.Add('Athlon 1200 : '+lpgn);  }
                                 proc:='1200'
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
            else } proc:='xyz';
           { Memo1.Lines.Add('proc : '+proc);  }
         end
    else if Length(lpgn)>20 then begin
            for col:=0 to 2 do begin
              substrmatch:= copy(lpgn,1+col*27,27);
             { Memo1.Lines.Add('Rech : '+proc+' dans ' + substrmatch +' '+inttostr(Pos(proc,substrmatch)));  }
              if {(Pos(proc,substrmatch)) > 0 } Length(substrmatch)>15
                then begin
                       { Memo1.Lines.Add(substrmatch);}
                        engine:=trimleft(trimright(leftstr(substrmatch,15)));
                        score:= copy(substrmatch,16,20);

                        score1:= trimleft(copy(score, 1, pos('-', score)-1));
                        score2:= trimright(copy(score, pos('-', score)+1 , 20));

                        score1num:=StrToFloat(score1);
                        score2num:=StrToFloat(score2);

                        resumutu:= (min(trunc(score1num*10),trunc(score2num*10)))/10;
                        draw:=trunc(sqrt(resumutu)*2+0.5);

                        if ((score1num+draw/2) <> (trunc(score1num+draw/2))) then draw:=draw+1;

                        score1num:=score1num-(draw/2);
                        score2num:=score2num-(draw/2);

                        win1white:=trunc(score1num*0.55+0.3);
                        win1black:= trunc(score1num)-win1white;

                        win2white:=trunc(score2num*0.55+0.3);
                        win2black:=trunc(score2num)-win2white;

                        wbdiff:= win1white + win2black - win1black - win2white;

                        draw1:=trunc(draw/2+0.5)-wbdiff;
                        draw1:=max(0,draw1);
                        draw1:=min(draw,draw1);
                        draw2:=draw-draw1;

                     if (nblect mod 1)=0  then Memo1.Lines.Add(engine+', score : '+score+'            '+score1+'-'+score2+' : w'+inttostr(win1white)+' b'+inttostr(win1black)+' ='+inttostr(draw1)+' (w'+inttostr(win2white)+' b'+inttostr(win2black)+' ='+inttostr(draw2)+')');
                       { Memo1.Lines.Add('wbdiff : ' +inttostr(wbdiff));}
                        ecrirepgn;

                     end;
                end;

            end;

  {  writeln(fout, lpgn); }
 until ((nblect>100000000) or (finfic));
fermer;
Memo1.Lines.Add('-----------------------');
Memo1.Lines.Add('Fin de fichier !!');
{writeln;
write ('- nbpart:',nbpart div 2,'  nblgn:',nblect,'  Nb eng:',nbnom,' -');
 writeln ('END !!!');}


end;

end.
