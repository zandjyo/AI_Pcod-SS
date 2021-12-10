#V3.30.18.00;_safe;_compile_date:_Sep 30 2021;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_12.3
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-stock-synthesis/stock-synthesis

#_data_and_control_files: AIPcod2021.dat // AIPCOD21.ctl
0  # 0 means do not read wtatage.ss; 1 means read and use wtatage.ss and also read and use growth parameters
1  #_N_Growth_Patterns (Growth Patterns, Morphs, Bio Patterns, GP are terms used interchangeably in SS)
1 #_N_platoons_Within_GrowthPattern 
#_Cond 1 #_Platoon_within/between_stdev_ratio (no read if N_platoons=1)
#_Cond  1 #vector_platoon_dist_(-1_in_first_val_gives_normal_approx)
#
4 # recr_dist_method for parameters:  2=main effects for GP, Area, Settle timing; 3=each Settle entity; 4=none (only when N_GP*Nsettle*pop==1)
1 # not yet implemented; Future usage: Spawner-Recruitment: 1=global; 2=by area
1 #  number of recruitment settlement assignments 
0 # unused option
#GPattern month  area  age (for each settlement assignment)
 1 1 1 0
#
#_Cond 0 # N_movement_definitions goes here if Nareas > 1
#_Cond 1.0 # first age that moves (real age at begin of season, not integer) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1 dest=2, age1=4, age2=10
#
6 #_Nblock_Patterns
 1 4 1 1 1 1 #_blocks_per_pattern 
# begin and end years of blocks
 1980 1986
 1990 2004 2005 2006 2007 2016 2017 2021
 2017 2021
 2014 2016
 1976 1976
 1976 2006
#
# controls for all timevary parameters 
1 #_time-vary parm bound check (1=warn relative to base parm bounds; 3=no bound check); Also see env (3) and dev (5) options to constrain with base bounds
#
# AUTOGEN
 1 1 1 1 1 # autogen: 1st element for biology, 2nd for SR, 3rd for Q, 4th reserved, 5th for selex
# where: 0 = autogen time-varying parms of this category; 1 = read each time-varying parm line; 2 = read then autogen if parm min==-12345
#
#_Available timevary codes
#_Block types: 0: P_block=P_base*exp(TVP); 1: P_block=P_base+TVP; 2: P_block=TVP; 3: P_block=P_block(-1) + TVP
#_Block_trends: -1: trend bounded by base parm min-max and parms in transformed units (beware); -2: endtrend and infl_year direct values; -3: end and infl as fraction of base range
#_EnvLinks:  1: P(y)=P_base*exp(TVP*env(y));  2: P(y)=P_base+TVP*env(y);  3: P(y)=f(TVP,env_Zscore) w/ logit to stay in min-max;  4: P(y)=2.0/(1.0+exp(-TVP1*env(y) - TVP2))
#_DevLinks:  1: P(y)*=exp(dev(y)*dev_se;  2: P(y)+=dev(y)*dev_se;  3: random walk;  4: zero-reverting random walk with rho;  5: like 4 with logit transform to stay in base min-max
#_DevLinks(more):  21-25 keep last dev for rest of years
#
#_Prior_codes:  0=none; 6=normal; 1=symmetric beta; 2=CASAL's beta; 3=lognormal; 4=lognormal with biascorr; 5=gamma
#
# setup for M, growth, wt-len, maturity, fecundity, (hermaphro), recr_distr, cohort_grow, (movement), (age error), (catch_mult), sex ratio 
#_NATMORT
0 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate;_5=BETA:_Maunder_link_to_maturity
  #_no additional input for selected M option; read 1P per morph
#
1 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_specific_K_incr; 4=age_specific_K_decr; 5=age_specific_K_each; 6=NA; 7=NA; 8=growth cessation
0.5 #_Age(post-settlement)_for_L1;linear growth below this
999 #_Growth_Age_for_L2 (999 to use as Linf)
-999 #_exponential decay for growth above maxage (value should approx initial Z; -999 replicates 3.24; -998 to not allow growth above maxage)
0  #_placeholder for future growth feature
#
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
2 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
#
1 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=disabled; 6=read length-maturity
1 #_First_Mature_Age
1 #_fecundity option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=female-to-male age-specific fxn; -1=male-to-female age-specific fxn
1 #_parameter_offset_approach for M, G, CV_G:  1- direct, no offset**; 2- male=fem_parm*exp(male_parm); 3: male=female*exp(parm) then old=young*exp(parm)
#_** in option 1, any male parameter with value = 0.0 and phase <0 is set equal to female parameter
#
#_growth_parms
#_ LO HI INIT PRIOR PR_SD PR_type PHASE env_var&link dev_link dev_minyr dev_maxyr dev_PH Block Block_Fxn
# Sex: 1  BioPattern: 1  NatMort
 0.1 1.5 0.330667 -0.81 0.41 3 10 0 0 0 0 0 0 0 # NatM_uniform_Fem_GP_1
