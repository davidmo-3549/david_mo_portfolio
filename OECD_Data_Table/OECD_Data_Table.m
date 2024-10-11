clear all;
clc;
cd C:\Users\David\OneDrive\Documents\MATLAB\International_Finance\'Unit 5'\;
load InternationalData;

%%
% This program utilizes panel data on macroeconomic factors
% recorded from 1960 to 2013 at an annual frequency for 10 OECD countries. 
% The data is used to generate a table of stylized facts 
% that highlight the correlation of international real business cycles.
% Final results from this MATLAB code are exported to Excel for 
% tabular formatting. 

%% 
% Sources for the data are listed as follows
%       OECD: stats.oecd.org
%       TED: https://www.conference-board.org/data/economydatabase/
%       Penn World Tables Version 9.0: www.ggdc.net/pwt

%%
%Set smoothing parameter
smooth = 6.25;

%% Set up United States variables in per population terms

y_US = Y_US./Pop15plus_US; %This is real output per population
c_US = C_US./Pop15plus_US; %This is real (private) consumption per population
g_US = G_US./Pop15plus_US; %This is real government consumption per population
i_US = I_US./Pop15plus_US; %This is real (private) investment per population
nx_US = (X_US - IM_US)./Pop15plus_US; %This is real net exports per population
h_US = H_US./Pop15plus_US; %This is total work hours per population

%Set up cyclical components of United States variables

y_UScc = log(y_US) - hpfil(log(y_US), smooth);
c_UScc = log(c_US) - hpfil(log(c_US), smooth);
g_UScc = log(g_US) - hpfil(log(g_US), smooth);
i_UScc = log(i_US) - hpfil(log(i_US), smooth);
nx_UScc = nx_US - hpfil(nx_US, smooth); %WATCH OUT!
h_UScc = log(h_US) - hpfil(log(h_US), smooth);

%% Set up Australia variables in per population terms

y_Aus = Y_Aus./Pop15plus_Aus; %This is real output per population
c_Aus = C_Aus./Pop15plus_Aus; %This is real (private) consumption per population
g_Aus = G_Aus./Pop15plus_Aus; %This is real government consumption per population
i_Aus = I_Aus./Pop15plus_Aus; %This is real (private) investment per population
nx_Aus = (X_Aus - IM_Aus)./Pop15plus_Aus; %This is real net exports per population
h_Aus = H_Aus./Pop15plus_Aus; %This is total work hours per population

%Set up cyclical components of Australia variables

y_Auscc = log(y_Aus) - hpfil(log(y_Aus), smooth);
c_Auscc = log(c_Aus) - hpfil(log(c_Aus), smooth);
g_Auscc = log(g_Aus) - hpfil(log(g_Aus), smooth);
i_Auscc = log(i_Aus) - hpfil(log(i_Aus), smooth);
nx_Auscc = nx_Aus - hpfil(nx_Aus, smooth); %WATCH OUT!
h_Auscc = log(h_Aus) - hpfil(log(h_Aus), smooth);

%% Set up Austrian variables in per population terms

y_Aut = Y_Aut./Pop15plus_Aut; %This is real output per population
c_Aut = C_Aut./Pop15plus_Aut; %This is real (private) consumption per population
g_Aut = G_Aut./Pop15plus_Aut; %This is real government consumption per population
i_Aut = I_Aut./Pop15plus_Aut; %This is real (private) investment per population
nx_Aut = (X_Aut - IM_Aut)./Pop15plus_Aut; %This is real net exports per population
h_Aut = H_Aut./Pop15plus_Aut; %This is total work hours per population

%Set up cyclical components of Austria variables

y_Autcc = log(y_Aut) - hpfil(log(y_Aut), smooth);
c_Autcc = log(c_Aut) - hpfil(log(c_Aut), smooth);
g_Autcc = log(g_Aut) - hpfil(log(g_Aut), smooth);
i_Autcc = log(i_Aut) - hpfil(log(i_Aut), smooth);
nx_Autcc = nx_Aut - hpfil(nx_Aut, smooth); %WATCH OUT!
h_Autcc = log(h_Aut) - hpfil(log(h_Aut), smooth);

