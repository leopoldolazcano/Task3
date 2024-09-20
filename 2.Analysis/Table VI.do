***************************
*Task 2 - Leopoldo Lazcano*
*      QOB Table VI       *
***************************

use "$analysis/use_data.dta", clear

log using "$analysis/QOB_VI.log", replace 
keep if COHORT>40.00


global controls RACE MARRIED SMSA NEWENG MIDATL ENOCENT WNOCENT SOATL ESOCENT WSOCENT MT YR20-YR28
global instruments QTR120-QTR129 QTR220-QTR229 QTR320-QTR329 YR20-YR28

** Col 1 3 5 7 ***
reg  LWKLYWGE EDUC  YR20-YR28 
est sto a1
reg  LWKLYWGE EDUC  YR20-YR28 AGEQ AGEQSQ 
est sto a3
reg  LWKLYWGE EDUC  $controls 
est sto a5
reg  LWKLYWGE EDUC  $controls AGEQ AGEQSQ 
est sto a7

** Col 2 4 6 8 ***
ivregress 2sls LWKLYWGE YR20-YR28 (EDUC = $instruments)
est sto a2
ivregress 2sls LWKLYWGE YR20-YR28 AGEQ AGEQSQ (EDUC = $instruments)
est sto a4
ivregress 2sls LWKLYWGE $controls  (EDUC = $instruments)
est sto a6
ivregress 2sls LWKLYWGE $controls AGEQ AGEQSQ (EDUC = $instruments)
est sto a8

esttab a1 a2 a3 a4 a5 a6 a7 a8 using "$analysis/table6.txt", b(%9.4fc) se(%9.4fc) keep(EDUC RACE SMSA MARRIED AGEQ AGEQSQ) order(EDUC RACE SMSA MARRIED AGEQ AGEQSQ) star(* 0.1 ** 0.05 *** 0.01) noobs replace

log close
