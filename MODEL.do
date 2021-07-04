*Définition du répertoire de travail
cd "C:\Users\Boria\OneDrive - Food and Agriculture Organization\FAO 2020\DL\WORKDIR"
use DL02, clear
append using DL05a	
drop V319r
encode V319, gen(V319r)

*Traitement additionnel des valeurs manquantes
keep V002 y V026	V020	V025	V206	V216	V027	V022	V021	V006	///
	V017	V211	V031	V023	V013	V028	V135	V204	V016	///
	V100	V101	V136	V106	V142	V146 V319r
mi set wide
mi misstable sum
mi register imputed y V006 V013 V016 V017 V020 V021 V022 V023 V025 V026 V027 V028 ///
	V031 V100 V101 V106 V135 V136 V146 V204 V206 V211 V216 V142 V319r
mi impute chained (regress) y V006 V013 V016 V017 V020 V021 V022 V023 V025 V026 ///
	V027 V028 V031 V100 V101 V106 V135 V136 V146 V204 V206 V211 V216 V142 V319r, add(5)
keep V002 y V006 V013 V016 V017 V020 V021 V022 V023 V025 V026 V027 V028 ///
	V031 V100 V101 V106 V135 V136 V146 V204 V206 V211 V216 V142 V319r _5_*
foreach var in V006 V013 V016 V017 V020 V021 V022 V023 V025 V026 V027 V028 ///
	V031 V100 V101 V106 V135 V136 V146 V204 V206 V211 V216 V142 V319r {
	replace `var'=_5_`var' if `var'==.
	drop _5_`var'
	}
egen V319rr=cut(V319r), at(0.01, 1.01, 2.01, 3.01, 4.01, 5.01, 6.01, 7.01) icodes
label define pays 0 "Burkina Faso" 2 "Mali" 3 "Niger" 4 "Senegal" 5 "Cameroun" 1 "Tchad" 6 "Nigeria"
label values V319rr pays
fre V319rr

replace V319rr = 3 in 129
replace V319rr = 3 in 130
replace V319rr = 3 in 131
replace V319rr = 3 in 132
replace V319rr = 3 in 133
replace V319rr = 3 in 134
replace V319rr = 3 in 137
replace V319rr = 3 in 144
replace V319rr = 3 in 146
replace V319rr = 3 in 147
replace V319rr = 3 in 148
replace V319rr = 3 in 149
replace V319rr = 3 in 152
replace V319rr = 3 in 171

save DL03, replace

*Analyse de régression (Minimal)
fracreg logit y V026	V136	V020	V025	V206	V216	V027	V022	///
	V021	V031	V100	V101	V106	V142	V146 i.V319rr
	
*Analyse de régression (Final)
fracreg logit y V026	V020	V025	V206	V216	V027	V022	V021	V006	///
	V017	V211	V031	V023	V013	V028	V135	V204	V016	///
	V100	V101	V136	V106	V142	i.V319rr

*Données complètes pour analyses ultérieures
import excel "C:\Users\USER\OneDrive - Food and Agriculture Organization\FAO 2020\DL\WORKDIR\DMP.xlsx", sheet("Sheet1") firstrow clear
save dmp, replace
merge 1:1 V002 using DL03, nogen
merge 1:1 V002 using DL01
save DL04, replace

/*
*Effet marginaux et estimation des probabilités empiriques
margins, at( V100=(-50(-10)-80)) /*Baisse de la production de Mil*/
margins, at( V106=(-50(-10)-80)) /*Baisse de la production d'Arachide*/
margins V319rr, at( V100=(-50(-10)-80) V101=(-40(-10)-70)) /*Effets combinés par pays Mil et Arachide*/
*/

*Avec le DMP
import excel "C:\Users\Boria\OneDrive - Food and Agriculture Organization\FAO 2020\DL\WORKDIR\BaseConsolidee.xlsx", sheet("Sheet1") firstrow clear
drop V319r V319rr
encode V319, gen(V319r)
lab var V319r "Pays"

replace V319r = 5 in 172
replace V319r = 5 in 173
replace V319r = 5 in 174

*Analyse de régression (Minimal)#1: DMP
fracreg logit y V026	V136	V020	V025	V206	V216	V027	V022	///
	V021	V031	V100	V101	V106	V142	V146 i.V319r DMP
*Analyse de régression (Minimal)#2: DMPC
fracreg logit y V026	V136	V020	V025	V206	V216	V027	V022	///
	V021	V031	V100	V101	V106	V142	V146 i.V319r DMPC

*Analyse de régression (Final)#2: DMPC
fracreg logit y V026	V020	V025	V206	V216	V027	V022	V021	///
	V006	V017	V211	V031	V023	V013	V028	V135	V204	V016	///
	V100	V101	V136	V106	V142	V146 i.V319r DMPC

*Analyse de régression (Final)#1: DMP
asdoc fracreg logit y V026	V020	V025	V206	V216	V027	V022	V021	V006	///
	V017	V211	V031	V023	V013	V028	V135	V204	V016	///
	V100	V101	V136	V106	V142	V146 i.V319r DMP, label

/*Données complètes pour analyses ultérieures
save DL05, replace
	**Ajout Cameroun et Nigeria
	import excel "C:\Users\USER\OneDrive - Food and Agriculture Organization\FAO 2020\DL\WORKDIR\cameroon_nigeria_matrix.xlsx", sheet("Sheet1") firstrow clear
	rename DMPA DMP
	gen y=V318/V003
	save DL05a, replace
	append using DL05
save DL06, replace*/

*Effet marginaux et estimation des probabilités empiriques R1
margins if V319r==1,  at(V100=-25 V101=-25 V106=-70 DMP=-2.37) saving(R1BF, replace) /*R1:BF*/
margins if V319r==2,  at(V100=-25 V101=-25 V106=-70 DMP=-2.37) saving(R1ML, replace) /*R1:ML*/
margins if V319r==3,  at(V100=-25 V101=-25 V106=-70 DMP=-2.37) saving(R1NE, replace) /*R1:NE*/
margins if V319r==4,  at(V100=-70 V101=-70 V106=-50 DMP=-2.37) saving(R1SN, replace) /*R1:SN*/
margins if V319r==5,  at(V100=-5 V101=-5 V106=-10 DMP=-0.87) saving(R1TD, replace) /*R1:TD*/


combomarginsplot R1BF R1TD R1CMR R1ML R1NE R1SN, name(R1, replace) recastci(rarea) ///
     label("Burkina Faso" "Tchad" "Cameroun" "Mali" "Niger" "Sénégal") savefile(R1, replace)
/*combomarginsplot H1SN H1NE H1ML H1TD H1BF , plotdim(_filenumber) ///
     label("Burkina Faso" "Tchad" "Mali" "Niger" "Sénégal") name(H1, replace)*/
	 
*marginsplot, recast(line) recastci(rarea) R2
margins if V319r==1,  at(V100=-70 V101=-70 V106=-50 DMP=-2.37) saving(R2BF, replace) /*R2:BF*/
margins if V319r==3,  at(V100=-70 V101=-70 V106=-50 DMP=-2.37) saving(R2ML, replace) /*R2:ML*/
margins if V319r==4,  at(V100=-5 V101=-5 V106=-10 DMP=-0.87) saving(R2NE, replace) /*R2:NE*/
margins if V319r==5,  at(V100=-25 V101=-25 V106=-70 DMP=-2.37) saving(R2SN, replace) /*R2:SN*/
margins if V319r==2,  at(V100=-25 V101=-25 V106=-70 DMP=-2.37) saving(R2TD, replace) /*R2:TD*/


combomarginsplot R2BF R2TD R2CMR R2ML R2NE R2SN, name(R2, replace) recastci(rarea) ///
     label("Burkina Faso" "Tchad" "Cameroun" "Mali" "Niger" "Sénégal") savefile(R2, replace)

*marginsplot, recast(line) recastci(rarea) R3
margins if V319r==1,  at(V100=-5 V101=-5 V106=-10 DMP=-0.87) saving(R3BF, replace) /*R3:BF*/
margins if V319r==3,  at(V100=-5 V101=-5 V106=-10 DMP=-0.87) saving(R3ML, replace) /*R3:ML*/
margins if V319r==4,  at(V100=-70 V101=-70 V106=-50 DMP=-2.37) saving(R3NE, replace) /*R3:NE*/
margins if V319r==5,  at(V100=-5 V101=-5 V106=-10 DMP=-0.87) saving(R3SN, replace) /*R3:SN*/
margins if V319r==2,  at(V100=-70 V101=-70 V106=-50 DMP=-2.37) saving(R3TD, replace) /*R3:TD*/


*marginsplot, recast(line) recastci(rarea)
combomarginsplot R3BF R3TD R3CMR R3ML R3NE R3SN, name(R3, replace) recastci(rarea) ///
     label("Burkina Faso" "Tchad" "Cameroun" "Mali" "Niger" "Sénégal") savefile(R3, replace)

graph combine R1 R2 R3,  iscale(0.5) ycommon xcommon col(3) name(combined, replace)
*graph display combined, xsize(10)

*Effets marginaux nationaux courants
margins if V319r==1 /*BF*/
margins if V319r==3 /*ML*/
margins if V319r==4 /*NE*/
margins if V319r==5 /*SN*/
margins if V319r==2 /*TD*/
margins /*NG, CMR et MR*/

*Effets marginaux globaux des criquets
margins ,  at(V100=-5 V101=-5 V106=-10 DMP=-0.87) saving(R2NE, replace) /*R2:NE*/
margins ,  at(V100=-25 V101=-25 V106=-70 DMP=-2.37) saving(R2SN, replace) /*R2:SN*/
margins ,  at(V100=-70 V101=-70 V106=-50 DMP=-2.37) saving(R2BF, replace) /*R2:BF*/

