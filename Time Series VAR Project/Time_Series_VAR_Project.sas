OPTIONS NONUMBER NODATE;

/***************************** load the data from EXCEL **********************************************/
PROC IMPORT DATAFILE = '/home/u63433704/Financial Econometrics/Project Data.xlsx'
	OUT = VAR_Project DBMS = XLSX REPLACE; 
	RUN;

/********************* Examine the data ********************************************************/	
/**************************************************************************************************/
/**********************************************************************************************************/

DATA VAR_Project;
	SET VAR_Project;

	    LN_EFFR = LOG(EFFR);
	    LN_SP = LOG(Close_SP);
		LN_NQ = LOG(Close_NQ);
		RUN;

Title "Log Time Series Plot";		
PROC SGPLOT DATA = VAR_Project;
	SERIES X = Effective_Date Y = LN_EFFR;
	SERIES X = Effective_Date Y = LN_SP;
	SERIES X = Effective_Date Y = LN_NQ;
	XAXIS GRID; YAXIS GRID;
	YAXIS LABEL="Series";
	RUN;

Title "Level Time Series Plot";	
PROC SGPLOT DATA = VAR_Project;
	SERIES X = Effective_Date Y = EFFR;
	SERIES X = Effective_Date Y = Close_SP;
	SERIES X = Effective_Date Y = Close_NQ;
	XAXIS GRID; YAXIS GRID;
	YAXIS LABEL="Series";
	RUN;
	
Title "Figure 2: Nasdaq Composite Index (^IXIC)";	
PROC SGPLOT DATA = VAR_Project (where = (T > 5368));
	SERIES X = Effective_Date Y = Close_NQ;
	XAXIS GRID; YAXIS GRID;
	YAXIS LABEL="Series";
	RUN;

Title "Figure 1: S&P 500 Index (^GSPC)";	
PROC SGPLOT DATA = VAR_Project (where = (T > 5368));
	SERIES X = Effective_Date Y = Close_SP;
	XAXIS GRID; YAXIS GRID;
	YAXIS LABEL="Series";
	RUN;

	
Title "Level Time Series Plot";	
PROC SGPLOT DATA = VAR_Project;
	SERIES X = Effective_Date Y = EFFR;
	XAXIS GRID; YAXIS GRID;
	YAXIS LABEL="Series";
	RUN;
	
*		There appears to be some time series relation between the variables. Will do Granger causality after differencing.;
*		We will not be using any additional explanatory variables since we think that the usual candidates
*			such as GDP or inflation will not be exogenous.;
		
PROC MEANS DATA = VAR_Project MAXDEC = 2;
	VAR EFFR Close_SP Close_NQ LN_EFFR LN_SP LN_NQ; RUN;
	
PROC MEANS DATA = VAR_Project (where = (T < 2872 ));
	VAR EFFR; RUN;
	
PROC MEANS DATA = VAR_Project (where = (T >= 2872 ));
	VAR EFFR; RUN;
	
TITLE 'Effective Federal Funds Rate';
PROC ARIMA    DATA = VAR_Project;
	IDENTIFY   VAR = EFFR;
	IDENTIFY   VAR = LN_EFFR;
	QUIT;
	
TITLE 'S&P500';
PROC ARIMA    DATA = VAR_Project;
	IDENTIFY   VAR = Close_SP;
	IDENTIFY   VAR = LN_SP;
	QUIT;
	
TITLE 'NASDAQ';
PROC ARIMA    DATA = VAR_Project;
	IDENTIFY   VAR = Close_NQ;
	IDENTIFY   VAR = LN_NQ;
	QUIT;
	
/*		There are some clear nonstationarities in our 3 variables of interest. 
		Trends are very much visible.
		Variance appears to be changing through time, so we will consider using the log to normalize variance.
*/

      
      
      
      
      
      
      
      
      
/***********              Stationarity Check/ Dickey-Fuller                          **************************/
/**********************************************************************************************************/
/*********************************************************************************************************************/
/*********************************************************************************************************************/

                /* EFFR Dickey-Fuller */