%% Set up Canadian variables in per population terms

y_Can = Y_Can./Pop15plus_Can; %This is real output per population
c_Can = C_Can./Pop15plus_Can; %This is real (private) consumption per population
g_Can = G_Can./Pop15plus_Can; %This is real government consumption per population
i_Can = I_Can./Pop15plus_Can; %This is real (private) investment per population
nx_Can = (X_Can - IM_Can)./Pop15plus_Can; %This is real net exports per population
h_Can = H_Can./Pop15plus_Can; %This is total work hours per population

%Set up cyclical components of Canadian variables

y_Cancc = log(y_Can) - hpfil(log(y_Can), smooth);
c_Cancc = log(c_Can) - hpfil(log(c_Can), smooth);
g_Cancc = log(g_Can) - hpfil(log(g_Can), smooth);
i_Cancc = log(i_Can) - hpfil(log(i_Can), smooth);
nx_Cancc = nx_Can - hpfil(nx_Can, smooth); %WATCH OUT!
h_Cancc = log(h_Can) - hpfil(log(h_Can), smooth);

%% Set up French variables in per population terms

y_Fra = Y_Fra./Pop15plus_Fra; %This is real output per population
c_Fra = C_Fra./Pop15plus_Fra; %This is real (private) consumption per population
g_Fra = G_Fra./Pop15plus_Fra; %This is real government consumption per population
i_Fra = I_Fra./Pop15plus_Fra; %This is real (private) investment per population
nx_Fra = (X_Fra - IM_Fra)./Pop15plus_Fra; %This is real net exports per population
h_Fra = H_Fra./Pop15plus_Fra; %This is total work hours per population

%Set up cyclical components of French variables

y_Fracc = log(y_Fra) - hpfil(log(y_Fra), smooth);
c_Fracc = log(c_Fra) - hpfil(log(c_Fra), smooth);
g_Fracc = log(g_Fra) - hpfil(log(g_Fra), smooth);
i_Fracc = log(i_Fra) - hpfil(log(i_Fra), smooth);
nx_Fracc = nx_Fra - hpfil(nx_Fra, smooth); %WATCH OUT!
h_Fracc = log(h_Fra) - hpfil(log(h_Fra), smooth);

%% Set up German variables in per population terms

y_Ger = Y_Ger./Pop15plus_Ger; %This is real output per population
c_Ger = C_Ger./Pop15plus_Ger; %This is real (private) consumption per population
g_Ger = G_Ger./Pop15plus_Ger; %This is real government consumption per population
i_Ger = I_Ger./Pop15plus_Ger; %This is real (private) investment per population
nx_Ger = (X_Ger - IM_Ger)./Pop15plus_Ger; %This is real net exports per population
h_Ger = H_Ger./Pop15plus_Ger; %This is total work hours per population

%Set up cyclical components of German variables

y_Gercc = log(y_Ger) - hpfil(log(y_Ger), smooth);
c_Gercc = log(c_Ger) - hpfil(log(c_Ger), smooth);
g_Gercc = log(g_Ger) - hpfil(log(g_Ger), smooth);
i_Gercc = log(i_Ger) - hpfil(log(i_Ger), smooth);
nx_Gercc = nx_Ger - hpfil(nx_Ger, smooth); %WATCH OUT!
h_Gercc = log(h_Ger) - hpfil(log(h_Ger), smooth);

%% Set up Italian variables in per population terms
y_Ita = Y_Ita./Pop15plus_Ita; %This is real output per population
c_Ita = C_Ita./Pop15plus_Ita; %This is real (private) consumption per population
g_Ita = G_Ita./Pop15plus_Ita; %This is real government consumption per population
i_Ita = I_Ita./Pop15plus_Ita; %This is real (private) investment per population
nx_Ita = (X_Ita - IM_Ita)./Pop15plus_Ita; %This is real net exports per population
h_Ita = H_Ita./Pop15plus_Ita; %This is total work hours per population

%Set up cyclical components of Italian variables

