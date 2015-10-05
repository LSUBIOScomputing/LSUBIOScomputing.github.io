proc iml;
are = {1 2 3, 3 2 1, -1 -2 3};
we = j(3,3,1);
having = i(3);
fun = repeat(1:3,3,1);
yet = {"one","two","three"}; 
print are we having fun yet;

five = are[3,3];
words = we[1:2,];
in = having[,{1 3}];
my = fun<3;
head = yet[loc(yet = "two")];
print five words in my head;

walking = are*we + having;
ina = having#fun;
spider = having@are;
web = fun##2;
print walking ina spider web;

give = colvec(we);
it = give||the;
away = t(1||rowvec(fun));
print give it away;

zeroes = j(4,1,0);
call randgen(zeros,"normal",0,1);
call randgen(zeroes,"normal",0,1);
print zeros zeroes;

go = "true";
ct = 0;
do while(go="true");
call randgen(value, "uniform");
if(value >= 0.5) then go = "false";
ct = ct+1; 
end;
print ct;

start test(x,y);
mx = mean(x);
my = mean(y);
vx = var(x);
vy = var(y);
nx = nrow(x);
ny = nrow(y);
sp = sqrt(((nx-1)*vx + (ny-1)*vy)/(nx+ny-2));
z = (mx-my)/sp;
if (abs(z) >= 1.96) then result = "Gotta keep em separated";
else result = "Come together, right now"; 
print result;
finish test;

trouble1 = j(10,1,0);
trouble2 = trouble1;
call randgen(trouble1,"normal",6,1);
call randgen(trouble2,"normal",0,1);
run test(trouble1,trouble2);

thisjunk = trouble1||trouble2;
name = {'Jon','Jacob'};
create amasterpiece from thisjunk[colname=name];
append from thisjunk;

use thisjunk;
read all into thatjunk;
close thisjunk;

print thatjunk;
quit;