Title "EFFR - Dickey Fuller";
PROC ARIMA DATA = VAR_Project;
	IDENTIFY VAR = EFFR    STATIONARITY = (ADF = 0); *LEVEL VARIABLE;
	IDENTIFY VAR = EFFR    STATIONARITY = (ADF = 5); *LEVEL VARIABLE with up to 5 lags;
	IDENTIFY VAR = EFFR(1) STATIONARITY = (ADF = 0); *1ST DIFFERENCE;
	IDENTIFY VAR = EFFR(1)    STATIONARITY = (ADF = 5); *1st Difference with up to 5 lags;
	RUN;
	
*		the first coefficient for the level variable was borderline statistically significant, so extended ADF test;
	
                /* Close_SP Dickey-Fuller */
Title "Close_SP - Dickey Fuller";
PROC ARIMA DATA = VAR_Project;
	IDENTIFY VAR = Close_SP    STATIONARITY = (ADF = 0); *LEVEL VARIABLE (ALL 3 CASES), No point running ADF here. Clearly non-sig as is;
	IDENTIFY VAR = Close_SP(1) STATIONARITY = (ADF = 0); *1ST DIFFERENCE (ALL 3 CASES);
	IDENTIFY VAR = Close_SP(1) STATIONARITY = (ADF = 5); *1ST DIFFERENCE (ALL 3 CASES);
	RUN;
	
                /* Close_NQ Dickey-Fuller */
Title "Close_NQ - Dickey Fuller";
PROC ARIMA DATA = VAR_Project;
	IDENTIFY VAR = Close_NQ    STATIONARITY = (ADF = 0); *LEVEL VARIABLE (ALL 3 CASES);
	IDENTIFY VAR = Close_NQ(1) STATIONARITY = (ADF = 0); *1ST DIFFERENCE (ALL 3 CASES);
	IDENTIFY VAR = Close_NQ(1) STATIONARITY = (ADF = 5); *1ST DIFFERENCE (ALL 3 CASES);
	RUN;

*		All three variables are stationary after 1st differencing (Integrated Order 1);
*		After ADF(5), the differenced variables are still stationary, so we will proceed with
		d.EFFR, d.SP, and d.NQ. ;
			
Title "EFFR Log - Dickey Fuller";
PROC ARIMA DATA = VAR_Project;
	IDENTIFY VAR = LN_EFFR    STATIONARITY = (ADF = 0); *LEVEL VARIABLE;
	IDENTIFY VAR = LN_EFFR    STATIONARITY = (ADF = 5); *LEVEL VARIABLE with up to 5 lags;
	IDENTIFY VAR = LN_EFFR(1) STATIONARITY = (ADF = 0); *1ST DIFFERENCE;
	IDENTIFY VAR = LN_EFFR(1)    STATIONARITY = (ADF = 5); *1st Difference with up to 5 lags;
	RUN;
	
Title "SP500 Log - Dickey Fuller";
PROC ARIMA DATA = VAR_Project;
	IDENTIFY VAR = LN_SP    STATIONARITY = (ADF = 0); *LEVEL VARIABLE;
	IDENTIFY VAR = LN_SP(1) STATIONARITY = (ADF = 0); *1ST DIFFERENCE;
	IDENTIFY VAR = LN_SP(1)    STATIONARITY = (ADF = 5); *1st Difference with up to 5 lags;
	RUN;

Title "NASDAQ Log - Dickey Fuller";
PROC ARIMA DATA = VAR_Project;
	IDENTIFY VAR = LN_NQ    STATIONARITY = (ADF = 0); *LEVEL VARIABLE;
	IDENTIFY VAR = LN_NQ(1) STATIONARITY = (ADF = 0); *1ST DIFFERENCE;
	IDENTIFY VAR = LN_NQ(1)    STATIONARITY = (ADF = 5); *1st Difference with up to 5 lags;
	RUN;
		
