using JuMP, GLPKMathProgInterface

n = 9;
m = 5;
t = rand(1:100,n,m)

model = Model(solver=GLPKSolverMIP());
@variable(model, x[1:n,1:m], Bin);
@objective(model, Min, sum(t[i,j]*x[i,j] for i in 1:n, j in 1:m));
@constraint(model, [i=1:n], sum(x[i,j] for j in 1:m) <= 1);
@constraint(model, [j=1:m], sum(x[i,j] for i in 1:n) >= 1);

println(model)

status = solve(model)

println(getobjectivevalue(model))
display(getvalue(x))
