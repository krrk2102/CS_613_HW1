clear;
% a. ----------------------------------------------------------------------
M = csvread('./x06Simple.csv');
% b. Linear regression ----------------------------------------------------
rng(1); % seed random number generator
randindex = randperm(size(M, 1));
A = M(randindex(1 : floor(size(M, 1) / 2)), :);
B = M(randindex(floor(size(M, 1) / 2): size(M, 1)), :);
X = A(:, 1 : end - 1); % training data
Y = A(:, end);
XB = B(:, 1 : end - 1); % test data
YB = B(:, end);
Beta = (X' * X) \ X' * Y; % linear regression
Ans = XB * Beta;
% i. random selection and output coefficient ----------
display(Beta);
% ii. output linear regression result -----------------
display(Ans); 
% iii. compute and output deviations ------------------ 
stdError = std(YB - Ans);
display(stdError); % standard deviation
meanError = mean(YB - Ans);
display(meanError); % mean deviation

% c. Locally weighted regression ------------------------------------------
k = 10; % preset k value for weights
LWRAns = zeros(size(XB, 1), 1);
for i = 1 : size(XB, 1)
    Diag = eye(size(X, 1)); % generate diagonal matrix for weights
    for j = 1 : size(X, 1)
        Diag(j, j) = exp(-norm(XB(i, :) - X(j, :)) / (k ^ 2));
    end
    WX = Diag * X;
    WY = Diag * Y;
    LWRBeta = (WX' * WX) \ WX' * WY;
    LWRAns(i, :) = XB(i, :) * LWRBeta; % weighted data for every test point
end
% i. output local wight regression computed values ----
display(LWRAns); 
% ii. compute and display deviations ------------------
LWRstdError = std(LWRAns - YB);
display(LWRstdError); % standard deviation
LWRmeanError = mean(LWRAns - YB);
display(LWRmeanError); % mean deviation

% d. Gradient descent -----------------------------------------------------
error = 0.000001; % preset boundary for exiting loop
alpha = 0.000005; 
theta_old = zeros(size(X, 2), 1);
k = 1;
while 1
    t_error(k) = (norm(X * theta_old - Y))^2; % training error record
    % update theta values
    theta_new = theta_old - alpha * X' * (X * theta_old - Y); 
    if norm(theta_new - theta_old) < error
        break;
    end
    theta_old = theta_new;
    k = k + 1;
end
% i. compute and display coefficients -----------------
display(theta_new); 
% ii. compute and display dependent variables' values -
GRAns = XB * theta_new;
display(GRAns);
% iii. compute and display deviations -----------------
GRstdError = std(GRAns - YB);
display(GRstdError);
GRmeanError = mean(GRAns - YB);
display(GRmeanError);
% iv. plot training error -----------------------------
plot(t_error);