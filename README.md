# parallel-gradients
Simple utility script to compute numerical gradients in parallel using R

```{r}
# define function
f = function(x) 2 * (x[1] - 3)^2 + 3 * (x[2] + 5)^2

# use parallel_gradients to create a gradient function
g = function(x) parallel_gradients(f, x, mc.cores = 2)
```
