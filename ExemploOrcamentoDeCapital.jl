using JuMP, GLPK # Carregando os pacotes necessários

model = Model(GLPK.Optimizer)

@variables model begin # Inicializado as variáveis do problema
    x1 >= 0; x2 >= 0; x3 >= 0; x4 >= 0; x5 >= 0
end

# Determinar a função objetivo e especificar se o problema é de minimização ou de maximização
@objective(model, Max, 9.343*x1+8.902*x2+2.118*x3+11.542*x4+4.044*x5)

constraint1 = @constraint(model, x1+x2+x3+x4+x5 <= 1000.0)
constraint2 = @constraint(model, 5.0*x1+4.2*x2+2.2*x3+6.6*x4+3.0*x5 >= 6000.0)
constraint3 = @constraint(model, 7.7*x1+6.5*x2+3.7*x3+8.0*x4+3.5*x5 >= 5000.0)
constraint4 = @constraint(model, 7.9*x1+7.2*x2+2.9*x3+6.1*x4+4.1*x5 >= 6500.0)
constraint5 = @constraint(model, 5.0*x1+4.0*x2+3.5*x3+3.5*x4+3.0*x5 <= 3800.0)
constraint6 = @constraint(model, 1.0*x1+1.0*x2+0.5*x3+1.5*x4+0.5*x5 <= 3500.0)
constraint7 = @constraint(model, 1.2*x1+0.5*x2+0.5*x3+0.5*x4+1.0*x5 <= 3200.0)
constraint8 = @constraint(model, 0.8*x1+0.5*x2+1.0*x3+0.5*x4+0.5*x5 <= 2500.0)

# Comando para o solver otimizar a função
optimize!(model)

# Análise de Sensibilidade
report = lp_sensitivity_report(model)

# Valor das variáveis e valor ótimo da função objetivo
println("Valor de x1: ", value(x1))
println("Valor de x2: ", value(x2))
println("Valor de x3: ", value(x3))
println("Valor de x4: ", value(x4))
println("Valor de x5: ", value(x5))
println("Valor da função objetivo: ", objective_value(model))

# Intervalos de variabilidade dos coeficientes da funcão objetivo
println("Intervalos de variabilidade do coeficiente de x1: ", report[x1])
println("Intervalos de variabilidade do coeficiente de x2: ", report[x2])
println("Intervalos de variabilidade do coeficiente de x3: ", report[x3])
println("Intervalos de variabilidade do coeficiente de x4: ", report[x4])
println("Intervalos de variabilidade do coeficiente de x5: ", report[x5])

# Shadow-price das restrições
println("Shadow price da restrição 1: ", shadow_price(constraint1))
println("Shadow price da restrição 2: ", shadow_price(constraint2))
println("Shadow price da restrição 3: ", shadow_price(constraint3))
println("Shadow price da restrição 4: ", shadow_price(constraint4))
println("Shadow price da restrição 5: ", shadow_price(constraint5))
println("Shadow price da restrição 6: ", shadow_price(constraint6))
println("Shadow price da restrição 7: ", shadow_price(constraint7))
println("Shadow price da restrição 8: ", shadow_price(constraint8))

# Reduced costs
println("Reduced cost de x1: ", reduced_cost(x1))
println("Reduced cost de x2: ", reduced_cost(x2))
println("Reduced cost de x3: ", reduced_cost(x3))
println("Reduced cost de x4: ", reduced_cost(x4))
println("Reduced cost de x5: ", reduced_cost(x5))