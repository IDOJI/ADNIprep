RS.fMRI_1_Data.Selection___VISCODE___Search = function(Search.df){
  # the file name on ADNI hompage : Visits [ADNI1,GO,2,3]
  # Search.df = input$List_Search[[1]]
  #===========================================================================
  # Search.df
  #===========================================================================
  Search = Search.df
  Search$VISCODE = NA





  #===========================================================================
  # ADNI1
  #===========================================================================
  # uns1	Unscheduled
  # f	Screen Fail
  # ADNI1 = Search %>% dplyr::filter(PHASE == "ADNI 1") %>% dplyr::select(VISIT) %>% unlist %>% table
  # Search_1 = Search %>%
  #   filter(PHASE == "ADNI 1") %>%
  #   mutate(VISCODE = case_when(
  #     VISIT == "ADNI Baseline" ~ "bl",
  #     VISIT == "ADNI Screening" ~ "sc",
  #     VISIT == "ADNI1/GO Month 6" ~ "m06",
  #     VISIT == "ADNI1/GO Month 12" ~ "m12",
  #     VISIT == "ADNI1/GO Month 18" ~ "m18",
  #     VISIT == "ADNI1/GO Month 24" ~ "m24",
  #     VISIT == "ADNI1/GO Month 30" ~ "m30",
  #     VISIT == "ADNI1/GO Month 36" ~ "m36",
  #     VISIT == "ADNI1/GO Month 42" ~ "m42",
  #     VISIT == "ADNI1/GO Month 48" ~ "m48",
  #     VISIT == "ADNI1/GO Month 54" ~ "m54",
  #     VISIT == "Unscheduled" ~ "uns1",
  #     VISIT == "No Visit Defined" ~ "nv",
  #     TRUE ~ NA # Default case to return NA when none of the above conditions are met
  #   ))
  # allowed_visits <- c(
  #   "ADNI Baseline",
  #   "ADNI Screening",
  #   "ADNI1/GO Month 6",
  #   "ADNI1/GO Month 12",
  #   "ADNI1/GO Month 18",
  #   "ADNI1/GO Month 24",
  #   "ADNI1/GO Month 30",
  #   "ADNI1/GO Month 36",
  #   "ADNI1/GO Month 42",
  #   "ADNI1/GO Month 48",
  #   "ADNI1/GO Month 54",
  #   "Unscheduled",
  #   "No Visit Defined"
  # )
  # # Check for any VISIT types not in the allowed list and stop if found
  # Search_1 %>%
  #   filter(PHASE == "ADNI 1") %>%
  #   {. ->> filtered_search} # Store the filtered dataframe for later use
  # if(any(!(filtered_search$VISIT %in% allowed_visits))) {
  #   stop("Found VISIT types not in the allowed for ADNI 1.")
  # }














  #===========================================================================
  # ADNIGO
  #===========================================================================
  # Phase	ID	VISCODE	VISNAME	VISORDER
  # ADNIGO	1	sc	Screening	1
  # ADNIGO	3	bl	Baseline	3
  # ADNIGO	16	nv	No Visit Defined
  # Search %>% dplyr::filter(PHASE == "ADNI GO") %>% dplyr::select(VISIT) %>% unlist %>% table
  Search_GO = Search %>%
    filter(PHASE == "ADNI GO") %>%
    mutate(VISCODE = case_when(
      VISIT == "ADNIGO Screening MRI" ~ "scmri",
      VISIT == "ADNIGO Month 3 MRI" ~ "m03",
      VISIT == "ADNI1/GO Month 6" ~ "m06",
      VISIT == "ADNI1/GO Month 12" ~ "m12",
      VISIT == "ADNI1/GO Month 18" ~ "m18",
      VISIT == "ADNI1/GO Month 36" ~ "m36",
      VISIT == "ADNI1/GO Month 42" ~ "m42",
      VISIT == "ADNI1/GO Month 48" ~ "m48",
      VISIT == "ADNI1/GO Month 54" ~ "m54",
      VISIT == "ADNIGO Month 60" ~ "m60",
      VISIT == "ADNIGO Month 66" ~ "m66",
      VISIT == "ADNIGO Month 72" ~ "m72",
      VISIT == "ADNIGO Month 78" ~ "m78",
      TRUE ~ NA # Default case to return NA when none of the above conditions are met
    ))
  allowed_visits <- c(
    "ADNIGO Screening MRI",
    "ADNIGO Month 3 MRI",
    "ADNI1/GO Month 6",
    "ADNI1/GO Month 12",
    "ADNI1/GO Month 18",
    "ADNI1/GO Month 36",
    "ADNI1/GO Month 42",
    "ADNI1/GO Month 48",
    "ADNI1/GO Month 54",
    "ADNIGO Month 60",
    "ADNIGO Month 66",
    "ADNIGO Month 72",
    "ADNIGO Month 78"
  )
  # Check for any VISIT types not in the allowed list and stop if found
  Search_GO %>%
    filter(PHASE == "ADNI GO") %>%
    {. ->> filtered_search} # Store the filtered dataframe for later use
  if(any(!(filtered_search$VISIT %in% allowed_visits))) {
    stop("Found VISIT types not in the allowed for ADNI GO.")
  }







  #===========================================================================
  # ADNI2
  #===========================================================================
  # Phase	ID	VISCODE	VISNAME	VISORDER
  # ADNI2	1	v01	Screening - New Pt	1
  # ADNI2	2	v02	Screening MRI - New Pt	2
  # ADNI2	3	v03	Baseline - New Pt	3
  # ADNI2	4	v04	Month 3 MRI - New Pt	4
  # ADNI2	7	v07	ADNI2 Initial TelCheck - Continuing Pt	7
  # ADNI2	9	v12	ADNI2 Year 1 TelCheck	9
  # ADNI2	11	v22	ADNI2 Year 2 TelCheck	11
  # ADNI2	13	v32	ADNI2 Year 3 TelCheck	13
  # ADNI2	15	v42	ADNI2 Year 4 TelCheck	15
  # ADNI2	17	v52	ADNI2 Year 5 TelCheck	17
  # ADNI2	18	nv	No Visit Defined
  # Filter for ADNI2 phase and create VISCODE based on VISIT
  # Search %>% dplyr::filter(PHASE == "ADNI 2") %>% dplyr::select(VISIT) %>% unlist %>% table
  Search_2 = Search %>%
    dplyr::filter(PHASE == "ADNI 2") %>%
    dplyr::mutate(VISCODE = case_when(
      VISIT == "ADNI2 Screening MRI-New Pt" ~ "v02",
      VISIT == "ADNI2 Month 3 MRI-New Pt" ~ "v04",
      VISIT == "ADNI2 Month 6-New Pt" ~ "v05",
      VISIT == "ADNI2 Initial Visit-Cont Pt" ~ "v06",
      VISIT == "ADNI2 Year 1 Visit" ~ "v11",
      VISIT == "ADNI2 Year 2 Visit" ~ "v21",
      VISIT == "ADNI2 Year 3 Visit" ~ "v31",
      VISIT == "ADNI2 Year 4 Visit" ~ "v41",
      VISIT == "ADNI2 Year 5 Visit" ~ "v51",
      VISIT == "ADNI2 Tau-only visit" ~ "tau",
      TRUE ~ NA # Default case to return "nv" when none of the above conditions are met
    ))
  # Define the allowed visits for ADNI2 phase based on the actual VISIT values in your dataframe
  allowed_visits_adni2 <- c(
    "ADNI2 Screening MRI-New Pt",
    "ADNI2 Month 3 MRI-New Pt",
    "ADNI2 Month 6-New Pt",
    "ADNI2 Initial Visit-Cont Pt",
    "ADNI2 Year 1 Visit",
    "ADNI2 Year 2 Visit",
    "ADNI2 Year 3 Visit",
    "ADNI2 Year 4 Visit",
    "ADNI2 Year 5 Visit",
    "ADNI2 Tau-only visit"
  )
  # Check for any VISIT types not in the allowed list and stop if found
  Search_2 %>%
    filter(PHASE == "ADNI 2") %>%
    {. ->> filtered_search} # Store the filtered dataframe for later use
  # Check for any VISIT types not in the allowed list and stop if found
  if(any(!(filtered_search$VISIT %in% allowed_visits_adni2))) {
    stop("Found VISIT types not in the allowed list for ADNI2.")
  }










  #===========================================================================
  # ADNI3
  #===========================================================================
  # Phase	ID	VISCODE	VISNAME	VISORDER
  # ADNI3	1	reg	Participant Registration	1
  # ADNI3	2	sc	Screening - New Pt	2
  # ADNI3	3	bl	Baseline - New Pt	3
  # ADNI3	4	init	ADNI3 Initial Visit - Continuing Pt	4
  # ADNI3	5	y1	ADNI3 Year 1 Visit	5
  # ADNI3	6	y2	ADNI3 Year 2 Visit	6
  # ADNI3	7	y3	ADNI3 Year 3 Visit	7
  # ADNI3	8	y4	ADNI3 Year 4 Visit	8
  # ADNI3	9	y5	ADNI3 Year 5 Visit	9
  # ADNI3	10	y6	ADNI3 Year 6 Visit	10
  # Filter for ADNI3 phase and create VISCODE based on VISIT
  # Search %>% dplyr::filter(PHASE == "ADNI 3") %>% dplyr::select(VISIT) %>% unlist %>% table
  Search_3 <- Search %>%
    filter(PHASE == "ADNI 3") %>%
    mutate(VISCODE = case_when(
      VISIT == "ADNI Screening" ~ "sc",
      VISIT == "ADNI3 Initial Visit-Cont Pt" ~ "init",
      VISIT == "ADNI3 Year 1 Visit" ~ "y1",
      VISIT == "ADNI3 Year 2 Visit" ~ "y2",
      VISIT == "ADNI3 Year 3 Visit" ~ "y3",
      VISIT == "ADNI3 Year 4 Visit" ~ "y4",
      VISIT == "ADNI3 Year 5 Visit" ~ "y5",
      TRUE ~ NA # Default case to return NA when none of the above conditions are met
    ))
  # Define the allowed visits for ADNI3 phase based on the actual VISIT values in your dataframe
  allowed_visits_adni3 <- c(
    "ADNI Screening",
    "ADNI3 Initial Visit-Cont Pt",
    "ADNI3 Year 1 Visit",
    "ADNI3 Year 2 Visit",
    "ADNI3 Year 3 Visit",
    "ADNI3 Year 4 Visit",
    "ADNI3 Year 5 Visit"
  )

  # Check for any VISIT types not in the allowed list and stop if found
  filtered_search_adni3 <- Search_3 %>%
    filter(PHASE == "ADNI 3")

  if(any(!(filtered_search_adni3$VISIT %in% allowed_visits_adni3))) {
    stop("Found VISIT types not in the allowed list for ADNI3.")
  }








  #===========================================================================
  # Return
  #===========================================================================
  Combined = rbind(Search_GO, Search_2, Search_3) %>% dplyr::relocate("VISCODE", .after = "VISIT")
  return(Combined)
}
