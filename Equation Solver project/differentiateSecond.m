function [ value ] = differentiateSecond( func,x )
h=0.25;
xFirst=x+h;
xSecond=x+2*h;
xThird=x-h;
xFourth=x-2*h;
fcur=replaceByValue(func,x);
funcur=evaluateByValue(fcur);
f1=replaceByValue(func,xFirst);
fun1=evaluateByValue(f1);
f2=replaceByValue(func,xSecond);
fun2=evaluateByValue(f2);
f3=replaceByValue(func,xThird);
fun3=evaluateByValue(f3);
f4=replaceByValue(func,xFourth);
fun4=evaluateByValue(f4);
value=(-fun2+16*fun1-30*funcur+16*fun3-fun4);
value=value/(12*(h^2));
end