y_Itacc = log(y_Ita) - hpfil(log(y_Ita), smooth);
c_Itacc = log(c_Ita) - hpfil(log(c_Ita), smooth);
g_Itacc = log(g_Ita) - hpfil(log(g_Ita), smooth);
i_Itacc = log(i_Ita) - hpfil(log(i_Ita), smooth);
nx_Itacc = nx_Ita - hpfil(nx_Ita, smooth); %WATCH OUT!
h_Itacc = log(h_Ita) - hpfil(log(h_Ita), smooth);

%% Set up Japanese variables in per population terms
y_Jap = Y_Jap./Pop15plus_Jap; %This is real output per population
c_Jap = C_Jap./Pop15plus_Jap; %This is real (private) consumption per population
g_Jap = G_Jap./Pop15plus_Jap; %This is real government consumption per population
i_Jap = I_Jap./Pop15plus_Jap; %This is real (private) investment per population
nx_Jap = (X_Jap - IM_Jap)./Pop15plus_Jap; %This is real net exports per population
h_Jap = H_Jap./Pop15plus_Jap; %This is total work hours per population

%Set up cyclical components of Japanese variables

y_Japcc = log(y_Jap) - hpfil(log(y_Jap), smooth);
c_Japcc = log(c_Jap) - hpfil(log(c_Jap), smooth);
g_Japcc = log(g_Jap) - hpfil(log(g_Jap), smooth);
i_Japcc = log(i_Jap) - hpfil(log(i_Jap), smooth);
nx_Japcc = nx_Jap - hpfil(nx_Jap, smooth); %WATCH OUT!
h_Japcc = log(h_Jap) - hpfil(log(h_Jap), smooth);

%% Set up Swiss variables in per population terms
y_Swi = Y_Swi./Pop15plus_Swi; %This is real output per population
c_Swi = C_Swi./Pop15plus_Swi; %This is real (private) consumption per population
g_Swi = G_Swi./Pop15plus_Swi; %This is real government consumption per population
i_Swi = I_Swi./Pop15plus_Swi; %This is real (private) investment per population
nx_Swi = (X_Swi - IM_Swi)./Pop15plus_Swi; %This is real net exports per population
h_Swi = H_Swi./Pop15plus_Swi; %This is total work hours per population

%Set up cyclical components of Swiss variables

y_Swicc = log(y_Swi) - hpfil(log(y_Swi), smooth);
c_Swicc = log(c_Swi) - hpfil(log(c_Swi), smooth);
g_Swicc = log(g_Swi) - hpfil(log(g_Swi), smooth);
i_Swicc = log(i_Swi) - hpfil(log(i_Swi), smooth);
nx_Swicc = nx_Swi - hpfil(nx_Swi, smooth); %WATCH OUT!
h_Swicc = log(h_Swi) - hpfil(log(h_Swi), smooth);

%% Set up UK variables in per population terms
y_UK = Y_UK./Pop15plus_UK; %This is real output per population
c_UK = C_UK./Pop15plus_UK; %This is real (private) consumption per population
g_UK = G_UK./Pop15plus_UK; %This is real government consumption per population
i_UK = I_UK./Pop15plus_UK; %This is real (private) investment per population
nx_UK = (X_UK - IM_UK)./Pop15plus_UK; %This is real net exports per population
h_UK = H_UK./Pop15plus_UK; %This is total work hours per population

%Set up cyclical components of UK variables

y_UKcc = log(y_UK) - hpfil(log(y_UK), smooth);
c_UKcc = log(c_UK) - hpfil(log(c_UK), smooth);
g_UKcc = log(g_UK) - hpfil(log(g_UK), smooth);
i_UKcc = log(i_UK) - hpfil(log(i_UK), smooth);
nx_UKcc = nx_UK - hpfil(nx_UK, smooth); %WATCH OUT!
h_UKcc = log(h_UK) - hpfil(log(h_UK), smooth);


%% Set up generic table
Table1 = zeros(24,10);

% Fill in first 12 rows 

        % A. Standard deviation of variable relative to own-country standard deviation of output
