version 14.2
set more off

*Définition du répertoire de travail
cd "C:\Users\Boria\OneDrive - Food and Agriculture Organization\FAO 2020\DL\WORKDIR"
use DL01, clear

*Identification de variables communes /*Traitement sur Excel*/
describe y V001	V002	V003	V004	V005	V006	V007	V008	V009	///
	V010	V011	V012	V013	V014	V015	V016	V017	V018	V019	///
	V020	V021	V022	V023	V024	V025	V026	V027	V028	V029	///
	V030	V031	V041	V042	V047	V053	V082	V086	V087	V089	///
	V100	V101	V102	V106	V108	V135	V136	V137	V138	V142	///
	V143	V144	V145	V146	V183	V204	V206	V211	V212	V213	///
	V214	V215	V216	V218	V219	V220	V273	V274	V275	V276	///
	V277	V278	V279	V280	V281	V282	V283	V284	V285	V286	///
	V287	V288	V289	V290	V291	V292	V293	V294	V295	V296	///
	V297	V298	V299	V300	V301	V302	V303	V304	V305	V306	///
	V307	V308	V309	V310	V311	V312	V313	V314	V315	V316	///
	V317	V318	V319
keep y V001	V002	V003	V004	V005	V006	V007	V008	V009	///
	V010	V011	V012	V013	V014	V015	V016	V017	V018	V019	///
	V020	V021	V022	V023	V024	V025	V026	V027	V028	V029	///
	V030	V031	V041	V042	V047	V053	V082	V086	V087	V089	///
	V100	V101	V102	V106	V108	V135	V136	V137	V138	V142	///
	V143	V144	V145	V146	V183	V204	V206	V211	V212	V213	///
	V214	V215	V216	V218	V219	V220	V273	V274	V275	V276	///
	V277	V278	V279	V280	V281	V282	V283	V284	V285	V286	///
	V287	V288	V289	V290	V291	V292	V293	V294	V295	V296	///
	V297	V298	V299	V300	V301	V302	V303	V304	V305	V306	///
	V307	V308	V309	V310	V311	V312	V313	V314	V315	V316	///
	V317	V318	V319	V142	V146

*Traitement des valeurs manquantes /*Voir aussi Help missings*/
mi set wide
mi misstable summarize 
drop V041	V042	V053	V082	V087	V089	V102	V108	V143	///
	V144	V145	V183	V273	V274	V275	V276	V277	V278	///
	V279	V280	V281	V282	V283	V284	V285	V286	V287	V288	///
	V289	V290	V291	V292	V293	V294	V295	V296	V297	V298	///
	V299	V300	V301	V302	V303	V304	V307	V309	V310	V311	///
	V312
mi unset

*Préparation des variables
encode V319, gen(V319r)
fre V319r
encode V001, gen(V001r)
fre V001r
order V002 V001r y, first
save DL02, replace

*Analyse de corrélation (Général)
corr y V003 V005-V308
corr y V319- V220
	
*Analyse de corrélation (variables d'entrée)
corr y V026	V136	V020	V025	V206	V216	V027	V022	V021	V006	///
	V017	V211	V030	V031	V023	V013	V028	V135	V204	V016	///
	V100	V101	V106	V142	V146