DATA VAR_Project;
	SET VAR_Project;          * create the 1st differenced variables;

	    D_EFFR = DIF(EFFR);
	    D_SP = DIF(Close_SP);
		D_NQ = DIF(Close_NQ);
		
		DL_EFFR = DIF(LN_EFFR);
	    DL_SP = DIF(LN_SP);
		DL_NQ = DIF(LN_NQ);
		RUN;

		PROC ARIMA    DATA = VAR_Project;
			IDENTIFY   VAR = D_EFFR;
			IDENTIFY   VAR = D_SP;
			IDENTIFY   VAR = D_NQ;
	
			IDENTIFY   VAR = DL_EFFR;
			IDENTIFY   VAR = DL_SP;
			IDENTIFY   VAR = DL_NQ;
			QUIT;
	
		Title "Log Difference Time Series Plot";		
		PROC SGPLOT DATA = VAR_Project;
			SERIES X = Effective_Date Y = DL_EFFR;
			SERIES X = Effective_Date Y = DL_SP;
			SERIES X = Effective_Date Y = DL_NQ;
			XAXIS GRID; YAXIS GRID;
			YAXIS LABEL="Series";
			RUN;

		Title "Level Difference Time Series Plot";	
		PROC SGPLOT DATA = VAR_Project;
			SERIES X = Effective_Date Y = D_EFFR;
			SERIES X = Effective_Date Y = D_SP;
			SERIES X = Effective_Date Y = D_NQ;
			XAXIS GRID; YAXIS GRID;
			YAXIS LABEL="Series";
			RUN;
*				can't tell anything from these graphs here;


*		VAR Stationarity Check By Finding the Roots;	
*			level;
		PROC VARMAX DATA = VAR_Project;
   			MODEL D_SP D_EFFR / P = 1 print=(roots);
			run;
		PROC VARMAX DATA = VAR_Project;
   			MODEL D_NQ D_EFFR / P = 1 print=(roots);
			run;

*			log;
		proc varmax data=VAR_Project;
   			model DL_SP DL_EFFR / P = 1 print=(roots);
			run;
		proc varmax data=VAR_Project;
  			 model DL_NQ DL_EFFR / P = 1 print=(roots);
			run;

*		The modulus of the roots is <1 for all models, so it appears that the VAR models are stationary;	



*		Export VAR_Project to EXCEL just cause;

Proc Export Data=VAR_Project
    Outfile= '/home/u63433704/Financial Econometrics/VAR_Project.xlsx'
    dbms=XLSX    
    Replace;
Run;










	
	
/***************           Granger Causality                                    *******************************/
/**********************************************************************************************************/	
/***************************************************************************************************************/
/************************************************************************************************************************/




/*              Level Variables Granger                                                        */
TITLE "Level SP500 Granger - 5 Lags";
PROC VARMAX DATA = VAR_Project;
	MODEL D_SP = D_EFFR / P = 5;                   
	CAUSAL GROUP1 = (D_SP) GROUP2 = (D_EFFR);       
	RUN;

TITLE "Level SP500 Granger - 10 Lags";
PROC VARMAX DATA = VAR_Project;
	MODEL D_SP = D_EFFR / P = 10;                   * sp500, 10 lags;
	CAUSAL GROUP1 = (D_SP) GROUP2 = (D_EFFR);       * significant at the 5% level, p-value = 0.0164;
	RUN;
	
	
*		Check if there's an even better p;
		TITLE "Level SP500 Granger - 15 Lags";   
		PROC VARMAX DATA = VAR_Project;
			MODEL D_SP = D_EFFR / P = 15;                   * sp500, 15 lags;
			CAUSAL GROUP1 = (D_SP) GROUP2 = (D_EFFR);       *********** significant at the 1% level, pvalue = 0.0091;
			RUN;

		TITLE "Level SP500 Granger - 20 Lags";
		PROC VARMAX DATA = VAR_Project;
			MODEL D_SP = D_EFFR / P = 20;                   * sp500, 20 lags;
			CAUSAL GROUP1 = (D_SP) GROUP2 = (D_EFFR);       * significant at the 5% level, p-value = 0.0174;
			RUN;