Table1(1,1) = std(y_UScc)/std(y_UScc); Table1(1,2) = std(y_Auscc)/std(y_Auscc); 
Table1(1,3) = std(y_Autcc)/std(y_Autcc); Table1(1,4) = std(y_Cancc)/std(y_Cancc);
Table1(1,5) = std(y_Fracc)/std(y_Fracc); Table1(1,6) = std(y_Gercc)/std(y_Gercc); 
Table1(1,7) = std(y_Itacc)/std(y_Itacc); Table1(1,8) = std(y_Japcc)/std(y_Japcc);
Table1(1,9) = std(y_Swicc)/std(y_Swicc); Table1(1,10) = std(y_UKcc)/std(y_UKcc);

Table1(2,1) = std(c_UScc)/std(y_UScc); Table1(2,2) = std(c_Auscc)/std(y_Auscc); 
Table1(2,3) = std(c_Autcc)/std(y_Autcc); Table1(2,4) = std(c_Cancc)/std(y_Cancc);
Table1(2,5) = std(c_Fracc)/std(y_Fracc); Table1(2,6) = std(c_Gercc)/std(y_Gercc); 
Table1(2,7) = std(c_Itacc)/std(y_Itacc); Table1(2,8) = std(c_Japcc)/std(y_Japcc);
Table1(2,9) = std(c_Swicc)/std(y_Swicc); Table1(2,10) = std(c_UKcc)/std(y_UKcc);

Table1(3,1) = std(i_UScc)/std(y_UScc); Table1(3,2) = std(i_Auscc)/std(y_Auscc);
Table1(3,3) = std(i_Autcc)/std(y_Autcc); Table1(3,4) = std(i_Cancc)/std(y_Cancc);
Table1(3,5) = std(i_Fracc)/std(y_Fracc); Table1(3,6) = std(i_Gercc)/std(y_Gercc); 
Table1(3,7) = std(i_Itacc)/std(y_Itacc); Table1(3,8) = std(i_Japcc)/std(y_Japcc);
Table1(3,9) = std(i_Swicc)/std(y_Swicc); Table1(3,10) = std(i_UKcc)/std(y_UKcc);

Table1(4,1) = std(h_UScc)/std(y_UScc); Table1(4,2) = std(h_Auscc)/std(y_Auscc);
Table1(4,3) = std(h_Autcc)/std(y_Autcc); Table1(4,4) = std(h_Cancc)/std(y_Cancc);
Table1(4,5) = std(h_Fracc)/std(y_Fracc); Table1(4,6) = std(h_Gercc)/std(y_Gercc); 
Table1(4,7) = std(h_Itacc)/std(y_Itacc); Table1(4,8) = std(h_Japcc)/std(y_Japcc);
Table1(4,9) = std(h_Swicc)/std(y_Swicc); Table1(4,10) = std(h_UKcc)/std(y_UKcc);


Table1(5,1) = std(g_UScc)/std(y_UScc); Table1(5,2) = std(g_Auscc)/std(y_Auscc);
Table1(5,3) = std(g_Autcc)/std(y_Autcc); Table1(5,4) = std(g_Cancc)/std(y_Cancc);
Table1(5,5) = std(g_Fracc)/std(y_Fracc); Table1(5,6) = std(g_Gercc)/std(y_Gercc); 
Table1(5,7) = std(g_Itacc)/std(y_Itacc); Table1(5,8) = std(g_Japcc)/std(y_Japcc);
Table1(5,9) = std(g_Swicc)/std(y_Swicc); Table1(5,10) = std(g_UKcc)/std(y_UKcc);