# Sex: 1  BioPattern: 1  Growth
 -10 50 1.08747 -0.102 99 0 1 0 0 0 0 0 0 0 # L_at_Amin_Fem_GP_1
 70 130 115.301 123.8 0.015 0 1 0 0 0 0 0 0 0 # L_at_Amax_Fem_GP_1
 0 1 0.198675 0.1645 0.03 0 1 0 0 0 0 0 0 0 # VonBert_K_Fem_GP_1
 0 10 7.16226 0 0 0 10 0 0 0 0 0 0 0 # SD_young_Fem_GP_1
 0 20 5.40558 0 0 0 10 0 0 0 0 0 0 0 # SD_old_Fem_GP_1
# Sex: 1  BioPattern: 1  WtLen
 -99 99 5.611e-06 0 0 0 -3 0 0 0 0 0 0 0 # Wtlen_1_Fem_GP_1
 -99 99 3.1756 0 0 0 -3 0 0 0 0 0 0 0 # Wtlen_2_Fem_GP_1
# Sex: 1  BioPattern: 1  Maturity&Fecundity
 -99 99 54.9 0 0 0 -1 0 0 0 0 0 0 0 # Mat50%_Fem_GP_1
 -99 99 -0.1472 0 0 0 -1 0 0 0 0 0 0 0 # Mat_slope_Fem_GP_1
 -99 99 1 0 0 0 -1 0 0 0 0 0 0 0 # Eggs/kg_inter_Fem_GP_1
 -99 99 0 0 0 0 -1 0 0 0 0 0 0 0 # Eggs/kg_slope_wt_Fem_GP_1
# Hermaphroditism
#  Recruitment Distribution  
#  Cohort growth dev base
 0.1 10 1 1 1 0 -1 0 0 0 0 0 0 0 # CohortGrowDev
#  Movement
#  Age Error from parameters
 -10 10 3 0 0 0 -5 0 0 0 0 0 0 0 # AgeKeyParm1
 -10 10 0 0 0 0 -10 0 0 0 0 0 6 2 # AgeKeyParm2
 -10 10 0 0 0 0 -10 0 0 0 0 0 6 2 # AgeKeyParm3
 -10 10 0 0 0 0 -1 0 0 0 0 0 0 0 # AgeKeyParm4
 -10 10 0.57 0 0 0 -1 0 0 0 0 0 0 0 # AgeKeyParm5
 -10 10 1.16 0 0 0 -1 0 0 0 0 0 0 0 # AgeKeyParm6
 -10 10 0 0 0 0 -1 0 0 0 0 0 0 0 # AgeKeyParm7
#  catch multiplier
#  fraction female, by GP
 1e-06 0.999999 0.5 0.5 0.5 0 -99 0 0 0 0 0 0 0 # FracFemale_GP_1
#  M2 parameter for each predator fleet
#
# timevary MG parameters 
#_ LO HI INIT PRIOR PR_SD PR_type  PHASE
 -10 10 0.254703 0 0 0 1 # AgeKeyParm2_BLK6repl_1976
 -10 10 -1.03122 0 0 0 1 # AgeKeyParm3_BLK6repl_1976
# info on dev vectors created for MGparms are reported with other devs after tag parameter section 
#
#_seasonal_effects_on_biology_parms
 0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K
#_ LO HI INIT PRIOR PR_SD PR_type PHASE
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters
#
3 #_Spawner-Recruitment; Options: 1=NA; 2=Ricker; 3=std_B-H; 4=SCAA; 5=Hockey; 6=B-H_flattop; 7=survival_3Parm; 8=Shepherd_3Parm; 9=RickerPower_3parm
0  # 0/1 to use steepness in initial equ recruitment calculation
0  #  future feature:  0/1 to make realized sigmaR a function of SR curvature
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn #  parm_name
            10            20       10.4557             0             0             0          1          0          0          0          0          0          0          0 # SR_LN(R0)
             0             1             1             1             0             0         -1          0          0          0          0          0          0          0 # SR_BH_steep
             0            10      0.714909          0.44             0             0          1          0          0          0          0          0          0          0 # SR_sigmaR
            -5             5             0             0             0             0         -3          0          0          0          0          0          0          0 # SR_regime
           -99            99             0             0             0             0         -1          0          0          0          0          0          0          0 # SR_autocorr
