best <- function(state, outcome){

## Check that state and outcome are valid
if(outcome %in% list("heart attack","heart failure","pneumonia")) {
	
	        ## subsetting the data frame
	        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
	        sub_outcome <- subset(data,select=c(Hospital.Name,State,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,
	                                               Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))
	        colnames(sub_outcome) <-c("Hospital","State","heart attack","heart failure","pneumonia")
	  if(state %in% as.list(unique(sub_outcome$State))) {
		state_sub <- sub_outcome[sub_outcome$State==state,]
	  } else {
	          ## rate
	          message("invalid state")}
## Return hospital name in that state with lowest 30-day death

	value <- state_sub[,outcome]
	index <- which.min(value)
        state_sub[index,]$Hospital
} else {
	message("invalid outcome") }
                 
}
best("AL","heart_attack")