Table1(6,1) = std(nx_UScc)/std( y_US - hpfil(y_US,smooth) );
Table1(6,2) = std(nx_Auscc)/std( y_Aus - hpfil(y_Aus,smooth) ); %WATCH OUT!
Table1(6,3) = std(nx_Autcc)/std( y_Aut - hpfil(y_Aut,smooth) );
Table1(6,4) = std(nx_Cancc)/std( y_Can - hpfil(y_Can,smooth) );
Table1(6,5) = std(nx_Fracc)/std( y_Fra - hpfil(y_Fra,smooth) );
Table1(6,6) = std(nx_Gercc)/std( y_Ger - hpfil(y_Ger,smooth) );
Table1(6,7) = std(nx_Itacc)/std( y_Ita - hpfil(y_Ita,smooth) );
Table1(6,8) = std(nx_Japcc)/std( y_Jap - hpfil(y_Jap,smooth) );
Table1(6,9) = std(nx_Swicc)/std( y_Swi - hpfil(y_Swi,smooth) );
Table1(6,10) = std(nx_UKcc)/std( y_UK - hpfil(y_UK,smooth) );

        % B. Correlation of variable with own-country output
Table1(7,1) = corr(y_UScc,y_UScc); Table1(7,2) = corr(y_Auscc,y_Auscc);
Table1(7,3) = corr(y_Autcc,y_Autcc); Table1(7,4) = corr(y_Cancc,y_Cancc);
Table1(7,5) = corr(y_Fracc,y_Fracc); Table1(7,6) = corr(y_Gercc,y_Gercc);
Table1(7,7) = corr(y_Itacc,y_Itacc); Table1(7,8) = corr(y_Japcc,y_Japcc);
Table1(7,9) = corr(y_Swicc,y_Swicc); Table1(7,10) = corr(y_UKcc,y_UKcc);

Table1(8,1) = corr(c_UScc,y_UScc); Table1(8,2) = corr(c_Auscc,y_Auscc);
Table1(8,3) = corr(c_Autcc,y_Autcc); Table1(8,4) = corr(c_Cancc,y_Cancc);
Table1(8,5) = corr(c_Fracc,y_Fracc); Table1(8,6) = corr(c_Gercc,y_Gercc);
Table1(8,7) = corr(c_Itacc,y_Itacc); Table1(8,8) = corr(c_Japcc,y_Japcc);
Table1(8,9) = corr(c_Swicc,y_Swicc); Table1(8,10) = corr(c_UKcc,y_UKcc);

Table1(9,1) = corr(i_UScc,y_UScc); Table1(9,2) = corr(i_Auscc,y_Auscc);
Table1(9,3) = corr(i_Autcc,y_Autcc); Table1(9,4) = corr(i_Cancc,y_Cancc);
Table1(9,5) = corr(i_Fracc,y_Fracc); Table1(9,6) = corr(i_Gercc,y_Gercc);
Table1(9,7) = corr(i_Itacc,y_Itacc); Table1(9,8) = corr(i_Japcc,y_Japcc);
Table1(9,9) = corr(i_Swicc,y_Swicc); Table1(9,10) = corr(i_UKcc,y_UKcc);


Table1(10,1) = corr(h_UScc,y_UScc); Table1(10,2) = corr(h_Auscc,y_Auscc);
Table1(10,3) = corr(h_Autcc,y_Autcc); Table1(10,4) = corr(h_Cancc,y_Cancc);
Table1(10,5) = corr(h_Fracc,y_Fracc); Table1(10,6) = corr(h_Gercc,y_Gercc);
Table1(10,7) = corr(h_Itacc,y_Itacc); Table1(10,8) = corr(h_Japcc,y_Japcc);
Table1(10,9) = corr(h_Swicc,y_Swicc); Table1(10,10) = corr(h_UKcc,y_UKcc);

Table1(11,1) = corr(g_UScc,y_UScc); Table1(11,2) = corr(g_Auscc,y_Auscc);
Table1(11,3) = corr(g_Autcc,y_Autcc); Table1(11,4) = corr(g_Cancc,y_Cancc);
Table1(11,5) = corr(g_Fracc,y_Fracc); Table1(11,6) = corr(g_Gercc,y_Gercc);
Table1(11,7) = corr(g_Itacc,y_Itacc); Table1(11,8) = corr(g_Japcc,y_Japcc);
Table1(11,9) = corr(g_Swicc,y_Swicc); Table1(11,10) = corr(g_UKcc,y_UKcc);

