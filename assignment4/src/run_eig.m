clc, clear all

A = rand(2,2);
A(1,2) = A(2,1);
a = A(1,1);
b = A(1,2);
c = A(2,2);

tic
D = sqrt(a^2 + 4*b^2 - 2*a*c + c^2);
e1 = (a + c - D)/2
e2 = (a + c + D)/2
toc
tic
eig(A)
toc