#_no timevary SR parameters
2 #do_recdev:  0=none; 1=devvector (R=F(SSB)+dev); 2=deviations (R=F(SSB)+dev); 3=deviations (R=R0*dev; dev2=R-f(SSB)); 4=like 3 with sum(dev2) adding penalty
1978 # first year of main recr_devs; early devs can preceed this era
2016 # last year of main recr_devs; forecast devs start in following year
1 #_recdev phase 
1 # (0/1) to read 13 advanced options
 1967 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
 2 #_recdev_early_phase
 0 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
 1 #_lambda for Fcast_recr_like occurring before endyr+1
 1964.4 #_last_yr_nobias_adj_in_MPD; begin of ramp
 1979.7 #_first_yr_fullbias_adj_in_MPD; begin of plateau
 2012.9 #_last_yr_fullbias_adj_in_MPD
 2017 #_end_yr_for_ramp_in_MPD (can be in forecast to shape ramp, but SS sets bias_adj to 0.0 for fcast yrs)
 0.9089 #_max_bias_adj_in_MPD (typical ~0.8; -3 sets all years to 0.0; -2 sets all non-forecast yrs w/ estimated recdevs to 1.0; -1 sets biasadj=1.0 for all yrs w/ recdevs)
 0 #_period of cycles in recruitment (N parms read below)
 -5 #min rec_dev
 5 #max rec_dev
 0 #_read_recdevs
#_end of advanced SR options
#
#_placeholder for full parameter lines for recruitment cycles
# read specified recr devs
#_Yr Input_value
#
# all recruitment deviations
#  1967E 1968E 1969E 1970E 1971E 1972E 1973E 1974E 1975E 1976E 1977E 1978R 1979R 1980R 1981R 1982R 1983R 1984R 1985R 1986R 1987R 1988R 1989R 1990R 1991R 1992R 1993R 1994R 1995R 1996R 1997R 1998R 1999R 2000R 2001R 2002R 2003R 2004R 2005R 2006R 2007R 2008R 2009R 2010R 2011R 2012R 2013R 2014R 2015R 2016R 2017F 2018F 2019F 2020F 2021F 2022F 2023F 2024F 2025F 2026F 2027F 2028F 2029F 2030F 2031F 2032F 2033F 2034F 2035F 2036F
#  -1.49122 -0.991038 -1.1485 -1.28823 -1.3765 -1.33801 -1.01016 -0.680195 -0.445941 -0.350087 -0.163821 -0.158305 0.216443 -0.144587 -0.658736 -0.406519 0.538071 0.426275 1.20383 0.817315 0.603244 0.762785 0.761155 0.612712 0.184922 0.929949 0.623644 0.245909 1.03227 0.950988 0.314073 0.797578 0.722584 0.525839 0.00606539 0.310939 -0.33111 0.380874 -0.362985 0.511884 0.308888 -0.287999 -0.0204062 -0.0674688 -0.0700052 0.328019 0.446749 0.651083 0.373953 0.374304 -0.239271 -0.290588 -0.0512716 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
#
#Fishing Mortality info 
1e-06 # F ballpark value in units of annual_F
-1980 # F ballpark year (neg value to disable)
3 # F_Method:  1=Pope midseason rate; 2=F as parameter; 3=F as hybrid; 4=fleet-specific parm/hybrid (#4 is superset of #2 and #3 and is recommended)
5 # max F (methods 2-4) or harvest fraction (method 1)
5  # N iterations for tuning in hybrid mode; recommend 3 (faster) to 5 (more precise if many fleets)
#
#_initial_F_parms; for each fleet x season that has init_catch; nest season in fleet; count = 2
#_for unconstrained init_F, use an arbitrary initial catch and set lambda=0 for its logL
#_ LO HI INIT PRIOR PR_SD  PR_type  PHASE
 -10 10 0.0135611 0 0 0 1 # InitF_seas_1_flt_1FshTrawl
 -10 10 0.00538031 0 0 0 1 # InitF_seas_1_flt_2FshLL
