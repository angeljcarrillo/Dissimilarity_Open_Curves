%% DISSIMMILARITY DATASET MPEG7CS
clear all
close all;
clc
%% ADD PATH OF MPEG7CS DATABASE FROM YOUR COMPUTER
path='D:\Matlab\Dissimilarity_Open\BerkeleyCS_PL';
%% SELEC NUMBER OF SEMGMENT m
%% SELEC VALUE OF EPSILON [0,1]
m=19;
epsilon=0.67;
dissimilarityBerkeleyCS_PL(path,m, epsilon)
%%