## A pair of functions that cache the inverse of a matrix

## The following function can create a "matrix" object that can cache its inverse

makeCacheMatrix <- function(x = matrix()) {
	m <- NULL

	## Set the matrix
	set <- function(y){
		x <<- y
		m <<- NULL
	}

	## Get the matrix
	get <- function() x

	## Set the inverse of the matrix
	setInverse <- function(solve) m <<- solve

	## Get the inverse of the matrix
	getInverse <- function() m

	list(set=set, get=get, setInverse = setInverse, getInverse = getInverse)
}


## This function computes the inverse of the "matrix" object returned by makeCacheMatrix ## above.

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
	m <- x$getInverse()

	if(!is.null(m)){
	message("getting cached data")
	return(m)
	}

	## Get the matrix from the object
	data <- x$get()

	## Calculate the inverse of the matrix
	m <- solve(data,...)

	## Set the inverse to the object
	x$setInverse(m)
	m
}