#
# F rates by fleet x season
# Yr:  1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019 2020 2021 2022 2023 2024 2025 2026 2027 2028 2029 2030 2031 2032 2033 2034 2035 2036
# seas:  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
# FshTrawl 0.0589829 0.0487574 0.0813147 0.0460406 0.069849 0.0661243 0.0607968 0.0693062 0.0605332 0.0769801 0.117203 0.0741668 0.0681867 0.0459925 0.0227379 0.076415 0.192565 0.110121 0.0919509 0.171002 0.168441 0.169951 0.132547 0.200417 0.122589 0.247932 0.367069 0.26641 0.171539 0.192816 0.332148 0.330952 0.386107 0.392962 0.186569 0.170981 0.136755 0.126445 0.159992 0.186139 0.128333 0.140125 0.119258 0.0373306 0.0267902 0.247026 0.247026 0.247026 0.247026 0.247026 0.247026 0.247026 0.247026 0.247026 0.247026 0.247026 0.247026 0.247026 0.247026 0.247026
# FshLL 0.0226783 0.0185505 0.0126869 0.00268843 0.00304939 0.00512768 0.0042264 0.00749876 0.00772236 0 0 0.00148246 0.00216625 0.00437343 0.0165867 0.113506 0.0839167 0.0342997 0.0263382 0.0293686 0.0371542 0.0737293 0.0450974 0.100916 0.0938196 0.0161959 0.00508328 0.0165059 0.017693 0.0215524 0.0319956 0.0477343 0.0522894 0.0804195 0.0125104 0.0332795 0.0243814 0.00428284 0.0289526 0.022361 0.0397384 0.0297056 0.0260605 0.023115 0.0216488 0.0569809 0.0569809 0.0569809 0.0569809 0.0569809 0.0569809 0.0569809 0.0569809 0.0569809 0.0569809 0.0569809 0.0569809 0.0569809 0.0569809 0.0569809
# FshPot 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.0181534 0.0344428 0 0.000847728 0.00578408 0.0265558 0.00344436 0.00262051 0.02419 0.0205498 0.00358893 4.44646e-05 1.62627e-05 1.45412e-06 3.38682e-07 0.00389284 0.00791836 0.0328818 0.022017 0.0307865 0.00292991 0.0316465 0.0425192 0.0391316 0 0 0.0306575 0.0705136 0.059021 0.0531007 0.0552025 0.0862078 0.0862078 0.0862078 0.0862078 0.0862078 0.0862078 0.0862078 0.0862078 0.0862078 0.0862078 0.0862078 0.0862078 0.0862078 0.0862078 0.0862078
#
#_Q_setup for fleets with cpue or survey data
#_1:  fleet number
#_2:  link type: (1=simple q, 1 parm; 2=mirror simple q, 1 mirrored parm; 3=q and power, 2 parm; 4=mirror with offset, 2 parm)
#_3:  extra input for link, i.e. mirror fleet# or dev index number
#_4:  0/1 to select extra sd parameter
#_5:  0/1 for biasadj or not
#_6:  0/1 to float
#_   fleet      link link_info  extra_se   biasadj     float  #  fleetname
         4         1         0         0         0         0  #  Srv
         5         1         0         0         0         0  #  LLSrv
-9999 0 0 0 0 0
#
#_Q_parms(if_any);Qunits_are_ln(q)
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
           -10            10             0             0            99             0        -10          0          0          0          0          0          0          0  #  LnQ_base_Srv(4)
           -10            10       1.71002             0            99             0          1          0          0          0          0          0          0          0  #  LnQ_base_LLSrv(5)
