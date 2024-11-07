using JuMP, GLPK # Carregando os pacotes necessários

model = Model(GLPK.Optimizer)

@variables model begin # Inicializado as variáveis do problema
    x1 >= 320.0; x2 >= 380.0; x3 >= 450.0; x4 >= 240.0; x5 >= 280.0
end

# Determinar a função objetivo e especificar se o problema é de minimização ou de maximização
@objective(model, Max, 0.80*x1+0.70*x2+1.15*x3+1.30*x4+0.70*x5)

constraint1 = @constraint(model, 0.70*x1+0.40*x2+0.40*x3+0.60*x4+0.60*x5 <= 1200.0)
constraint2 = @constraint(model, 0.16*x1+0.22*x2+0.32*x3+0.19*x4+0.23*x5 <= 460.0)
constraint3 = @constraint(model, 0.25*x1+0.33*x2+0.33*x3+0.40*x4+0.47*x5 <= 650.0)
constraint4 = @constraint(model, 0.05*x1+0.12*x2+0.09*x3+0.04*x4+0.16*x5 <= 170.0)

# Comando para o solver otimizar a função
optimize!(model)

# # Valor das variáveis e valor ótimo da função objetivo
println("Valor de x1: ", value(x1))
println("Valor de x2: ", value(x2))
println("Valor de x3: ", value(x3))
println("Valor de x4: ", value(x4))
println("Valor de x5: ", value(x5))
println("Valor da função objetivo: ", objective_value(model))














# # Intervalos de variabilidade dos coeficientes da funcão objetivo
# println("Intervalos de variabilidade do coeficiente de x1: ", report[x1])
# println("Intervalos de variabilidade do coeficiente de x2: ", report[x2])
# println("Intervalos de variabilidade do coeficiente de x3: ", report[x3])
# println("Intervalos de variabilidade do coeficiente de x4: ", report[x4])
# println("Intervalos de variabilidade do coeficiente de x5: ", report[x5])

# # Shadow-price das restrições
# println("Shadow price da restrição 1: ", shadow_price(constraint1))
# println("Shadow price da restrição 2: ", shadow_price(constraint2))
# println("Shadow price da restrição 3: ", shadow_price(constraint3))
# println("Shadow price da restrição 4: ", shadow_price(constraint4))

# # Reduced costs
# println("Reduced cost de x1: ", reduced_cost(x1))
# println("Reduced cost de x2: ", reduced_cost(x2))
# println("Reduced cost de x3: ", reduced_cost(x3))
# println("Reduced cost de x4: ", reduced_cost(x4))
# println("Reduced cost de x5: ", reduced_cost(x5))