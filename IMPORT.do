*Définition du répertoire de travail
cd "C:\Users\Boria\OneDrive - Food and Agriculture Organization\FAO 2020\DL\WORKDIR"

*Mali
	**Importation des données
	import excel "C:\Users\Boria\OneDrive - Food and Agriculture Organization\FAO 2020\DL\WORKDIR\Mali_Matrice_intermediaire_copy.xlsx", sheet("Matrice intermediaire") firstrow clear

	**Création de la variable réponse
	destring V003, replace
		***Vérification
		gen s = V315+V316+V317
		tabstat s V318, stats(sum mean sd)
		drop s
	gen y = V318/V003
		
save DL_ML, replace

*Niger
	**Importation des données
	import excel "C:\Users\Boria\OneDrive - Food and Agriculture Organization\FAO 2020\DL\WORKDIR\Niger_Matrice_intermediaire_ACC_DRAFT.xlsx", sheet("Matrice_intermediaire_2") firstrow clear

	**Création de la variable réponse
	destring V003, replace
		***Vérification
		gen s = V315+V316+V317
		tabstat s V318, stats(sum mean sd)
		drop s
	gen y = V318/V003
	
save DL_NE, replace

*Tchad
	**Importation des données
	import excel "C:\Users\Boria\OneDrive - Food and Agriculture Organization\FAO 2020\DL\WORKDIR\Matrice_intermediaire_CHAD Final.xlsx", sheet("Matrice intermediaire (2)") firstrow clear

	**Création de la variable réponse
	destring V003, replace
		***Vérification
		gen s = V315+V316+V317
		tabstat s V318, stats(sum mean sd)
	gen y = s/V003
	drop s
	
save DL_TD, replace

*Burkina
	**Importation des données
	import excel "C:\Users\Boria\OneDrive - Food and Agriculture Organization\FAO 2020\DL\WORKDIR\Burkina_Matrice_intermediaire.xlsx", sheet("Matrice intermediaire (2)") firstrow clear

	**Création de la variable réponse
	destring V003, replace
		***Vérification
		gen s = V315+V316+V317
		tabstat s V318, stats(sum mean sd)
		drop s
	gen y = V318/V003
	
save DL_BF, replace

*Senegal
	**Importation des données
	import excel "C:\Users\Boria\OneDrive - Food and Agriculture Organization\FAO 2020\DL\WORKDIR\Senegal_Matrice_intermediaire.xlsx", sheet("Matrice intermediaire (2)") cellrange(A1:FL46) firstrow clear

	**Création de la variable réponse
	destring V003, replace
		***Vérification
		gen s = V315+V316+V317
		tabstat s V318, stats(sum mean sd)
		drop s
	replace V318=0 if V318==.
	gen y = V318/V003
	
save DL_SN, replace

*Fusion des données

*Fichiers aggrégé
clear
foreach file in DL_BF.dta DL_ML.dta DL_NE.dta DL_SN.dta DL_TD.dta {
		append using "`file'", force
		drop if V001==""
		}
save DL01, replace