#_no timevary Q parameters
#
#_size_selex_patterns
#Pattern:_0;  parm=0; selex=1.0 for all sizes
#Pattern:_1;  parm=2; logistic; with 95% width specification
#Pattern:_2;  parm=6; modification of pattern 24 with improved sex-specific offset
#Pattern:_5;  parm=2; mirror another size selex; PARMS pick the min-max bin to mirror
#Pattern:_11; parm=2; selex=1.0  for specified min-max population length bin range
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_6;  parm=2+special; non-parm len selex
#Pattern:_43; parm=2+special+2;  like 6, with 2 additional param for scaling (average over bin range)
#Pattern:_8;  parm=8; double_logistic with smooth transitions and constant above Linf option
#Pattern:_9;  parm=6; simple 4-parm double logistic with starting length; parm 5 is first length; parm 6=1 does desc as offset
#Pattern:_21; parm=2+special; non-parm len selex, read as pairs of size, then selex
#Pattern:_22; parm=4; double_normal as in CASAL
#Pattern:_23; parm=6; double_normal where final value is directly equal to sp(6) so can be >1.0
#Pattern:_24; parm=6; double_normal with sel(minL) and sel(maxL), using joiners
#Pattern:_25; parm=3; exponential-logistic in length
#Pattern:_27; parm=special+3; cubic spline in length; parm1==1 resets knots; parm1==2 resets all 
#Pattern:_42; parm=special+3+2; cubic spline; like 27, with 2 additional param for scaling (average over bin range)
#_discard_options:_0=none;_1=define_retention;_2=retention&mortality;_3=all_discarded_dead;_4=define_dome-shaped_retention
#_Pattern Discard Male Special
 24 0 0 0 # 1 FshTrawl
 24 0 0 0 # 2 FshLL
 24 0 0 0 # 3 FshPot
 24 0 0 0 # 4 Srv
 24 0 0 0 # 5 LLSrv
#
#_age_selex_patterns
#Pattern:_0; parm=0; selex=1.0 for ages 0 to maxage
#Pattern:_10; parm=0; selex=1.0 for ages 1 to maxage
#Pattern:_11; parm=2; selex=1.0  for specified min-max age
#Pattern:_12; parm=2; age logistic
#Pattern:_13; parm=8; age double logistic
#Pattern:_14; parm=nages+1; age empirical
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_16; parm=2; Coleraine - Gaussian
#Pattern:_17; parm=nages+1; empirical as random walk  N parameters to read can be overridden by setting special to non-zero
#Pattern:_41; parm=2+nages+1; // like 17, with 2 additional param for scaling (average over bin range)
#Pattern:_18; parm=8; double logistic - smooth transition
#Pattern:_19; parm=6; simple 4-parm double logistic with starting age
#Pattern:_20; parm=6; double_normal,using joiners
#Pattern:_26; parm=3; exponential-logistic in age
#Pattern:_27; parm=3+special; cubic spline in age; parm1==1 resets knots; parm1==2 resets all 
#Pattern:_42; parm=2+special+3; // cubic spline; with 2 additional param for scaling (average over bin range)
#Age patterns entered with value >100 create Min_selage from first digit and pattern from remainder
#_Pattern Discard Male Special
 10 0 0 0 # 1 FshTrawl
 10 0 0 0 # 2 FshLL
 10 0 0 0 # 3 FshPot
 10 0 0 0 # 4 Srv
 10 0 0 0 # 5 LLSrv
#
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
# 1   FshTrawl LenSelex
            10           116       94.5331            50             0             0          1          0          1       1978       2021          3          0          0  #  Size_DblN_peak_FshTrawl(1)
           -20            10      -6.87149             0             0             0          2          0          0          0          0          0          0          0  #  Size_DblN_top_logit_FshTrawl(1)
           -10            10       6.51452             0             0             0          2          0          1       1978       2021          3          0          0  #  Size_DblN_ascend_se_FshTrawl(1)
           -10            10      -2.68172            10             0             0          2          0          1       1978       2021          3          0          0  #  Size_DblN_descend_se_FshTrawl(1)
         -1000       2.71828          -999            10             0             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_FshTrawl(1)
           -10            10            10            10             0             0         -2          0          0       1978       2021          3          0          0  #  Size_DblN_end_logit_FshTrawl(1)
# 2   FshLL LenSelex
            10           116       72.2426            50             0             0          1          0          1       1978       2021          3          0          0  #  Size_DblN_peak_FshLL(2)
           -20            10       1.12132             0             0             0          2          0          0          0          0          0          0          0  #  Size_DblN_top_logit_FshLL(2)
           -20            10       5.77567             0             0             0          2          0          1       1978       2021          3          0          0  #  Size_DblN_ascend_se_FshLL(2)
             0            10        4.9684            10             0             0          2          0          1       1978       2021          3          0          0  #  Size_DblN_descend_se_FshLL(2)
         -1000       2.71828          -999           -10             0             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_FshLL(2)
           -10            10            10            10             0             0         -2          0          0       1978       2021          3          0          0  #  Size_DblN_end_logit_FshLL(2)