TITLE "Level NASDAQ Granger - 5 Lags";
PROC VARMAX DATA = VAR_Project;
	MODEL D_NQ = D_EFFR / P = 5;                        
	CAUSAL GROUP1 = (D_NQ) GROUP2 = (D_EFFR);            
	RUN;

TITLE "Level NASDAQ Granger - 10 Lags";
PROC VARMAX DATA = VAR_Project;
	MODEL D_NQ = D_EFFR / P = 10;                        * NASDAQ, 10 lags;
	CAUSAL GROUP1 = (D_NQ) GROUP2 = (D_EFFR);            * not statistically significant;
	RUN;

		TITLE "Level NASDAQ Granger - 15 Lags";   
		PROC VARMAX DATA = VAR_Project;
			MODEL D_NQ = D_EFFR / P = 15;                   * NASDAQ, 15 lags;
			CAUSAL GROUP1 = (D_NQ) GROUP2 = (D_EFFR);       * no sig;
			RUN;

		TITLE "Level NASDAQ Granger - 20 Lags";
		PROC VARMAX DATA = VAR_Project;
			MODEL D_NQ = D_EFFR / P = 20;                   * NASDAQ, 20 lags;
			CAUSAL GROUP1 = (D_NQ) GROUP2 = (D_EFFR);       * no sig;
			RUN;				

*			From the level variable analysis: we can use VAR for SP500, but not for NASDAQ;
*			Use ARIMA for NASDAQ;
*			For SP500, we got the best p-value from 15 lags;
	


/*              Log Variables Granger                                                        */
TITLE "Log SP500 Granger - 10 Lags";
PROC VARMAX DATA = VAR_Project;
	MODEL DL_SP = DL_EFFR / P = 10;
	CAUSAL GROUP1 = (DL_SP) GROUP2 = (DL_EFFR);
	RUN;

TITLE "Log NASDAQ Granger - 10 Lags";
PROC VARMAX DATA = VAR_Project;
	MODEL DL_NQ = DL_EFFR / P = 10;
	CAUSAL GROUP1 = (DL_NQ) GROUP2 = (DL_EFFR);     *		We get no significance here... Lets try some more lags;
	RUN;

			
*			Log sp500 is significant at 20 lags, log NASDAQ is not significant;
*			No reason to increase lags further since 
				based on theory, the time-lag of impacts on asset prices should be very short. Near instant impacts.;
			

*			Both level and log had sp500 yes and NASDAQ no;
*			However, level sp500 required fewer lags before we began to see significance.;
*			Therefore, use level for testing due to parsimony;



*	Granger causality tests show that past values of EFFR are not likely to help forecast Nasdaq prices,
		but do have potential to improve S&P 500 forecasts;








/***************         Testing/ Box Jenkins Candidate Model Selection                          *******************************/
/**********************************************************************************************************/	
/***************************************************************************************************************/
/************************************************************************************************************************/





*VAR		VAR			VAR			VAR			VAR			VAR			VAR			VAR			VAR			VAR		;
*	SP500			SP500			SP500			SP500			SP500			SP500			SP500			SP500			SP500	;




* 		We chose to use a VAR, not a ARX or VARMAX or any of those that need an exogenous X
			since it is very unlikely that EFFR is exogenous.
			EFFR most likely co-determined with asset prices;
