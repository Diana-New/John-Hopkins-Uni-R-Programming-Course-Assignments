rankall <- function(outcome, num = "best") {
        if (!outcome %in% list("heart attack","heart failure","pneumonia")) {
                stop("invalid outcome")} else { 
                data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
                sub_outcome <- subset(data,select=c(Hospital.Name,State,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,
                                Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))
                colnames(sub_outcome) <-c("hospital","state","heart attack","heart failure","pneumonia")
                
                ## Create an empty data frame to store the result
                m <- matrix(rep(0),54,2)
                canvas <- data.frame(m)
                colnames(canvas) <- c("Hospital","State")
                
                state <- as.list(unique(sub_outcome$state))
                
                for (i in 1:length(state)) {
                        state_sub <- sub_outcome[sub_outcome$state==state[[i]],]
                        ## First order the data frame according to hospital name
                        ordered_name <- order(state_sub$hospital,decreasing=FALSE,na.last=TRUE)
                        state_sub <- state_sub[ordered_name,]
                        ## Then order the data frame according to mortality rate
                        s <- sapply(state_sub[outcome],as.numeric)
                        df <- as.data.frame(s)
                        ordered <- order(df,decreasing=FALSE,na.last=TRUE)
                        ordered_df <- state_sub[ordered,]
                        value <- ordered_df[,outcome]
                        if(num=="best"){
                                
                                index <- which.min(value)
                                best_hospital <- ordered_df[index,]$hospital
                        } else if(num=="worst"){
                                
                                index <- which.max(value)
                                best_hospital <- ordered_df[index,]$hospital    
                        } else if (num<=which.max(value) & num>=which.min(value)){
                                
                                index <- num
                                best_hospital <- ordered_df[index,]$hospital
                                
                        }       else{
                                        message ("invalid num")
                                }
                 canvas[i,1] <- best_hospital
                 canvas[i,2] <- state[[i]]
                }
                canvas
                        
        }
        
}