# 3   FshPot LenSelex
            10            90       81.6718            50             0             0          1          0          0       1978       2021          3          0          0  #  Size_DblN_peak_FshPot(3)
           -20            10     -0.160695             0             0             0          2          0          0          0          0          0          0          0  #  Size_DblN_top_logit_FshPot(3)
           -20            10       5.89047             0             0             0          2          0          0       1978       2021          3          0          0  #  Size_DblN_ascend_se_FshPot(3)
             0            10       4.39835            10             0             0          2          0          0       1978       2021          3          0          0  #  Size_DblN_descend_se_FshPot(3)
         -1000       2.71828          -999           -10             0             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_FshPot(3)
           -10            10            10            10             0             0         -2          0          0       1978       2021          3          0          0  #  Size_DblN_end_logit_FshPot(3)
# 4   Srv LenSelex
            10            90       89.9976            50             0             0          1          0          0          0          0          0          1          2  #  Size_DblN_peak_Srv(4)
           -20            10      -5.38268             0             0             0          2          0          0          0          0          0          1          2  #  Size_DblN_top_logit_Srv(4)
           -10            10       8.12512             0             0             0          2          0          0          0          0          0          1          2  #  Size_DblN_ascend_se_Srv(4)
             0            10       3.83509            10             0             0          1          0          0          0          0          0          1          2  #  Size_DblN_descend_se_Srv(4)
           -10       2.71828        -9.951           -10             0             0          2          0          0          0          0          0          1          2  #  Size_DblN_start_logit_Srv(4)
           -10            10            10            10             0             0         -1          0          0          0          0          0          0          0  #  Size_DblN_end_logit_Srv(4)
# 5   LLSrv LenSelex
            10            90       63.9317            50             0             0          1          0          0          0          0          0          0          0  #  Size_DblN_peak_LLSrv(5)
           -20            10      -12.5588             0             0             0          2          0          0          0          0          0          0          0  #  Size_DblN_top_logit_LLSrv(5)
           -10            10       4.95743             0             0             0          2          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_LLSrv(5)
             0            10       4.95216            10             0             0          2          0          0          0          0          0          0          0  #  Size_DblN_descend_se_LLSrv(5)
         -1000       2.71828          -999           -10             0             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_LLSrv(5)
           -10            10      -3.12602            10             0             0          2          0          0          0          0          0          0          0  #  Size_DblN_end_logit_LLSrv(5)
# 1   FshTrawl AgeSelex
# 2   FshLL AgeSelex
# 3   FshPot AgeSelex
# 4   Srv AgeSelex
# 5   LLSrv AgeSelex
#_No_Dirichlet parameters
# timevary selex parameters 
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type    PHASE  #  parm_name
        0.0001             2           0.1           0.1           0.5             6      -5  # Size_DblN_peak_FshTrawl(1)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # Size_DblN_peak_FshTrawl(1)_dev_autocorr
        0.0001             2           0.1           0.1           0.5             6      -5  # Size_DblN_ascend_se_FshTrawl(1)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # Size_DblN_ascend_se_FshTrawl(1)_dev_autocorr
        0.0001             2           0.1           0.1           0.5             6      -5  # Size_DblN_descend_se_FshTrawl(1)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # Size_DblN_descend_se_FshTrawl(1)_dev_autocorr
        0.0001             2           0.1           0.1           0.5             6      -5  # Size_DblN_peak_FshLL(2)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # Size_DblN_peak_FshLL(2)_dev_autocorr
        0.0001             2           0.1           0.1           0.5             6      -5  # Size_DblN_ascend_se_FshLL(2)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # Size_DblN_ascend_se_FshLL(2)_dev_autocorr
        0.0001             2           0.1           0.1           0.5             6      -5  # Size_DblN_descend_se_FshLL(2)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # Size_DblN_descend_se_FshLL(2)_dev_autocorr
            10            90       47.0155            50             0             0      1  # Size_DblN_peak_Srv(4)_BLK1repl_1980
           -20            10      -0.11465             0             0             0      2  # Size_DblN_top_logit_Srv(4)_BLK1repl_1980
           -10            10       5.13927             0             0             0      2  # Size_DblN_ascend_se_Srv(4)_BLK1repl_1980
             0            10       4.98239            10             0             0      1  # Size_DblN_descend_se_Srv(4)_BLK1repl_1980
           -10       2.71828      -9.63183           -10             0             0      2  # Size_DblN_start_logit_Srv(4)_BLK1repl_1980