*		Run VAR models P = 1 - 20, and compile the AIC/SBC results in var_stat_compile;

		PROC VARMAX DATA = VAR_Project OUTSTAT = var_stat1;
			MODEL D_SP D_EFFR / P = 1;	RUN;
		PROC VARMAX DATA = VAR_Project OUTSTAT = var_stat2;
			MODEL D_SP D_EFFR / P = 2;	RUN;
		PROC VARMAX DATA = VAR_Project OUTSTAT = var_stat3;
			MODEL D_SP D_EFFR / P = 3;	RUN;
		PROC VARMAX DATA = VAR_Project OUTSTAT = var_stat4;
			MODEL D_SP D_EFFR / P = 4;	RUN;
		PROC VARMAX DATA = VAR_Project OUTSTAT = var_stat5;
			MODEL D_SP D_EFFR / P = 5;	RUN;
		PROC VARMAX DATA = VAR_Project OUTSTAT = var_stat6;
			MODEL D_SP D_EFFR / P = 6;	RUN;
		PROC VARMAX DATA = VAR_Project OUTSTAT = var_stat7;
			MODEL D_SP D_EFFR / P = 7;	RUN;
		PROC VARMAX DATA = VAR_Project OUTSTAT = var_stat8;
			MODEL D_SP D_EFFR / P = 8;	RUN;
		PROC VARMAX DATA = VAR_Project OUTSTAT = var_stat9;
			MODEL D_SP D_EFFR / P = 9;	RUN;
		PROC VARMAX DATA = VAR_Project OUTSTAT = var_stat10;
			MODEL D_SP D_EFFR / P = 10;	RUN;			
		PROC VARMAX DATA = VAR_Project OUTSTAT = var_stat11;
			MODEL D_SP D_EFFR / P = 11;	RUN;			
		PROC VARMAX DATA = VAR_Project OUTSTAT = var_stat12;
			MODEL D_SP D_EFFR / P = 12;	RUN;			
		PROC VARMAX DATA = VAR_Project OUTSTAT = var_stat13;
			MODEL D_SP D_EFFR / P = 13;	RUN;			
		PROC VARMAX DATA = VAR_Project OUTSTAT = var_stat14;
			MODEL D_SP D_EFFR / P = 14;	RUN;			
		PROC VARMAX DATA = VAR_Project OUTSTAT = var_stat15;
			MODEL D_SP D_EFFR / P = 15;	RUN;			
		PROC VARMAX DATA = VAR_Project OUTSTAT = var_stat16;
			MODEL D_SP D_EFFR / P = 16;	RUN;			
		PROC VARMAX DATA = VAR_Project OUTSTAT = var_stat17;
			MODEL D_SP D_EFFR / P = 17;	RUN;			
		PROC VARMAX DATA = VAR_Project OUTSTAT = var_stat18;
			MODEL D_SP D_EFFR / P = 18;	RUN;			
		PROC VARMAX DATA = VAR_Project OUTSTAT = var_stat19;
			MODEL D_SP D_EFFR / P = 19;	RUN;			
		PROC VARMAX DATA = VAR_Project OUTSTAT = var_stat20;
			MODEL D_SP D_EFFR / P = 20;	RUN;			
			
DATA var_stat_compile; 
	Set var_stat1 var_stat2 var_stat3 var_stat4 var_stat5 var_stat6 var_stat7 var_stat8 var_stat9 var_stat10
		var_stat11 var_stat12 var_stat13 var_stat14 var_stat15 var_stat16 var_stat17 var_stat18 var_stat19 var_stat20;
	KEEP AIC SBC;
	RUN;




		
*			Minimum AIC at P = 16;
*			Minimum SBC at P = 9;
*			We will use P = 9 due to parsimony;
*			AIC/SBC plots on EXCEL show that at P = 9, SBS bottoms out and begins to increase, while AIC 
				doesn't decrease by much more;
*			We get to minimize SBC without comprimising AIC concerns too much;

				PROC VARMAX DATA = VAR_Project;
					MODEL D_SP = D_EFFR / P = 1 PRINT = (parcoef pcorr pcancorr) lagmax = 30;
					RUN;
					*	Partial cross correlation plots further suggest P = 9 is the right model, 
							as there is a run of significant partial cross correlations
							that dies out after P = 9;
					*	After P = 9, there are sporadic moments of statistical significance but no more sustained runs;
					
					

