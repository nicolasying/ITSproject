function [fitresult, gof] = FitOccFlow(Occ, Flow)
%CREATEFIT1(OCC,FLOW)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : Occ
%      Y Output: Flow
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 10-Jun-2016 14:03:29


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( Occ, Flow );

% Set up fittype and options.
ft = fittype( 'poly3' );

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft );

% Plot fit with data.
figure( 'Name', 'Flow - Occ' );
h = plot( fitresult, xData, yData );
legend( h, 'Flow vs. Occ', 'Flow - Occ', 'Location', 'NorthEast' );
% Label axes
xlabel Occ
ylabel Flow
grid on


