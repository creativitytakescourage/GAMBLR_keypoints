# My vocabulary

`%>%` pipe operator: output on the left side will be passed directly to the command on the right side of the operator

`function_name` function name: arbitrarily selected name that will help us know/indicate to us what this function will do
  ex.
  
  + Filter - filter out rows
  + Select - select columns 
  + Rename - renaming columns
  + pretty - family of functions that generate plots with consistent appearance
  + get - obtain data
  
  
`function(...)` : name of the function(arguments we want to specify)
  ex.
  + sum(1, 2) : give us a sum of 1 and 2
  + mean(2, 4) : give us the average of 2 and 4
  + get_gambl_metadata(seq_type = "capture") : assigning value "capture" to the argument "seq_type"
  + arrange() : no specified arguments, will run all default arguments

`!!` : allows us to convert values contained in variables as an argument to a function
  ex.
  
  + We are starting from data frame 10 rows and 10 columns and want to select only 1 column without knowing upfront the name or the position of this column
    assign a = "pathology"
    select(!!sym(a)) : unpack (!!) and treat symbol (sym) the value stored in variable a

`sym(...)` : interpret the variable as a symbol rather than its potentially conflicting value (i.e. a number, TRUE, etc)

`x <- y` : assign/equate x to y 

`x = y` : assigning/equating x to y (i.e. an argument to a function)
  ex.
  +  metadataColumns = c("BCL2 Status", "Analysis cohort"),
  backgroundColour = "white"

`%in%` : check whether an element is contained within another object  
 ex.
  + "FL" %in% c("FL", "DLBCL") will return TRUE because "FL" is in the list provided
  + "FL" %in% c("fl", "DLBCL") will return FALSE because "FL" is not in the list provided
  + "name" %in% c("age", "family members") will return FALSE because "name" is not in the list provided 
  + pathology <- "FL"
    pathology %in% c("FL", "DLBCL")
    
`{...}` : if attached to a function, "..." defines what the function will do
  ex.
  + show_col <- function(data, group){
  data %>%
    filter(
      !!sym("group") == {{group}}
    ) %>% //
  }

`+/-` : list (point form)
  ex.
  + apples
  - olive oil

`"x"` : (no spaces, use underscore for different words); x represents a string (a word), letters/elements represent substrings
  ex. 
  + "one", 1, "1" -- all different
  
`x`: not in quotation marks equals variable
  
`TRUE/FALSE` : boolean

`==` confirming equality
  ex.
  + filter(
      !!sym("group") == {{group}}
    )

`::` : accessing a specific function when there are multiple functions with the same name in one package, whichever function is most recent will take definition over a function that was defined previously
  ex 
  + package::functionname
  + rstatix::add_xy_position(x = "comp_group")

`>=` : greater than or equal to 

`!` : opposite of supposed value
  ex
  + !0 = TRUE
  + !1 = FALSE
 
`!=` : not equal to
  + 5 != 3 

`c()` : defines a list; c stands for combine
  ex
  + my_grocery <- c("apples", "olive oil")

`<- c()` : equating c() with something 
 
`-R` : recursive, go through every single subdirectory of a major directory

`-u` : u stands for set upstream, only do it when we first create a branch not any other time

`-m ""`: "" includes message
  ex.
  + git commit -m "defined -m"

`object$name` : object is a dataframe, name is a specific column of that dataframe
  ex
  + metadata <- get_gambl_metadata() 
    metadata$pathology

`%>%`:
  ex.
  + metadata <- get_gambl_metadata() %>%
  
To annotate:  

select(
    sample_id = `Genome sample id`,
    `Analysis cohort`,
    "BCL2 Status" = `BCL2 WGS Tx`
  ) %>%
  
  
mutate(
    # convert from boolean to character
    `BCL2 Status` = ifelse(`BCL2 Status`, "POS", "NEG"),
    # adding seq type for compatibility with plotting
    seq_type = "genome"
  )
  
ashm_heatmap <- prettyMutationDensity(
  these_samples_metadata = metadata,
  maf_data = maf,
  cluster_samples = FALSE,
  regions_bed = some_regions,
  min_bin_recurrence = 10,
  region_fontsize = 5,
  window_size = 1000,
  slide_by = 500,
  orientation = "sample_columns",
  sortByMetadataColumns = c("Analysis cohort", "BCL2 Status"),
  metadataColumns = c("BCL2 Status", "Analysis cohort"),
  backgroundColour = "white",
  customColours = list(
    "Analysis cohort" = get_gambl_colours(),
    "BCL2 Status" = get_gambl_colours("clinical")
  ),
  returnEverything = TRUE
)

show_col(all_c, "mutation")

some_regions <- somatic_hypermutation_locations_GRCh37_v0.2 %>%
  select(1:4) %>%
  rename(
    "chrom" = "chr_name",
    "start" = "hg19_start",
    "end" = "hg19_end",
    "name" = "gene"
  ) %>%
  mutate(chrom = str_remove(chrom, "chr"))
  
gene_groups
metadataColumns <- c(
  "pathology",
  "lymphgen",
  "genetic_subgroup",
  "COO_consensus",
  "sex"
)

gene_groups <- c(
  rep("FL", length(fl_genes)),
  rep("DLBCL", length(dlbcl_genes))
)
  
# Specific vocabulary for GAMBLR.helpers
# get_gambl_colours.R
  
`@param`: sets particular parameter
  + alpha = 0.5

`col2rgb()`: breaks down color name or HEX code into Red, Green, and Blue components

`rgb()`: creates a color from numbers (opposite of col2rgb())

`alpha`: transparency, can be set to a specific scale
  + for example: alpha = alpha * 255L, if 0 < alpha < 1, and alpha = 0.5, then 0.5 * 255 = 127.5

`paste()`: combines character strings, automatically adds space between strings
  + paste("Data", "Analysis", sep = "-")
    + Result: "Data-Analysis"
`paste0()`: combines character strings, no space between strings
  + paste0("Data_", "Analysis")
    + Result: "Data_Analysis"
`if(){}`: if () is satisfied
  + ex.
    if(as_rgb_string){}
`for(){}`: creates loop that runs through everything in {}
  + ex.
    for(colslot in names(all_colours)){
    raw_cols = all_colours[[colslot]]
    }