*ARIMA			ARIMA			ARIMA			ARIMA			ARIMA			ARIMA			ARIMA			ARIMA			ARIMA;
*	NASDAQ			NASDAQ			NASDAQ			NASDAQ			NASDAQ			NASDAQ			NASDAQ			NASDAQ			NASDAQ;


*		EXAMINE D_NQ ACF and PACF, then find the right ARMA(p,q)	;

		PROC ARIMA    DATA = VAR_Project;
			IDENTIFY   VAR = D_NQ;
			RUN;
			
*			small spikes that carry off into distant lags for both ACF and PACF, so likely an ARMA;

ODS GRAPHICS OFF;
PROC ARIMA DATA = VAR_Project;
	IDENTIFY VAR = D_NQ NOPRINT;
	ESTIMATE P = 1;		ESTIMATE P = 2;		ESTIMATE P = 3;		ESTIMATE P = 4;
	ESTIMATE P = 5;     ESTIMATE P = 6;		ESTIMATE P = 7;     ESTIMATE P = 8;		
	ESTIMATE P = 9;     ESTIMATE P = 10;	ESTIMATE P = 11; 	ESTIMATE P = 12;		
	ESTIMATE P = 13;     ESTIMATE P = 14;		ESTIMATE P = 15;     ESTIMATE P = 16;	
	ESTIMATE P = 17;     ESTIMATE P = 18;		ESTIMATE P = 19;     ESTIMATE P = 20;	
	RUN;
*		AIC minimized at 15 lags;
*		SBC minimized at 9 lags;
*		Refrain from adding more lags for parsimony purposes;
*		The theoretical timeframe for impacts on asset prices is very short, 
			so we give a "cushion period" of 2 business weeks but no more;
*		Prefer SBC for parsimony, since the literature typically finds near-instant impacts on asset prices;
 
ODS GRAPHICS OFF;
PROC ARIMA DATA = VAR_Project;
	IDENTIFY VAR = D_NQ NOPRINT;
	ESTIMATE P = 1 NOINT;		ESTIMATE P = 2 NOINT;		ESTIMATE P = 3 NOINT;		ESTIMATE P = 4 NOINT;
	ESTIMATE P = 5 NOINT;     ESTIMATE P = 6 NOINT;		ESTIMATE P = 7 NOINT;     ESTIMATE P = 8 NOINT;		
	ESTIMATE P = 9 NOINT;     ESTIMATE P = 10 NOINT;	ESTIMATE P = 11 NOINT; 	ESTIMATE P = 12 NOINT;		
	ESTIMATE P = 13 NOINT;     ESTIMATE P = 14 NOINT;		ESTIMATE P = 15 NOINT;     ESTIMATE P = 16 NOINT;	
	ESTIMATE P = 17 NOINT;     ESTIMATE P = 18 NOINT;		ESTIMATE P = 19 NOINT;     ESTIMATE P = 20 NOINT;	
	
*		Same results for NOINT versions, but a little lower;
*		P = 9 NOINT is our best model;
	
*		Lets see if some MA components help;
*		Find combinations where the number of parameters is less than 9;
ODS GRAPHICS OFF;
PROC ARIMA DATA = VAR_Project;
	IDENTIFY VAR = D_NQ NOPRINT;
	ESTIMATE P = 1 Q = 1 NOINT;	
	ESTIMATE P = 2 Q = 1 NOINT;
	ESTIMATE P = 3 Q = 1 NOINT;
	ESTIMATE P = 4 Q = 1 NOINT;
	ESTIMATE P = 5 Q = 1 NOINT;
	ESTIMATE P = 6 Q = 1 NOINT;
	ESTIMATE P = 7 Q = 1 NOINT;
	ESTIMATE P = 1 Q = 2 NOINT;
	ESTIMATE P = 2 Q = 2 NOINT;
	ESTIMATE P = 3 Q = 2 NOINT;
	ESTIMATE P = 4 Q = 2 NOINT;
	ESTIMATE P = 5 Q = 2 NOINT;
	ESTIMATE P = 6 Q = 2 NOINT;
	ESTIMATE P = 1 Q = 3 NOINT;
	ESTIMATE P = 2 Q = 3 NOINT;
	ESTIMATE P = 3 Q = 3 NOINT;	
	ESTIMATE P = 4 Q = 3 NOINT;
	ESTIMATE P = 5 Q = 3 NOINT;
	ESTIMATE P = 1 Q = 4 NOINT;
	ESTIMATE P = 2 Q = 4 NOINT;
	ESTIMATE P = 3 Q = 4 NOINT;
	ESTIMATE P = 4 Q = 4 NOINT;
	ESTIMATE P = 1 Q = 5 NOINT;
	ESTIMATE P = 2 Q = 5 NOINT;
	ESTIMATE P = 3 Q = 5 NOINT;	
	ESTIMATE P = 1 Q = 6 NOINT;
	ESTIMATE P = 2 Q = 6 NOINT;
	ESTIMATE P = 1 Q = 7 NOINT;	
	RUN;

