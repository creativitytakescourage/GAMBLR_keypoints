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

`%in%` : separate 
 ex.
  + metadata <- get_gambl_metadata() %>%
  filter(
    study == "FL_Dreval",
    pathology %in% c("FL", "DLBCL")
  )


`{...}` : not part of a function 
  ex.
  + show_col <- function(data, group){
  data %>%
    filter(
      !!sym("group") == {{group}}
    ) %>% //

`x = y` : assigning/equating x to y (i.e. an argument to a function)
  ex.
  +  metadataColumns = c("BCL2 Status", "Analysis cohort"),
  backgroundColour = "white"

`+/-` : list (point form)

`"x"` : (no spaces, use underscore for different words)

`==` confirming equality

`::` : accessing a function

`>=` : greater than or equal to 

`!` : opposite of supposed value
 
`!=` : not equal to

`c()` : 

`<- c` :
 
`-R` :

`-u` :

`object$name` :

`%>%`
  ex.
  + metadata <- get_gambl_metadata() %>%