# info on dev vectors created for selex parms are reported with other devs after tag parameter section 
#
0   #  use 2D_AR1 selectivity(0/1)
#_no 2D_AR1 selex offset used
#
# Tag loss and Tag reporting parameters go next
0  # TG_custom:  0=no read and autogen if tag data exist; 1=read
#_Cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0  #_placeholder if no parameters
#
# deviation vectors for timevary parameters
#  base   base first block   block  env  env   dev   dev   dev   dev   dev
#  type  index  parm trend pattern link  var  vectr link _mnyr  mxyr phase  dev_vector
#      1    15     1     6     2     0     0     0     0     0     0     0
#      1    16     2     6     2     0     0     0     0     0     0     0
#      5     1     3     0     0     0     0     1     1  1978  2021     3 -0.650417 -1.57457 -0.404328 -0.483657 -2.48891 -2.19759 -1.34103 -0.733065 -0.101241 -0.595902 0.29525 0.623551 -1.10521 -0.31453 -1.48568 1.38038 0.265491 1.58897 1.00345 0.952913 0.632054 0.0361918 0.649401 -0.626492 -0.217579 0.919239 0.758104 -0.0893793 0.433067 0.773053 1.1428 0.987165 0.61833 0.314237 -0.985781 0.0109264 0.709851 1.70735 0.419242 0.319964 0.0130814 -0.343539 -0.339849 -0.391082
#      5     3     5     0     0     0     0     2     1  1978  2021     3 0.925466 0.460282 1.16346 0.405467 -0.58956 1.88856 0.704334 0.570912 0.0165508 0.260309 -0.37671 -0.596424 -0.118948 -0.0946658 -0.549374 0.17744 -0.167961 0.924835 0.48966 -0.0621648 0.300196 -0.194839 0.00618394 -0.692218 -0.772035 -0.0253226 0.168395 -0.467368 -0.113322 -0.0323912 0.162157 -0.125902 -0.384381 -0.457565 -1.45602 -0.807272 -0.256989 0.0464252 -0.364474 -0.238232 -0.427167 -0.443938 0.468231 0.608688
#      5     4     7     0     0     0     0     3     1  1978  2021     3 1.57078e-07 6.4182e-07 -1.82384e-07 1.19444e-08 3.1199e-06 6.26641e-07 1.31159e-06 -7.98197e-08 2.27058e-08 7.33344e-09 -3.49902e-09 -8.93654e-08 9.82125e-07 2.22371e-07 9.5263e-07 3.17668e-07 -1.68398e-07 -1.05885e-06 7.34997e-07 -3.85803e-09 -2.01912e-06 -3.64155e-07 6.26562e-07 4.98157e-07 -4.1558e-07 1.90102e-06 3.63494e-09 3.22234e-06 -2.12442e-06 -5.44709e-08 6.58404e-09 -9.86153e-08 -8.76052e-07 -3.09549e-07 7.23056e-06 3.46128e-08 9.3444e-07 2.50495e-08 -1.6355e-06 -1.35589e-06 2.06285e-06 -6.68345e-08 -1.66254e-07 8.23822e-08
#      5     7     9     0     0     0     0     4     1  1978  2021     3 -0.293969 -0.440945 -0.0451595 0.0014426 -0.778502 -0.136931 -1.03674 -0.966484      0      0 0.0113708 0.0208357 0.839231 0.673755 0.986986 0.0614611 -0.245296 0.582382 0.153443 0.182411 0.0294704 0.318053 1.35933 -0.731665 0.154544 -1.62983 -0.902572 -0.68365 -0.871902 -1.12631 -0.435106 -1.00376 -0.233625 -0.859884 -0.425762 2.63814 0.237898 -0.569261 2.94504 1.52576 0.571431 2.29609 -1.37241 -0.778653
#      5     9    11     0     0     0     0     5     1  1978  2021     3 0.0104316 -0.434662 0.0400977 -0.0023633 0.101389 -0.0108299 -0.12091 0.241458      0      0 -0.00708689 -0.0123919 -0.876888 0.173865 0.477597 0.146424 -0.0238473 -0.286853 0.317884 0.237958 0.0605238 0.189273 0.915669 -0.277698 0.434651 -0.965254 0.339914 -0.621291 -0.542324 -1.15447 -0.0963307 -0.742033 0.036449 -0.648926 -0.710371 1.42689 -0.000179641 -0.171188 1.55508 0.847177 0.214396 1.31808 -0.922051 -0.471205
#      5    10    13     0     0     0     0     6     1  1978  2021     3 -5.00962e-07 -6.84808e-07 6.0318e-08 -3.84337e-09 -2.33775e-07 -2.2849e-07 -8.39119e-07 -8.00386e-07      0      0 7.45482e-10 9.84262e-09 -7.57726e-07 -1.4696e-06 -1.07564e-06 -1.6988e-06 -1.7231e-06 -1.74278e-06 -2.04361e-06 -2.04158e-06 -1.01073e-06 -1.30232e-09 -1.03833e-07 1.62983e-06 -1.61683e-06 -4.47681e-06 4.0493e-07 -1.88522e-06 -3.14966e-06 -1.99397e-06 9.2276e-06 8.13497e-06 6.97778e-06 -1.90122e-06 4.98136e-07 -1.48758e-07 2.28529e-06 5.35034e-06 1.1687e-07 -1.0065e-06 -1.46878e-06 -3.56038e-07 -1.44647e-06 4.00957e-07
#      5    19    15     1     2     0     0     0     0     0     0     0
#      5    20    16     1     2     0     0     0     0     0     0     0
#      5    21    17     1     2     0     0     0     0     0     0     0
#      5    22    18     1     2     0     0     0     0     0     0     0
#      5    23    19     1     2     0     0     0     0     0     0     0
     #
