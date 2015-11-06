function [arr1,arr2,arr3,eq] = read()
 fid1 = fopen('arr1.txt','r');
 arr1 = fscanf(fid1,'%f');
 fid2 = fopen('arr2.txt','r');
 arr2 = fscanf(fid2,'%f');
 fid3 = fopen('arr3.txt','r');
 arr3 = fscanf(fid3,'%f');
 fid4 = fopen('eq.txt','r');
 eq = fscanf(fid4,'%s');

end