Table1(12,1) = corr(nx_UScc,y_US - hpfil(y_US,smooth));
Table1(12,2) = corr(nx_Auscc,y_Aus - hpfil(y_Aus,smooth)); %WATCH OUT!
Table1(12,3) = corr(nx_Autcc,y_Aut - hpfil(y_Aut,smooth));
Table1(12,4) = corr(nx_Cancc,y_Can - hpfil(y_Can,smooth));
Table1(12,5) = corr(nx_Fracc, y_Fra - hpfil(y_Fra,smooth) );
Table1(12,6) = corr(nx_Gercc, y_Ger - hpfil(y_Ger,smooth) );
Table1(12,7) = corr(nx_Itacc, y_Ita - hpfil(y_Ita,smooth) );
Table1(12,8) = corr(nx_Japcc, y_Jap - hpfil(y_Jap,smooth) );
Table1(12,9) = corr(nx_Swicc, y_Swi - hpfil(y_Swi,smooth) );
Table1(12,10) = corr(nx_UKcc, y_UK - hpfil(y_UK,smooth) );


% Fill in rows 13 through 18 

AF_y_UScc = autocorr(y_UScc);
AF_c_UScc = autocorr(c_UScc);
AF_i_UScc = autocorr(i_UScc);
AF_h_UScc = autocorr(h_UScc);
AF_g_UScc = autocorr(g_UScc);
AF_nx_UScc = autocorr(nx_UScc);

AF_y_Auscc = autocorr(y_Auscc);
AF_c_Auscc = autocorr(c_Auscc);
AF_i_Auscc = autocorr(i_Auscc);
AF_h_Auscc = autocorr(h_Auscc);
AF_g_Auscc = autocorr(g_Auscc);
AF_nx_Auscc = autocorr(nx_Auscc);

AF_y_Autcc = autocorr(y_Autcc);
AF_c_Autcc = autocorr(c_Autcc);
AF_i_Autcc = autocorr(i_Autcc);
AF_h_Autcc = autocorr(h_Autcc);
AF_g_Autcc = autocorr(g_Autcc);
AF_nx_Autcc = autocorr(nx_Autcc);

AF_y_Cancc = autocorr(y_Cancc);
AF_c_Cancc = autocorr(c_Cancc);
AF_i_Cancc = autocorr(i_Cancc);
AF_h_Cancc = autocorr(h_Cancc);
AF_g_Cancc = autocorr(g_Cancc);
AF_nx_Cancc = autocorr(nx_Cancc);

AF_y_Fracc = autocorr(y_Fracc);
AF_c_Fracc = autocorr(c_Fracc);
AF_i_Fracc = autocorr(i_Fracc);
AF_h_Fracc = autocorr(h_Fracc);
AF_g_Fracc = autocorr(g_Fracc);
AF_nx_Fracc = autocorr(nx_Fracc);

AF_y_Gercc = autocorr(y_Gercc);
AF_c_Gercc = autocorr(c_Gercc);
AF_i_Gercc = autocorr(i_Gercc);
AF_h_Gercc = autocorr(h_Gercc);
AF_g_Gercc = autocorr(g_Gercc);
AF_nx_Gercc = autocorr(nx_Gercc);

AF_y_Itacc = autocorr(y_Itacc);
AF_c_Itacc = autocorr(c_Itacc);
AF_i_Itacc = autocorr(i_Itacc);
AF_h_Itacc = autocorr(h_Itacc);
AF_g_Itacc = autocorr(g_Itacc);
AF_nx_Itacc = autocorr(nx_Itacc);

AF_y_Japcc = autocorr(y_Japcc);
AF_c_Japcc = autocorr(c_Japcc);
AF_i_Japcc = autocorr(i_Japcc);
AF_h_Japcc = autocorr(h_Japcc);
AF_g_Japcc = autocorr(g_Japcc);
AF_nx_Japcc = autocorr(nx_Japcc);

AF_y_Swicc = autocorr(y_Swicc);
AF_c_Swicc = autocorr(c_Swicc);
AF_i_Swicc = autocorr(i_Swicc);
AF_h_Swicc = autocorr(h_Swicc);
AF_g_Swicc = autocorr(g_Swicc);
AF_nx_Swicc = autocorr(nx_Swicc);