# Input variance adjustments factors: 
 #_1=add_to_survey_CV
 #_2=add_to_discard_stddev
 #_3=add_to_bodywt_CV
 #_4=mult_by_lencomp_N
 #_5=mult_by_agecomp_N
 #_6=mult_by_size-at-age_N
 #_7=mult_by_generalized_sizecomp
#_Factor  Fleet  Value
      1      4         0
      1      5         0
      4      1         1
      4      2         1
      4      3         1
      4      4         1
      4      5         1
      6      3         1
      6      4         1
      6      5         0
 -9999   1    0  # terminator
#
1 #_maxlambdaphase
1 #_sd_offset; must be 1 if any growthCV, sigmaR, or survey extraSD is an estimated parameter
# read 0 changes to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=sizeage; 8=catch; 9=init_equ_catch; 
# 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin; 17=F_ballpark; 18=initEQregime
#like_comp fleet  phase  value  sizefreq_method
-9999  1  1  1  1  #  terminator
#
# lambdas (for info only; columns are phases)
#  0 #_CPUE/survey:_1
#  0 #_CPUE/survey:_2
#  0 #_CPUE/survey:_3
#  1 #_CPUE/survey:_4
#  1 #_CPUE/survey:_5
#  1 #_lencomp:_1
#  1 #_lencomp:_2
#  1 #_lencomp:_3
#  1 #_lencomp:_4
#  1 #_lencomp:_5
#  1 #_agecomp:_1
#  1 #_agecomp:_2
#  1 #_agecomp:_3
#  1 #_agecomp:_4
#  0 #_agecomp:_5
#  0 #_size-age:_1
#  0 #_size-age:_2
#  0 #_size-age:_3
#  1 #_size-age:_4
#  0 #_size-age:_5
#  1 #_init_equ_catch1
#  1 #_init_equ_catch2
#  1 #_init_equ_catch3
#  1 #_init_equ_catch4
#  1 #_init_equ_catch5
#  1 #_recruitments
#  1 #_parameter-priors
#  1 #_parameter-dev-vectors
#  1 #_crashPenLambda
#  1 # F_ballpark_lambda
0 # (0/1/2) read specs for more stddev reporting: 0 = skip, 1 = read specs for reporting stdev for selectivity, size, and numbers, 2 = add options for M,Dyn. Bzero, SmryBio
 # 0 2 0 0 # Selectivity: (1) fleet, (2) 1=len/2=age/3=both, (3) year, (4) N selex bins
 # 0 0 # Growth: (1) growth pattern, (2) growth ages
 # 0 0 0 # Numbers-at-age: (1) area(-1 for all), (2) year, (3) N ages
 # -1 # list of bin #'s for selex std (-1 in first bin to self-generate)
 # -1 # list of ages for growth std (-1 in first bin to self-generate)
 # -1 # list of ages for NatAge std (-1 in first bin to self-generate)
999

