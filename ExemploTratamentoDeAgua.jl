using JuMP, GLPK # Carregando os pacotes necessários

#Informações sobre o problema
c1=10; c2=10; c3=10
U=10 
V=10
a1=10; a2=10; a3=10
b1=10; b2=10; b3=10
a0=10
b0=10
#-------------------------------------------------#

model = Model(GLPK.Optimizer)

@variables model begin # Inicializado as variáveis do problema
    x1 >= 0.0; x2 >= 0.0; x3 >= 0.0; x4 >= 0.0; x5 >= 0.0
end

# Determinar a função objetivo e especificar se o problema é de minimização ou de maximização
@objective(model, Max, c1*x1+c2*x2+c3*x3)

constraint1 = @constraint(model, x1+x2+x3 >= U)
constraint2 = @constraint(model, x1+x2+x3 <= V)
constraint3 = @constraint(model, (a1*x1+a2*x2+a3*x3)/V <= a0)
constraint4 = @constraint(model, (a1*x1+a2*x2+a3*x3)/V <= b0)


# Comando para o solver otimizar a função
optimize!(model)

# Análise de Sensibilidade
report = lp_sensitivity_report(model)

# Valor das variáveis e valor ótimo da função objetivo
println("Valor de x1: ", value(x1))
println("Valor de x2: ", value(x2))
println("Valor de x3: ", value(x3))
println("Valor da função objetivo: ", objective_value(model))

# Intervalos de variabilidade dos coeficientes da funcão objetivo
println("Intervalos de variabilidade do coeficiente de x1: ", report[x1])
println("Intervalos de variabilidade do coeficiente de x2: ", report[x2])
println("Intervalos de variabilidade do coeficiente de x3: ", report[x3])

# Shadow-price das restrições
println("Shadow price da restrição 1: ", shadow_price(constraint1))
println("Shadow price da restrição 2: ", shadow_price(constraint2))
println("Shadow price da restrição 3: ", shadow_price(constraint3))
println("Shadow price da restrição 4: ", shadow_price(constraint4))

# Reduced costs
println("Reduced cost de x1: ", reduced_cost(x1))
println("Reduced cost de x2: ", reduced_cost(x2))
println("Reduced cost de x3: ", reduced_cost(x3))