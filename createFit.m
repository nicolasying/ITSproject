function [fitresult, gof] = createFit(ans)
%CREATEFIT(ANS)
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

%  Auto-generated by MATLAB on 04-May-2016 16:17:13


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( ans(:,2), ans(:,4) );

% Set up fittype and options.
ft = fittype( 'poly2' );

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft );

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, xData, yData );
legend( h, 'ans vs. ans', 'untitled fit 1', 'Location', 'NorthEast' );
% Label axes
xlabel ans
ylabel ans
grid on


