rankhospital <- function(state, outcome, num = "best") {                         ## This function trys to figure out the hostpital ranking in a specific US state
        if(!outcome %in% list("heart attack","heart failure","pneumonia")){
                stop("invalid outcome")} else {
                ## Read outcome data        
                data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
                sub_outcome <- subset(data,select=c(Hospital.Name,State,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,
	                                               Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))
	        colnames(sub_outcome) <-c("hospital","state","heart attack","heart failure","pneumonia")
	       
	        if(!state %in% as.list(unique(sub_outcome$state))) {
	                stop("invalid state")
	        }  else {
	                state_sub <- sub_outcome[sub_outcome$state==state,]
	                ## First order the data frame according to hospital name
	                ordered_name <- order(state_sub$hospital,decreasing=FALSE,na.last=TRUE)
	                state_sub <- state_sub[ordered_name,]
	                ## Then order the data frame according to mortality rate
	                s <- sapply(state_sub[outcome],as.numeric)
	                df <- as.data.frame(s)
	                ordered <- order(df,decreasing=FALSE,na.last=NA)
	                ordered_df <- state_sub[ordered,]
	                value <- ordered_df[,outcome]
	                        if(num=="best"){
	                       
	                                index <- which.min(value)
	                                ordered_df[index,]$hospital
	                        } else if(num=="worst"){
	                      
	                         index <- which.max(value)
	                       ordered_df[index,]$hospital    
	                        } else if (num<=which.max(value) & num>=which.min(value)){
	                        
	                        index <- num
	                        ordered_df[index,]$hospital
	                        
	                        } else{
	                        message ("invalid num")
	                                }
	                }      
	        
        }

}        
