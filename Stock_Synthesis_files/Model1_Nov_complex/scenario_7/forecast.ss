#C forecast file written by R function SS_writeforecast
#C rerun model to get more complete formatting in forecast.ss_new
#C should work with SS version: 3.3
#C file write time: 2022-10-25 12:24:52
#
1 #_benchmarks
1 #_MSY
0.35 #_SPRtarget
0.35 #_Btarget
#_Bmark_years: beg_bio, end_bio, beg_selex, end_selex, beg_relF, end_relF,  beg_recr_dist, end_recr_dist, beg_SRparm, end_SRparm (enter actual year, or values of 0 or -integer to be rel. endyr)
1991 2020 1991 2020 1991 2021 1991 2020 1991 2021
1 #_Bmark_relF_Basis
1 #_Forecast
15 #_Nforecastyrs
0 #_F_scalar
#_Fcast_years:  beg_selex, end_selex, beg_relF, end_relF, beg_recruits, end_recruits (enter actual year, or values of 0 or -integer to be rel. endyr)
2000 2020 2016 2021 1991 2021
0 #_Fcast_selex
2 #_ControlRuleMethod
0.4 #_BforconstantF
0.02 #_BfornoF
1 #_Flimitfraction
3 #_N_forecast_loops
3 #_First_forecast_loop_with_stochastic_recruitment
0 #_fcast_rec_option
1 #_fcast_rec_val
0 #_Forecast_loop_control_5
0 #_FirstYear_for_caps_and_allocations
0 #_stddev_of_log_catch_ratio
0 #_Do_West_Coast_gfish_rebuilder_output
0 #_Ydecl
0 #_Yinit
1 #_fleet_relative_F
# Note that fleet allocation is used directly as average F if Do_Forecast=4 
2 #_basis_for_fcast_catch_tuning
# enter list of fleet number and max for fleets with max annual catch; terminate with fleet=-9999
-9999 -1
# enter list of area ID and max annual catch; terminate with area=-9999
-9999 -1
# enter list of fleet number and allocation group assignment, if any; terminate with fleet=-9999
-9999 -1
2 #_InputBasis
 #_#Year Seas Fleet  dead(B)                 comment
    2022    1     1  3175.97 #sum_for_2022: 10547.12
    2022    1     2  1588.48                        
    2022    1     3  5782.67                        
    2023    1     1 12850.60 #sum_for_2023: 25591.04
    2023    1     2  4899.68                        
    2023    1     3  7840.76                        
    2024    1     1  9554.45 #sum_for_2024: 19308.32
    2024    1     2  3783.46                        
    2024    1     3  5970.41                        
-9999 0 0 0
#
999 # verify end of input 