AF_y_UKcc = autocorr(y_UKcc);
AF_c_UKcc = autocorr(c_UKcc);
AF_i_UKcc = autocorr(i_UKcc);
AF_h_UKcc = autocorr(h_UKcc);
AF_g_UKcc = autocorr(g_UKcc);
AF_nx_UKcc = autocorr(nx_UKcc);
        
        % C. Autocorrelation of Variable
Table1(13,1) = AF_y_UScc(2,1); Table1(13,2) = AF_y_Auscc(2,1);
Table1(13,3) = AF_y_Autcc(2,1); Table1(13,4) = AF_y_Cancc(2,1);
Table1(13,5) = AF_y_Fracc(2,1); Table1(13,6) = AF_y_Gercc(2,1);
Table1(13,7) = AF_y_Itacc(2,1); Table1(13,8) = AF_y_Japcc(2,1);
Table1(13,9) = AF_y_Swicc(2,1); Table1(13,10) = AF_y_UKcc(2,1);

Table1(14,1) = AF_c_UScc(2,1); Table1(14,2) = AF_c_Auscc(2,1);
Table1(14,3) = AF_c_Autcc(2,1); Table1(14,4) = AF_c_Cancc(2,1);
Table1(14,5) = AF_c_Fracc(2,1); Table1(14,6) = AF_c_Gercc(2,1);
Table1(14,7) = AF_c_Itacc(2,1); Table1(14,8) = AF_c_Japcc(2,1);
Table1(14,9) = AF_c_Swicc(2,1); Table1(14,10) = AF_c_UKcc(2,1);

Table1(15,1) = AF_i_UScc(2,1); Table1(15,2) = AF_i_Auscc(2,1);
Table1(15,3) = AF_i_Autcc(2,1); Table1(15,4) = AF_i_Cancc(2,1);
Table1(15,5) = AF_i_Fracc(2,1); Table1(15,6) = AF_i_Gercc(2,1);
Table1(15,7) = AF_i_Itacc(2,1); Table1(15,8) = AF_i_Japcc(2,1);
Table1(15,9) = AF_i_Swicc(2,1); Table1(15,10) = AF_i_UKcc(2,1);

Table1(16,1) = AF_h_UScc(2,1); Table1(16,2) = AF_h_Auscc(2,1);
Table1(16,3) = AF_h_Autcc(2,1); Table1(16,4) = AF_h_Cancc(2,1);
Table1(16,5) = AF_h_Fracc(2,1); Table1(16,6) = AF_h_Gercc(2,1);
Table1(16,7) = AF_h_Itacc(2,1); Table1(16,8) = AF_h_Japcc(2,1);
Table1(16,9) = AF_h_Swicc(2,1); Table1(16,10) = AF_h_UKcc(2,1);

Table1(17,1) = AF_g_UScc(2,1); Table1(17,2) = AF_g_Auscc(2,1);
Table1(17,3) = AF_g_Autcc(2,1); Table1(17,4) = AF_g_Cancc(2,1);
Table1(17,5) = AF_g_Fracc(2,1); Table1(17,6) = AF_g_Gercc(2,1);
Table1(17,7) = AF_g_Itacc(2,1); Table1(17,8) = AF_g_Japcc(2,1);
Table1(17,9) = AF_g_Swicc(2,1); Table1(17,10) = AF_g_UKcc(2,1);

Table1(18,1) = AF_nx_UScc(2,1); Table1(18,2) = AF_nx_Auscc(2,1);
Table1(18,3) = AF_nx_Autcc(2,1); Table1(18,4) = AF_nx_Cancc(2,1);
Table1(18,5) = AF_nx_Fracc(2,1); Table1(18,6) = AF_nx_Gercc(2,1);
Table1(18,7) = AF_nx_Itacc(2,1); Table1(18,8) = AF_nx_Japcc(2,1);
Table1(18,9) = AF_nx_Swicc(2,1); Table1(18,10) = AF_nx_UKcc(2,1);


