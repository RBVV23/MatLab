clc
clear all
close all


prefix='images\';
class='face';
number=1;
filename=strcat(prefix,class,num2str(number),'.bmp');
picture=imread(filename, 'bmp');
