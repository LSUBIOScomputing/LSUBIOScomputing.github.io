/*Computing club Presentation*/
    /*September 14th 2015*/

/*Part I - String and Empty matrices*/
proc iml;
A={1 2 3, 4 5 6};
B=j(2,3,.);
C=shape(.,2,3);
D=shape(A,3,2);
E=shapecol(A,3,2);
F=shapecol(A,0,1);
G={"a" "b" "c", "d" "e" "f"};
H=shape(" ",2,3);
print A B C D E F G H;
t=type(H);
print t;
run; quit;

/*Part II - IML Modules*/
%Macro Module;               *Module with output;
start my_mean(X);
M=mean(X)-sum(X)/sum(n(X));
return(M);
finish my_mean;
%mend Module;

proc iml;
A={1 2 3, 4 5 6};
print A;
%Module;
L=my_mean(A);
print 'Adjusted column means are' L;
run; quit;

%Macro Module;               *Module without output;
start my_mean(X);
M=mean(X);
print 'Adjusted column means are' M;
finish my_mean;
%mend Module;

proc iml;
A={1 2 3, 4 5 6};
print A;
%Module;
call my_mean(A);
run; quit;

%Macro Module;               *Module with output to a dataset;
start my_mean(X);
 M=mean(X);
 Mean_Names="Mean 1"||"Mean 2"||"Mean 3";
 create Mean_Data from M [colname=Mean_Names];
 append from M;
 close Mean_Data;
finish my_mean;
%mend Module;

proc iml;
A={1 2 3, 4 5 6, 7 8 9, 10 11 12};
print A;
%Module;
call my_mean(A);
run; quit;

/*Part III - Do loop*/
proc iml;
count=0; vector=j(10,1,.);
do i=1 to 10;                *loop without macro variable;
count=count+i;
vector[i]=count;
end;
print count vector;
run; quit;

%Macro Module;               *Module without output;
start my_mean(X);
M=mean(X);
print 'Adjusted column means are' M;
finish my_mean;
%mend Module;

proc iml;
A={1 2 3, 4 5 6, 7 8 9, 10 11 12};
B={5 6 7, 8 9 10, 4 5 6, 8 9 9};
C={12 13 14, 8 9 10, 15 16 17, 18 18 18};
D={7 8 9, 18 19 19, 15 16 17, 18 19 19};
%Module;
call my_mean(A);
call my_mean(B);
call my_mean(C);
call my_mean(D);
M1={1 2 3, 4 5 6, 7 8 9, 10 11 12};            *This is not gonna work, we need macro variable!;
M2={5 6 7, 8 9 10, 4 5 6, 8 9 9};
M3={12 13 14, 8 9 10, 15 16 17, 18 18 18};
M4={7 8 9, 18 19 19, 15 16 17, 18 19 19};
do i=1 to 4;
call my_mean(Mi);
end;
run; quit;

/*Part IV - Macro variables*/
%let rep=3;
proc iml;
count=0;
do i=1 to &rep;                *loop with macro variable;
count=count+i;
end;
print count;
run; quit;

proc iml;
content=&rep+1;
print &rep content;
%let rep2=%eval(&rep+1);
print &rep2;
A={"Var1 Var2 Var3 Var4", "Var2 Var3 Var4 Var5", "Var1 Var3 Var4 Var5", "Var1 Var2 Var4 Var5", "Var1 Var2 Var3 Var5"};
print A;
_nrow_=nrow(A);
call symput('nrow',char(_nrow_,6,0));
print &nrow;
%put &=nrow;
%put This matrix has &nrow rows;

one_line=A[1,];
print one_line;
do i=1 to &nrow;
Vars=A[i];
%let row=i;
print &row Vars;
end;

do i=1 to &nrow;
Vars=A[i];
%let Vars=Vars;
print i &Vars;
end;
print &Vars;
call symput('Var',Vars);
print &Var &Vars;            *&Vars's not gonna be printed;
run; quit;
%put &=Var &=Vars;           *Better way how to print macro variables;

/*Part V - Macro and Macro Loop*/
/*Calculating column means and grand mean from datasets saved in files*/
%macro Loop(Path,List);
data Test;
infile "&Path";
input &List;
run;

proc iml;
use Test;
read all into Data[colname=names];
close Test;
Grand_mean=sum(Data)/sum(n(Data));
means=mean(Data);
print 'Grand mean is ' Grand_mean ' and column means are ' means;
run; quit;
%mend;

%Loop(Path=C:\Users\bios\Desktop\Data1.txt,List=&Var);

%macro Loop(List);
%do i=1 %to &rep;
data Test&i;
infile "C:\Users\bios\Desktop\Data&i..txt";
input &List;
run;

proc iml;
use Test&i;
read all into Data[colname=names];
close Test&i;
Grand_mean=sum(Data)/sum(n(Data));
means=mean(Data);
title 'Matrix' &i;
print 'Grand mean is ' Grand_mean ' and column means are ' means;
run; quit;
%end;
%mend;

%Loop(List=&Var);