*		Nope, adding MA does not help, ignore this;
*		There were some values that were marginally better in 1 category or the other, but no definitively better option;
*		Stick with AR(9) for simplicity;




				ODS GRAPHICS OFF;
				PROC ARIMA DATA = VAR_Project;
					IDENTIFY VAR = D_SP NLAG = 30;
					RUN;

				ODS GRAPHICS OFF;
				PROC ARIMA DATA = VAR_Project;
					IDENTIFY VAR = D_NQ NLAG = 30;
					RUN;
					
		*	The PACF appears to cutoff at P = 9, and the ACF tails off at P = 9;
		*	The ACF and PACF values suggest similar, with the significant spikes dying out after P = 9;

*		Whichever model has the best information criterion will be used in the forecasting stage;















/***************           VAR/ ARIMA Forecast                                  *******************************/
/**********************************************************************************************************/	
/***************************************************************************************************************/
/************************************************************************************************************************/
/**********************************************************************************************************/	
/***************************************************************************************************************/



	
	
*				Reverse the data so that we can back-forecast the first 100 observations;
DATA Backwards_VAR_Project;
	DO i=nobs to 1 by -1;
		set VAR_Project nobs=nobs point=i;
		output;
	end;
	stop;
	run;
	
	
	
	
	
****************						SP500 VAR Forecast;


PROC VARMAX DATA = Backwards_VAR_Project (where = (T>101));  *We are seperating the first 100 periods as a testing set;
		MODEL D_SP D_EFFR / P = 9;                            *need T > 101 instead of 100 b/c differencing removed the first observation;
		OUTPUT OUT = SP_forecast LEAD = 100;
		DATA SP_forecast;
		SET  SP_forecast;
		T = _N_;
		RUN;

*			This shows the 2nd to last group of 100 observations, so the last 100 obs in our training set;	
*			It also shows the "backwards forecats" of the first 100 observations of D_SP in our original dataset;	
*			Copy the actual first 100 obs for D_SP from the main dataset, and compare with the test set forecast to find MSE;
*					MSE calculation done in EXCEL;
*					MSE is 25533.68068;


PROC PRINT DATA = SP_forecast (where = (T > 5589));  

DATA Backwards_Projection_SP;
	Set SP_forecast (where = (T > 5688));
	Set Backwards_Var_Project (where = (T < 102));
	KEEP D_SP FOR1 LCI1 UCI1;
	RUN;

		DATA Backwards_Projection_SP1;
			DO i=nobs to 1 by -1;
				set Backwards_Projection_SP nobs=nobs point=i;
				output;
			end;
			stop;
			run;
			
		DATA Backwards_Projection_SP1;
			Set Backwards_Projection_SP1;
			
			T = _N_;
			RUN;

TITLE "Figure 6: S&P 500 Forecast";
PROC SGPLOT  DATA = Backwards_Projection_SP1;
		BAND 	X = T LOWER = LCI1 UPPER = UCI1;
		SCATTER X = T Y = D_SP;
		SERIES 	X = T Y = FOR1;
		XAXIS GRID; YAXIS GRID;
		WHERE T > 0; REFLINE 100 / AXIS = X;
		RUN;

