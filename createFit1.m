function [fitresult, gof] = createFit1(matrix)
flow = matrix(:,2);
speed = matrix(:,4);
%CREATEFIT1(ANS)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : ans
%      Y Output: ans
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 04-May-2016 16:20:25


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData(speed,flow );

% Set up fittype and options.
ft = fittype( 'poly3' );

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft );

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, xData, yData );
legend( h, 'sp vs fl', 'untitled fit 1', 'Location', 'NorthEast' );
% Label axes
xlabel sp
ylabel fl
grid on