% Fill in rows 19 through 24 

        % D. Correlation of variable with same U.S. variable
Table1(19,1) = corr(y_UScc,y_UScc); Table1(19,2) = corr(y_Auscc,y_UScc);
Table1(19,3) = corr(y_Autcc,y_UScc); Table1(19,4) = corr(y_Cancc,y_UScc);
Table1(19,5) = corr(y_Fracc,y_UScc); Table1(19,6) = corr(y_Gercc,y_UScc);
Table1(19,7) = corr(y_Itacc,y_UScc); Table1(19,8) = corr(y_Japcc,y_UScc);
Table1(19,9) = corr(y_Swicc,y_UScc); Table1(19,10) = corr(y_UKcc,y_UScc);

Table1(20,1) = corr(c_UScc,c_UScc); Table1(20,2) = corr(c_Auscc,c_UScc);
Table1(20,3) = corr(c_Autcc,c_UScc); Table1(20,4) = corr(c_Cancc,c_UScc);
Table1(20,5) = corr(c_Fracc,c_UScc); Table1(20,6) = corr(c_Gercc,c_UScc);
Table1(20,7) = corr(c_Itacc,c_UScc); Table1(20,8) = corr(c_Japcc,c_UScc);
Table1(20,9) = corr(c_Swicc,c_UScc); Table1(20,10) = corr(c_UKcc,c_UScc);

Table1(21,1) = corr(i_UScc,i_UScc); Table1(21,2) = corr(i_Auscc,i_UScc);
Table1(21,3) = corr(i_Autcc,i_UScc); Table1(21,4) = corr(i_Cancc,i_UScc);
Table1(21,5) = corr(i_Fracc,i_UScc); Table1(21,6) = corr(i_Gercc,i_UScc);
Table1(21,7) = corr(i_Itacc,i_UScc); Table1(21,8) = corr(i_Japcc,i_UScc);
Table1(21,9) = corr(i_Swicc,i_UScc); Table1(21,10) = corr(i_UKcc,i_UScc);

Table1(22,1) = corr(h_UScc,h_UScc); Table1(22,2) = corr(h_Auscc,h_UScc);
Table1(22,3) = corr(h_Autcc,h_UScc); Table1(22,4) = corr(h_Cancc,h_UScc);
Table1(22,5) = corr(h_Fracc,h_UScc); Table1(22,6) = corr(h_Gercc,h_UScc);
Table1(22,7) = corr(h_Itacc,h_UScc); Table1(22,8) = corr(h_Japcc,h_UScc);
Table1(22,9) = corr(h_Swicc,h_UScc); Table1(22,10) = corr(h_UKcc,h_UScc);

Table1(23,1) = corr(g_UScc,g_UScc); Table1(23,2) = corr(g_Auscc,g_UScc);
Table1(23,3) = corr(g_Autcc,g_UScc); Table1(23,4) = corr(g_Cancc,g_UScc);
Table1(23,5) = corr(g_Fracc,g_UScc); Table1(23,6) = corr(g_Gercc,g_UScc);
Table1(23,7) = corr(g_Itacc,g_UScc); Table1(23,8) = corr(g_Japcc,g_UScc);
Table1(23,9) = corr(g_Swicc,g_UScc); Table1(23,10) = corr(g_UKcc,g_UScc);

Table1(24,1) = corr(nx_UScc,nx_UScc); Table1(24,2) = corr(nx_Auscc,nx_UScc);
Table1(24,3) = corr(nx_Autcc,nx_UScc); Table1(24,4) = corr(nx_Cancc,nx_UScc);
Table1(24,5) = corr(nx_Fracc,nx_UScc); Table1(24,6) = corr(nx_Gercc,nx_UScc);
Table1(24,7) = corr(nx_Itacc,nx_UScc); Table1(24,8) = corr(nx_Japcc,nx_UScc);
Table1(24,9) = corr(nx_Swicc,nx_UScc); Table1(24,10) = corr(nx_UKcc,nx_UScc);


% Display table
Table1