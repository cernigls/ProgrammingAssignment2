## Matrix Inversion is a costly computation.  These functions implement
## a solution to cache a special "matrix" and retrieve it if its inverse
## has already been calculated before.  The special "matrix" is actually
## a list containing a function to: 
##  1) set the value of the matrix
##  2) get the value of the matrix
##  3) set the value of the inverse of the matrix
##  4) get the value of the inverse of the matrix


## The makeCacheMatrix function creates a special "matrix" object that can 
## cache a matrix's inverse.  This special "matrix" is implemented as a 
## list of the four functions described above.

makeCacheMatrix <- function(x = matrix()) {
    ## i holds the inverse matrix
    i <- NULL
    
    ## The set function which sets the value of the matrix
    set <- function(y) {
        x <<- y
        i <<- NULL
    }
    
    ## The get function which gets the value of the matrix
    get <- function() x
    
    ## The setinverse function stores the inverse matrix to be retreived later
    setinverse <- function(solve) i <<- solve
    
    ## The getinverse function retreives the inverse matrix
    getinverse <- function() i
    
    ## Create and return a list of the four functions described above
    list(set = set, get = get, 
         setinverse = setinverse, 
         getinverse = getinverse)
}


## The cacheSolve function computes the inverse of the speical "matrix" returned 
## by makeCacheMatrix function.  If the inverse has already been calculated
## then the cacheSolve will retrieve the inverse from the cache, otherwise it 
## will calcuated it.

cacheSolve <- function(x, ...) {
    ## Retreive the inverse matrix from the special "matrix"
    i <- x$getinverse()
    
    ## If the inverse matrix has been previously calcuated, then
    ## return it and we're done!
    if (!is.null(i)) {
        message("getting cached data")
        return(i)
    }
        
    ## Otherwise, the inverse has not been calculated yet, so
    ## we need to do that by retreiving the original matrix and
    ## calculating the inverse matrix.
    data <- x$get()
    i <- solve(data, ...)
    
    ## Now that we have the inverse, let's store it in case we
    ## need it again later.
    x$setinverse(i)
    
    ## Finally, return a matrix that is the inverse of 'x'
    i
}
