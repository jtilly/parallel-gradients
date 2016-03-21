library("parallel")

# define function
f = function(x) 2 * (x[1] - 3)^2 + 3 * (x[2] + 5)^2

# compute gradients for the function f in parallel
parallel_gradients = function(f, x, step = 1e-3, mc.cores = getOption("mc.cores", 2L)) {

    # create a list of vectors of length length(x) + 1
    x.list = list(x)
    
    # perturb elements 2, 3, ..., length(x) + 1 by the step size
    for(jX in 1:(length(x))) {
        xPrime = x
        xPrime[jX] = x[jX] + step
        x.list = c(x.list, list(xPrime))
    }
    
    # evaluate the function for each element of x.list
    fval = unlist(mclapply(x.list, f, mc.cores = mc.cores))
    
    # use forward finite differences to compute the gradient
    gradient = (fval[2:length(fval)] - fval[1]) / step
    
    return(gradient)
}

# create gradient function
g = function(x) parallel_gradients(f, x, mc.cores = 2)

# evaluate function at x0
x0 = c(2, 2)
print(f(x0))
print(g(x0))

# minimize with optim
optim(par = x0, fn = f, gr = g, method = "BFGS")
