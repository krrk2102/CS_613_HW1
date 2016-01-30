clear;
% a. read in csv file -----------------------------------------------------
M = csvread('./diabetes.csv');
Cond1 = M(:, 1) == 1;
Cond2 = M(:, 1) == -1;
C1 = M(Cond1, 2 : end);
C2 = M(Cond2, 2 : end);
u1 = mean(C1)';
u2 = mean(C2)';
S1 = (size(C1, 1) - 1) * cov(C1);
S2 = (size(C2, 1) - 1) * cov(C2);
Sw = S1 + S2;
v = Sw \ (u1 - u2);
% b. find and report principal components ---------------------------------
display(v);
% c. project data and output data for 2 classes ---------------------------
R1 = C1 * v;
display(R1);
R2 = C2 * v;
display(R2);