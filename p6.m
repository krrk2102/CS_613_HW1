clear;
M = csvread('./diabetes.csv');
% a. ask user input for n -------------------------------------------------
n = input('Type how many principal components to use:\n');
if n > size(M, 2)
    n = size(M, 2);
end
if n < 1
    n = 1;
end
u = mean(M);
for i = 1 : size(M, 1)
    M(i, :) = M(i, :) - u;
end
C = cov(M);
[E, D] = eig(C);
V = zeros(1, size(D, 1));
for i = 1 : size(D, 1)
    V(1, i) = D(i, i);
end
E = [V(1, :); E(:, :)];
E = sortrows(E', 1)';
Largest = E(2:end, size(E, 1)-1 : -1 : size(E, 1)-n);
% b. compute and display n most significant components --------------------
display(Largest);
% c. compute and output projections ---------------------------------------
Ans = M * Largest;
display(Ans);
% d. if n == 2, plot data -------------------------------------------------
if n == 2
    plot(Ans, '.');
end