# Fix the splice region annotations
maf <- maf %>% #`%>%`takes the result of one function (maf) and pipes it into the next function as the first argument
  #mutate() is used to create new columns while keeping existing ones
  mutate(
    # left side is the name for the column 
    # right side is the instruction or formula R uses to generate the data
    
    # Extract base cDNA coordinate
    cdna_pos = as.numeric(str_extract(HGVSc, "(?<=c\\.)-?\\d+")),
    
    # Extract splice offset (+N or -N)
    splice_offset = str_extract(HGVSc, "(?<=\\d)[+-]\\d+"),
    
    # Infer AA position (absolute for UTR cases)
    Amino_Acid_Position = ceiling(abs(cdna_pos) / 3),
    
    # Create protein label from splice direction
    HGVSp_Short = case_when(
      
      !is.na(HGVSp_Short) ~ HGVSp_Short,
      
      !is.na(splice_offset) & str_starts(splice_offset, "\\+") ~
        paste0("p.Splice_Donor", splice_offset, "@AA", Amino_Acid_Position),
      
      !is.na(splice_offset) & str_starts(splice_offset, "\\-") ~
        paste0("p.Splice_Acceptor", splice_offset, "@AA", Amino_Acid_Position),
      
      TRUE ~
        paste0("p.NearSplice@AA", Amino_Acid_Position)
    )
  ) %>%
  select(-cdna_pos, -splice_offset)