PROC MEANS DATA = Backwards_Projection_SP1;
  VAR D_SP;  
  VAR FOR1;
RUN;


data SP_MSE;
  set Backwards_Projection_SP1;
  error = D_SP - FOR1;
  squared_error = error * error;
  de_mean = D_SP - -1.2777000; 
  de_mean_sq = de_mean*de_mean;
run;

PROC MEANS DATA = SP_MSE mean sum;      *D_SP mean squared error (MSE) is 255.3368;
  VAR squared_error;                     * average squared mean deviation is 255.2372577;
  VAR de_mean_sq;                         *  RSE = 1.0004;  
RUN;








*******************************	                NASDAQ ARIMA Forecast;




PROC ARIMA 	 DATA = Backwards_VAR_Project (where = (T>101));
	 IDENTIFY VAR = D_NQ ;
	   ESTIMATE P = 9 NOINT;
	FORECAST LEAD = 100 OUT = NQ_forecast;
	DATA NQ_forecast;
	SET  NQ_forecast;
	T = _N_;
	RUN; QUIT;

*			This shows the 2nd to last group of 100 observations, so the last 100 obs in our training set;	
*			It also shows the "backwards forecats" of the first 100 observations of D_NQ in our original dataset;	
*			Copy the actual first 100 obs for D_NQ from the main dataset, and compare with the test set forecast to find MSE;
*					MSE calculation done in EXCEL;
*					MSE is 850903.431;

PROC PRINT DATA = NQ_forecast (where = (T > 5589));  

DATA Backwards_Projection_NQ;
	Set NQ_forecast (where = (T > 5688));
	Set Backwards_Var_Project (where = (T < 102));
	KEEP D_NQ FORECAST L95 U95;
	RUN;

		DATA Backwards_Projection_NQ1;
			DO i=nobs to 1 by -1;
				set Backwards_Projection_NQ nobs=nobs point=i;
				output;
			end;
			stop;
			run;
			
		DATA Backwards_Projection_NQ1;
			Set Backwards_Projection_NQ1;
			
			T = _N_;
			RUN;

TITLE "Figure 7: Nasdaq Forecast";
PROC SGPLOT  DATA = Backwards_Projection_NQ1;
		BAND 	X = T LOWER = L95 UPPER = U95;
		SCATTER X = T Y = D_NQ;
		SERIES 	X = T Y = FORECAST;
		XAXIS GRID; YAXIS GRID;
		WHERE T > 0; REFLINE 100 / AXIS = X;
		RUN;
		
PROC PRINT DATA = Backwards_Projection_NQ1;  

PROC MEANS DATA = Backwards_Projection_NQ1;
  VAR D_NQ;
  VAR FORECAST;
RUN;

data NQ_MSE;
  set Backwards_Projection_NQ1;
  error = D_NQ - FORECAST;
  squared_error = error * error;
  de_mean = D_NQ - -10.8755000; 
  de_mean_sq = de_mean*de_mean;
run;

PROC MEANS DATA = NQ_MSE mean sum;      *D_NQ mean squared error (MSE) is 8509.0341;
  VAR squared_error;                     * average squared mean-deviation is 8508.55;
  Var de_mean_sq;                        * RSE = 1.0000 ;                     
RUN;



*D_SP mean squared error (MSE) is 255.3368;
*D_NQ mean squared error (MSE) is 8509.0341;



/*************************                     Conclusions                                         *********************************/	
/**********************************************************************************************************************************/

*	Granger causality tests show that past values of EFFR are not likely to help forecast Nasdaq prices;
*	could perform a VARMAX model on Nasdaq next time, as the Granger Causality test failed, 
		which suggests that the interest rate is actually exogenous;
*	alternatively, we could use the spread between long term bonds and treasury bills as
		the interest rate, as there is likely a stronger theoretical link between 
		this spread and asset prices;


