*Labélisation des variables
lab var V001 ADMIN1Name
lab var V002 ADMIN2Name
lab var V003 Population
lab var V004 Geocode
lab var V005 FCG_Poor
lab var V006 FCG_Borderline
lab var V007 FCG_Acceptable
lab var V008 FCG_finalphase
lab var V009 HDDS_Phase1
lab var V010 HDDS_Phase2
lab var V011 HDDS_Phase3
lab var V012 HDDS_Phase4
lab var V013 HDDS_Phase5
lab var V014 HDDS_finalphase
lab var V015 HHS_Phase1
lab var V016 HHS_Phase2
lab var V017 HHS_Phase3
lab var V018 HHS_Phase4
lab var V019 HHS_Phase5
lab var V020 HHS_finalphase
lab var V021 LhHCSCat_NoStrategies
lab var V022 LhHCSCat_StressStrategies
lab var V023 LhHCSCat_CrisisStategies
lab var V024 LhHCSCat_EmergencyStrategies
lab var V025 LhHCSCat_finalphase
lab var V026 rCSI_Phase1
lab var V027 rCSI_Phase2
lab var V028 rCSI_Phase3
lab var V029 rCSI_finalphase
lab var V030 01_choc_subi_Non
lab var V031 01_choc_subi_Oui
lab var V032 01_mdo_rougeole_cas_jan_feb_2019
lab var V033 01_mdo_rougeole_cas_jan_feb_2020
lab var V034 01_mdo_meningite_cas_jan_feb_2019
lab var V035 01_mdo_meningite_cas_jan_feb_2020
lab var V036 01_mdo_palu_cas_jan_feb_2019
lab var V037 01_mdo_palu_cas_jan_feb_2020
lab var V038 01_mdo_cholera_cas_jan_feb_2019
lab var V039 01_mdo_cholera_cas_jan_feb_2020
lab var V040 02__hh_perte_Sup_
lab var V041 02_choc_secheresse
lab var V042 02_choc_inondation
lab var V043 02_epizootie_
lab var V044 02__hh_PDI_conflit_intercom
lab var V045 02__hh_PDI_conflit_intracom
lab var V046 02__hh_PDI_conflit_group_armes
lab var V047 03_insecurite_civile_vol
lab var V048 02_nature_choc_subi_maladies_epidemies
lab var V049 02_nature_choc_subi_Catastrophes_naturelles
lab var V050 02_nature_choc_subi_flambee_prix
lab var V051 02_nature_choc_subi_pas_choc
lab var V052 02_choc_ennemis_culture
lab var V053 02_choc_autres
lab var V054 03_moyenne_Sup_infestees_ha_campagne_phytosanitaire
lab var V055 03_nobr_evenemt_violents
lab var V056 03_nbr_person_mortes
lab var V057 03_choc_ennemis_culture_irriguee_1_leger_2_moyen
lab var V058 03_moyenne_Sup_prospectees_ha_oiseaux_granivores
lab var V059 03_moyenne_Sup_traitees_ha_campagne_phytosanitaire
lab var V060 03_moyenne_Sup_traitees_ha_oiseaux_granivores
lab var V061 03_sup_brulees_ha
lab var V062 4__PDI
lab var V063 04_moyenne_Sup_detruite_ennemis_culture
lab var V064 04_grosses_precoces
lab var V065 04_mariages_precoces
lab var V066 04_taux_scolarisation_filles_elementaire
lab var V067 04_taux_scolarisation_filles_moyen
lab var V068 04_taux_scolarisation_filles_secondaire
lab var V069 04_violences_basees_sur_genre
lab var V070 06__HH_contraintes_acces_marche1
lab var V071 06__HH_contraintes_acces_marche2
lab var V072 06_possession_0_ubt
lab var V073 06_possession_1_ubt
lab var V074 06_possession_2_ubt
lab var V075 06_possession_3_ubt
lab var V076 06_possession_ubt_4_ubt_et_plus
lab var V077 06_evolution_cheptel_baisse
lab var V078 06_evolution_cheptel_stabilite
lab var V079 06_evolution_cheptel_hausse
lab var V080 07_Difficulte_appro_HH
lab var V081 07_Endettement_en_progression_1an
lab var V082 06_Tarissement_marre
lab var V086 06_taux_endettement
lab var V087 07_depart_menages
lab var V088 08_pers_assist_pop_total_
lab var V089 08_Acces_financement
lab var V091 08_aucun_bien_durable
lab var V092 08_hausse_biens_durables
lab var V093 08_stabilite_biens_durables
lab var V094 08_baisse_biens_durables
lab var V095 09_destockage_Non
lab var V096 09_destockage_Oui
lab var V097 10_vente_femelle_repro_Non
lab var V098 10_vente_femelle_repro_Oui
lab var V099 11_campagne_hivernage_moy_a_bonne
lab var V100 11_Var_prod_Moy_5_Mil
lab var V101 11_Var_prod_Moy_5_sorgho
lab var V102 11_Var_prod_Moy_5_riz
lab var V103 11_Var_prod_Moy_5_berbere
lab var V104 11_Var_prod_Moy_5_cerea
lab var V105 11_evo_mais_5y
lab var V106 12_Var_prod_Moy_5_arachide
lab var V107 12_Var_prod_Moy_5_niebe
lab var V108 12_Var_prod_Moy_5_sesam
lab var V109 11_Var_prod_Moy_5_mais
lab var V110 12_evo_coton_5y
lab var V111 12_camp_ctre_saison_tresbonne_a_moy
lab var V112 12_evo_couverture_besoinsalimentaire_5y
lab var V113 12_evo_couverture_besoinsfourager_5y
lab var V114 12_Var_prod_Moy_5_total_rente
lab var V115 13_Paturage_bon_a_moy
lab var V116 13_bilan_fourrager_normalise
lab var V117 13_Part_achat_alim_Femme
lab var V118 13_Part_achat_alim_Homme
lab var V119 14_Part_autoconso_Femme
lab var V120 14_Part_autoconso_Homme
lab var V122 14_conditions_abreuvement_bonne_a_moy
lab var V123 14_Production_peche_artisanale_continentale_5y
lab var V124 15_Anomalie_Eau_surface
lab var V125 15_Product_laitier_journ_an_normale_bonne_a_moy
lab var V126 16_appro_march_bon_a_moy
lab var V127 17_mises_bas_gros_ruminants_import_a_moy
lab var V128 18_nvdi_var_moy
lab var V129 18_nvdi_var_an_moins1
lab var V130 19_cueillet_graminee_sauvag_moy_a_bonne
lab var V131 20_compar_product_region_tx_pr_rapp_18_19
lab var V132 20_compar_product_region_tx_pr_rapp_taux_moy
lab var V137 26_Indice_richesse_Final_Quintile_de_richesse_moyen
lab var V138 26_Indice_richesse_Final_Quintile_de_richesse_nanti
lab var V136 26_Indice_richesse_Final_Quintile_de_richesse_pauvre
lab var V135 26_Indice_richesse_Final_Quintile_de_richesse_tres_pauvre
lab var V139 26_Indice_richesse_Final_Quintile_richesse_tres_riche
lab var V140 28_appartient_au_Quintile_richesse_plus_pauvre_plus_bas
lab var V141 28_Appartient_pas_au_Quintile_richesse_plus_bas
lab var V142 27_evo_mil_5y
lab var V143 27_evo_sorgho_5y
lab var V144 27_evo_riz_5y
lab var V145 27_evo_mais_5y
lab var V146 27_evo_arachide_5y
lab var V147 27_evo_niebe_5y
lab var V148 27_evo_sesame_5y
lab var V149 27_evo_oignon_5y
lab var V150 28_evo_sesame_5y
lab var V151 28_evo_coton_5y
lab var V152 28_evo_prix_mil_1a
lab var V153 28_evo_prix_sorgho_1a
lab var V154 28_evo_prix_rizimp_1a
lab var V155 28_evo_prix_mais_1a
lab var V156 29_evo_prix_chevre_5a
lab var V157 29_evo_prix_mouton_5a
lab var V158 29_evo_prix_boeuf_5a
lab var V159 30_evo_prix_chevre_1a
lab var V160 30_evo_prix_mouton_1a
lab var V161 30_evo_prix_boeuf_1a
lab var V162 28_evo_arachide_5y
lab var V163 28_evo_niebe_5y
lab var V164 28_evo_bovin_5y
lab var V165 28_evo_ovin_5y
lab var V166 28_evo_caprin_5y
lab var V167 28_evo_TDE_betail_5y
lab var V168 28_evo_TDE_Niebe_5y
lab var V169 28_evo_TDE_oignon_5y
lab var V170 28_evo_TDE_poivronseche_5y
lab var V171 31_evo_TDE_chevre_mil_5y
lab var V172 31_evo_TDE_chevre_mil_1y
lab var V173 29_Var_tde_ovin_sur_mil_moy5
lab var V174 29_Var_tde_ovin_sur_sorgho_moy5
lab var V175 29_Var_tde_ovin_sur_mais_moy5
lab var V176 29_Var_tde_caprin_sur_mil_moy5
lab var V177 29_Var_tde_caprin_sur_sorgho_moy5
lab var V178 29_Var_tde_caprin_sur_mais_moy5
lab var V179 29_Var_tde_ara_sur_sorgho_moy5
lab var V180 29_Var_tde_sesame_sur_sorgho_moy5
lab var V181 061_moyenne_nombre_sources_revenus
lab var V183 29_PDAM_r_0_50
lab var V184 29_PDAM_r_50_65
lab var V185 29_PDAM_r_65_75
lab var V186 29_PDAM_r_plus_75
lab var V187 29_Couverture_MEB_Non
lab var V188 29_Couverture_MEB_Oui
lab var V189 30_Distance_Boutique_Marche_1_5_km
lab var V190 30_Distance_Boutique_Marche_moins_1_km
lab var V191 30_Distance_Boutique_Marche_plus_5_km
lab var V192 33_Evolution_revenu_Hausse
lab var V193 33_Evolution_revenu_stable
lab var V194 33_Evolution_revenu_Baisse
lab var V195 34_Cause_Contraintes_AGR_manque_opportiné
lab var V196 34_Cause_Contraintes_AGR_manque_argent
lab var V197 34_Cause_Contraintes_AGR_perte_moyen_production
lab var V198 34_Cause_Contraintes_AGR_Absence_marché
lab var V199 34_Cause_Contraintes_AGR_bas_prix
lab var V200 34_Cause_Contraintes_AGR_insécurité
lab var V201 34_Cause_Contraintes_AGR_vulnérabilité
lab var V202 33_Distance_point_deau_moins30mn
lab var V203 33_Distance_point_deau_plus30mn
lab var V204 41_acces_eau_potable
lab var V205 41_vol_eau_pers_jour
lab var V206 42_moyenne_nombre_repas_enfant
lab var V207 42_proportion_menage_1_repas
lab var V208 42_proportion_menage_2_repas
lab var V209 42_proportion_menage_3_repas
lab var V210 42_proportion_menage_4_repas
lab var V211 43_energie_cuisson_aliment_Bois_chauffe
lab var V212 43_energie_cuisson_aliment_Bouses_vache
lab var V213 43_energie_cuisson_aliment_Charbon
lab var V214 43_energie_cuisson_aliment_Electricité
lab var V215 43_energie_cuisson_aliment_Gaz
lab var V216 43_energie_cuisson_aliment_autres
lab var V217 44_diversit_alimentaire_minimale
lab var V218 45_toilette_latrine_ameliore
lab var V219 45_toilette_latrine_non_ameliore
lab var V220 45_toilette_latrine_nature
lab var V221 44_admission_24_59_mois
lab var V222 44_admission_6_23_mois
lab var V223 44_admission_moins_6_mois
lab var V224 44_admission_plus_59_mois
lab var V225 44_admission_total_mois
lab var V226 45_morbidite_deparasitage_curatif_12_59_mois_feminin
lab var V227 45_morbidite_deparasitage_curatif_12_59_mois_masculin
lab var V228 45_morbidite_deparasitage_preventif_12_59_mois_feminin
lab var V229 45_morbidite_deparasitage_preventif_12_59_mois_masculin
lab var V230 45_morbidite_pec_diarrhee_0_59_mois_feminin
lab var V231 45_morbidite_pec_diarrhee_0_59_mois_masculin
lab var V320 45_morbidite_pec_infections_respiratoires_0_59_mois_masculin
lab var V232 45_morbidite_pec_infections_respiratoires_0_59_mois_feminin
lab var V233 45_morbidite_vitamine_a_curatif_6_59_mois_feminin
lab var V234 45_morbidite_vitamine_a_curatif_6_59_mois_masculin
lab var V235 45_morbidite_vitamine_a_preventif_6_59_mois_feminin
lab var V236 45_morbidite_vitamine_a_preventif_6_59_mois_masculin
lab var V237 46_regime_alimentaire_minimal_acceptable
lab var V238 46_moyenne_nombre_repas_adulte
lab var V239 47_moyenne_nombre_groupe_aliments
lab var V240 46_SDAIF
lab var V241 47_allaitement_exclusif_moins_de_6mois
lab var V242 47_diversite_alimentaire_minimale_6_23_mois_oui
lab var V243 47_frequence_minimale_repas_6_23_mois_oui_
lab var V244 47_Maladies_chroniques_oui
lab var V245 48_Maladie_HH_Palu
lab var V246 45_morbidite_pec_diarrhee_0_59_mois_total
lab var V247 49_taux_anémie_chez_enfants_moins_5ans
lab var V248 45_morbidite_pec_infections_respiratoires_0_59_mois_total
lab var V249 45_morbidite_deparasitage_total_12_59_mois
lab var V250 48_Maladie_HH_Dermatoses
lab var V251 47_ANJE_9_allaitez_vous_toujours_enfant_oui
lab var V252 49_mise_sein_precoce
lab var V253 49_enfant_recu_colostrum
lab var V254 50_taux_anémie_femmes_non_enceintes
lab var V255 51_taux_supplémentation_vitamine_A_enfant
lab var V256 52_taux_couverture_programme_PECIMA_admissions_programmes_thérapeutiques_nutritionnels
lab var V257 56_duree_stockalimentair_0_1mois
lab var V258 56_duree_stockalimentair_2mois
lab var V259 56_duree_stockalimentair_3mois
lab var V260 56_duree_stockalimentair_4mois
lab var V261 56_duree_stockalimentair_5mois_et_plus
lab var V262 56_Evolution_stocks_baisse
lab var V263 56_Evolution_stocks_hausse
lab var V264 56_Evolution_stocks_stabilite
lab var V265 56_duree_stock_cereale_0_1_semaine
lab var V266 56_duree_stock_cereale_1_4_semaines
lab var V267 56_duree_stock_cereale_4_8_semaines
lab var V268 56_duree_stock_cereale_plus_8_semaines
lab var V269 57_degradation_situation_alimentaire_janv_mars
lab var V270 57_Degradation_Situation_alimentaire_juin_août
lab var V271 58_Depart_bras_valides_oui
lab var V272 58_Depart_bras_valides_inhabituel
lab var V273 Z1_DPME_C
lab var V274 Z1_DPME_pop_C
lab var V275 Z1_DPME_Pr
lab var V276 Z1_DS_C
lab var V277 Z1_DS_Pr
lab var V278 Z1_Pop_DPME_Pr
lab var V279 Z1_Pop_DS_C
lab var V280 Z1_pop_DS_Pr
lab var V281 Z2_DPME_C
lab var V282 Z2_DPME_pop_C
lab var V283 Z2_DPME_Pr
lab var V284 Z2_DS_C
lab var V285 Z2_DS_Pr
lab var V286 Z2_Pop_DPME_Pr
lab var V287 Z2_Pop_DS_C
lab var V288 Z2_pop_DS_Pr
lab var V289 Z3_DPME_C
lab var V290 Z3_DPME_pop_C
lab var V291 Z3_DPME_Pr
lab var V292 Z3_DS_C
lab var V293 Z3_DS_Pr
lab var V294 Z3_Pop_DPME_Pr
lab var V295 Z3_Pop_DS_C
lab var V296 Z3_pop_DS_Pr
lab var V297 Z4_DPME_C
lab var V298 Z4_DPME_pop_C
lab var V299 Z4_DPME_Pr
lab var V300 Z4_DS_C
lab var V301 Z4_DS_Pr
lab var V302 Z4_Pop_DPME_Pr
lab var V303 Z4_Pop_DS_C
lab var V304 Z4_pop_DS_Pr
lab var V305 Proxy_cal
lab var V306 MAG_pt
lab var V307 MAG_Pharv
lab var V308 MAG_Soud
lab var V309 IMC
lab var V310 MUAC
lab var V311 TBM
lab var V312 TMM5
lab var V313 Phase1
lab var V314 Phase2
lab var V315 Phase3
lab var V316 Phase4
lab var V317 Phase5
lab var V318 Phase35
lab var V319 Pays
