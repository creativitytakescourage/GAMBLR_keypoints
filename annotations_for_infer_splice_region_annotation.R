# Fix the splice region annotations
maf <- maf %>% #`%>%`takes the result of one function (maf) and pipes it into the next function as the first argument
  #mutate() is used to create new columns while keeping existing ones
  mutate(
    # left side is the name for the column 
    # right side is the instruction or formula R uses to generate the data
    
    # Extract base cDNA coordinate
    cdna_pos = as.numeric(str_extract(HGVSc, "(?<=c\\.)-?\\d+")),
    
    #string starting with c indicates a coding DNA sequence and grabs the number immediately following it 
    #for example, if c.435G>A, extracts 435
    #HGVSc: Human Genome Variation Society (HGVS) at the coding DNA level (e.g. HGVSp is protein level, etc)
    
    # Extract splice offset (+N or -N)
    splice_offset = str_extract(HGVSc, "(?<=\\d)[+-]\\d+"),
    
    #splice offsets search for plus or minus sign followed by a number that appears after the main cDNA position
    #This identifies mutations located in introns (the gaps between coding regions)
    #for example, if input is c.435+2T>G, extracts +2, which tells us the mutation is 2 bases into the intron
    
    # Infer AA position (absolute for UTR cases)
    Amino_Acid_Position = ceiling(abs(cdna_pos) / 3),
    
    #used to figure the position of the DNA on the amino acid (3 DNA bases to make 1 amino acid)
    #`abs(cdna_pos)`: takes the absolute value
    #`/3`: divides by the codon length
    #`ceiling()`: rounds up to the nearest whole number 

    
    # Create protein label from splice direction
    
    #`case_when()`: works like if-then, will check each line consecutively until it finds the first that is true, then stops and moves onto next line
    #`HGVSp_Short`: arbitrary name implies the simplified version of the label 
    
    HGVSp_Short = case_when(
      
      !is.na(HGVSp_Short) ~ HGVSp_Short,
      
      #`!is.na()`: means if () is not empty
      #`~`: left hand side is Condition, right hand side is Action: establishes an if... then... relationship
      #code means if protein label already exists, keep it and don't overwrite existing data
      
      !is.na(splice_offset) & str_starts(splice_offset, "\\+") ~
        paste0("p.Splice_Donor", splice_offset, "@AA", Amino_Acid_Position),
      
      #`str_starts()`: checks the beginning of a string
      #`\\+`: check if splice_offset string begins with character + 
      #`+`: Splice Donor mutation: mutation is located in the intron, counting after the preceding extron (e.g. c.100+2 means 2 bases into intron after coding position 100)
      #protein label would therefore be "p.Splice_donor" then splice_offset value, then "@AA", then amino acid position
      
      !is.na(splice_offset) & str_starts(splice_offset, "\\-") ~
        paste0("p.Splice_Acceptor", splice_offset, "@AA", Amino_Acid_Position),
      
      #`paste0()`: glues text together without adding spaces 
      #`-`: Splice Acceptor mutation: mutation is in the intron, counting before the start of the extron (e.g. c.101-1 means the mutation is 1 base before coding position 101)
      
      TRUE ~
        paste0("p.NearSplice@AA", Amino_Acid_Position)
    )
    
    #`TRUE ~`: acts as default case, if none of these splice donor/acceptor conditions are met, default variant label is "p.NearSplice"
    
    #note: in c.xxx, c. stands for coding DNA, meaning xxx in a base in an extron (no introns represented since these are cut out)
    
    #note: essentially this code is to take a sequence such as c.123+1G>A, and doing the following:
    #figuring out the number of the base (123) and the splice offset (+1)
    #determine which protein is affected by calculating which amino acid the base is in
    #knows +1 is a Donor site
    #pastes everything together so researcher can read: p.Splice_Donor+1@AA41
    
  ) %>%
  select(-cdna_pos, -splice_offset)

  #removes original cdna_pos (replaced by amino acid position in the label) and splice_offset columns (since splice_offset info is kept in the label)
