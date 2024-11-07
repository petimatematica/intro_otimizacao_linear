using JuMP, GLPK # Carregando os pacotes necessários

model = Model(GLPK.Optimizer)

@variables model begin # Inicializado as variáveis do problema
    x11 >= 0; x12 >= 0; x13 >= 0; x21 >= 0; x22 >= 0; x23 >= 0
end

# Determinar a função objetivo e especificar se o problema é de minimização ou de maximização
@objective(model, Min, 4*x11+2*x12+5*x13+11*x21+7*x22+4*x23)

constraint1 = @constraint(model, x11 + x12 + x13 <= 800.0)
constraint2 = @constraint(model, x21 + x22 + x23 <= 1000.0)
constraint3 = @constraint(model, x11 + x21 == 500.0)
constraint4 = @constraint(model, x12 + x22 == 400.0)
constraint5 = @constraint(model, x13 + x23 == 900.0)

# Comando para o solver otimizar a função
optimize!(model)

# Análise de Sensibilidade
report = lp_sensitivity_report(model)

# Valor das variáveis e valor ótimo da função objetivo
println("Valor de x11: ", value(x11))
println("Valor de x12: ", value(x12))
println("Valor de x13: ", value(x13))
println("Valor de x21: ", value(x21))
println("Valor de x22: ", value(x22))
println("Valor de x23: ", value(x23))
println("Valor da função objetivo: ", objective_value(model))

# Intervalos de variabilidade dos coeficientes da funcão objetivo
println("Intervalos de variabilidade do coeficiente de x11: ", report[x11])
println("Intervalos de variabilidade do coeficiente de x12: ", report[x12])
println("Intervalos de variabilidade do coeficiente de x13: ", report[x13])
println("Intervalos de variabilidade do coeficiente de x21: ", report[x21])
println("Intervalos de variabilidade do coeficiente de x22: ", report[x22])
println("Intervalos de variabilidade do coeficiente de x23: ", report[x23])

# Shadow-price das restrições
println("Shadow price da restrição 1: ", shadow_price(constraint1))
println("Shadow price da restrição 2: ", shadow_price(constraint2))
println("Shadow price da restrição 3: ", shadow_price(constraint3))
println("Shadow price da restrição 4: ", shadow_price(constraint4))
println("Shadow price da restrição 5: ", shadow_price(constraint5))

# Reduced costs
println("Reduced cost de x11: ", reduced_cost(x11))
println("Reduced cost de x12: ", reduced_cost(x12))
println("Reduced cost de x13: ", reduced_cost(x13))
println("Reduced cost de x21: ", reduced_cost(x21))
println("Reduced cost de x22: ", reduced_cost(x22))
println("Reduced cost de x23: ", reduced_cost(x23))