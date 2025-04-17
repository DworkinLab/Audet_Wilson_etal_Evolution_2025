# README for the repository


## Overview

This repository contains all of the data and scripts to repeat the analyses of the experiments summarized in the study. Information on each individual data file and script are provided below.

Audet, T. Wilson, A. Dukas, R. & Dworkin, I. 2025. The role of resource defensibility in facilitating sexually-selected weapon evolution: An experimental evolution test. [Evolution](https://doi.org/10.1093/evolut/qpaf073)

A static copy of the data and scripts (frozen at time of acceptance of the paper) is available on [Figshare](10.6084/m9.figshare.28687235)

## Basic information

Images taken of Wilson flies (Spatial Heterogeneity manipulation experimental evolution)

Images taken by Audrey Wilson at generation 35 and Francesco Ruso at generation 75.

Measurements taken by Audrey Wilson at generation 35 and Tyler Audet at generation 75.

Images taken on Leica M12, Camera DFC400

Traits images: Head, wing, thorax, leg

Condition manipulation: C0 = unstarved C1 = 1 day starved C2 = 2 days starved


## DATA files and variables therein

`MM_aggression_FINAL.csv` 

Day - Day the trial was run

Trial - Individual trial identifier (nested within day)

Threat_dur - Threat duration

Threat_SM - Threat (in seconds per minute)

Lunges - Count of observed lunges

Session - Session of experiment

CAM - Which camera was used for recording assays

TRT - Experimental treatment group. See script for correspondence with standard treatment identifiers (B = NT, V = UCT, F = SCT).

Lineage - Replicate lineage within experimental treatment group

Observer - Observer



`Territoriality_CommonCompetitorCVL_2020.csv`

Block - Identifier of experimental block

Cage_number - Identifier for which cage was used for the trial

Treatment - Experimental treatment group

Male_type - High (HQ) or low quality (LQ) identifier for cross male

wt_female - number of female offspring that are wild type

cvl_female - number of female offspring that are cvl phenotype

cvl_male - number of male offspring that are cvl phenotype



`F35_wideFly.csv`

treatment - Experimental treatment group

cohort0 - Condition cohort with 0 as the highest condition (corresponding to days starved)

replicate - experimental replicate

cohort - Condition cohort with 1 as the highest condition

sex - sex

individual - individual identifier (within sex and treatment)

tarsus - tarsus length (µm)

femur - length (µm)

tibial - length (µm)

winglength - length (µm)

wingwidth - length (µm)

thorax - length (µm)

head - length (µm)

thorax_c - thorax length centred around the mean thorax length

cohort_n - cohort read in as a numeric variable rather than a factor



`gen75_wideFly.csv`

treatment - experimental treatment group

replicate - experimental replicate

cohort - condition cohort with 1 as the highest condition

sex - sex

individual - individual identifier (within sex and treatment)

tarsus - tarsus length (µm)

femur - length (µm)

tibia - length (µm)

wing - length (µm)

thorax - length (µm)

head - length (µm)

thorax_c - thorax length centred around the mean thorax length



`Audet_2022_terryflies.csv`

Initials - imager (and measurer) initials

Treatment - experimental treatment group

Replicate - experimental replicate

Generation - generations of experimental evolution

Cohort - condition cohort with 1 as the highest condition

Sex - sex

Individual - individual identifier (within sex and treatment)

Trait - trait identifier (L= leg, H= head, W= wing, T= thorax)

length - measurement length (pixels)

scale - conversion factor to µm

scale_mm - conversion factor to mm

length_mm - measurements converted to mm

NewTrait - trait expanded to full word and includes specific leg trait

Cohort0 - condition cohort with 0 as the highest condition (corresponding to days starved)



`tarsus_ConditionData.csv`

X - The first two columns are just output row numbers from the measuring software

Initials - imager initials

Treatment - experimental treatment group

Replicate - experimental replicate

Generation - generations of experimental evolution

Cohort - condition cohort with 1 as the highest condition

Sex - sex

Individual - individual identifier (within sex and treatment)

Trait - trait identifier (L= leg)

Area - measuring software output removed in script

Mean - measuring software output removed in script

Min - measuring software output removed in script

Max - measuring software output removed in script

Angle - measuring software output removed in script

Length - measurement length (pixels) 

scale - conversion factor to µm

scale_mm - conversion factor to mm

length_mm - measurements converted to mm

Cohort0 - condition cohort with 0 as the highest condition (corresponding to days starved)

length_um - measurements converted to µm

`TA_Measurements_F75_working.csv`

Number - software out row number

Label - image label (contains 'imager_treatment/replicate_cohort_sex_trait_individual' as outlined above as one label)

Length_px - length in pixels



## SCRIPTS

'Aggression_Analysis'

- This script corresponds to all aggression analyses
- Uses the data file 'MM_aggression_FINAL.csv'

'AW_ConditionDependence_siringSuccess_Experiment'

- This script corresponds to the siring success analyses
- Uses data from file 'Territoriality_CommonCompetitorCVL_2020.csv'

'Between_generation_comparison'

- This script corresponds to analyses looking at thorax size changes between F35 and F75
- This script uses both data files 'F35_wideFly.csv' and 'gen75_wideFly.csv'

'combining_plots'

- This script is used to turn figures from F35 and F75 in to multi-panel plots
- This script reads in no data, but is run when both 'TA_working_F35_analysis' and 
'TA_working_F75_analysis' have been run and go-lot objects are in the environment

'TA_working_F35_analysis'

- This script corresponds to all analyses done in the generation 35 flies
- This script uses the data file 'Audet_2022_terryflies.csv' and 'tarsus_ConditionData.csv' and writes out the data file 'F35_wideFly.csv'

'TA_working_F75_analysis'

- This script corresponds to all analyses done in the generation 75 flies
- This script uses data from 'TA_Measurements_F75_working.csv' and writes out the data file 'gen75_wideFly.csv'


FIGURES:

Figure 2 is generated in the script 'AW_ConditionDependence_siringSuccess_Experiment'

Figures 3, 4, 5, 6 are generated using both 'TA_working_F35_analysis' and 'TA_working_F75_analysis' scripts and then made in to panels using the script 'combining_plots'

Figure 7 is generated using the script 'Aggression_Analysis'

## Other information

These were fixed in the analysis, but kept here for accurate record keeping.

Flies sexed incorrectly:

NTR1_C1_M_*_19

NTR1_C2_F_*_10

NTR1_C2_F_*_12

NTR1_C2_F_*_7

NTR2_C2_F_*_19

NTR3_C0_F_*_15

NTR3_C0_F_*_16

NTR3_C0_F_*_3

NTR4_C0_F_*_20

SCTR1_C0_M_*_6

SCTR2_C0_F_*_3

SCTR2_C1_M_*_4

SCTR2_C2_F_*_4

SCTR3_C1_M_*_14

UCTR1_C0_F_*_20

UCTR1_C2_F_*_7

UCTR2_C0_F_*_10

UCTR4_C2_F_*_15