using JuMP, GLPK # Carregando os pacotes necessários

model = Model(GLPK.Optimizer)

@variables model begin # Inicializado as variáveis do problema
    x11 >= 0; x12 >= 0; x13 >= 0; x21 >= 0; x22 >= 0; x23 >= 0; x31 >= 0; x32 >= 0; x33 >= 0
end

# Determinar a função objetivo e especificar se o problema é de minimização ou de maximização
@objective(model, Max, 3*x11+2*x21+2*x31+5*x12+4*x22+4*x32+6*x13+5*x23+5*x33)

constraint1 = @constraint(model, 0.30*x11 - 0.70*x21 - 0.70*x31 <= 0)
constraint2 = @constraint(model, 0.50*x12 - 0.50*x22 - 0.50*x32 <= 0)
constraint3 = @constraint(model, -0.10*x12 + 0.90*x22 - 0.10*x32 >= 0)
constraint4 = @constraint(model, -0.40*x13 - 0.40*x23 + 0.60*x33 >= 0)
constraint5 = @constraint(model, -0.50*x13 + 0.50*x23 - 0.50*x33 <= 0)
constraint6 = @constraint(model, x11 + x21 + x31 >= 5000.0)
constraint7 = @constraint(model, x12 + x22 + x32 >= 3000.0)
constraint8 = @constraint(model, x13 + x23 + x33 >= 3000.0)
constraint9 = @constraint(model, x11 + x12 + x13 <= 10000.0)
constraint10 = @constraint(model, x21 + x22 + x23 <= 8000.0)
constraint11 = @constraint(model, x31 + x32 + x33 <= 7000.0)
constraint12 = @constraint(model, x11 + x21 + x31 + x12 + x22 + x32 + x13 + x23 + x33 <= 20000.0)

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
println("Valor de x31: ", value(x31))
println("Valor de x32: ", value(x32))
println("Valor de x33: ", value(x33))
println("Valor da função objetivo: ", objective_value(model))

# Intervalos de variabilidade dos coeficientes da funcão objetivo
println("Intervalos de variabilidade do coeficiente de x11: ", report[x11])
println("Intervalos de variabilidade do coeficiente de x12: ", report[x12])
println("Intervalos de variabilidade do coeficiente de x13: ", report[x13])
println("Intervalos de variabilidade do coeficiente de x21: ", report[x21])
println("Intervalos de variabilidade do coeficiente de x22: ", report[x22])
println("Intervalos de variabilidade do coeficiente de x23: ", report[x23])
println("Intervalos de variabilidade do coeficiente de x31: ", report[x31])
println("Intervalos de variabilidade do coeficiente de x32: ", report[x32])
println("Intervalos de variabilidade do coeficiente de x33: ", report[x33])

# Shadow-price das restrições
println("Shadow price da restrição 1: ", shadow_price(constraint1))
println("Shadow price da restrição 2: ", shadow_price(constraint2))
println("Shadow price da restrição 3: ", shadow_price(constraint3))
println("Shadow price da restrição 4: ", shadow_price(constraint4))
println("Shadow price da restrição 5: ", shadow_price(constraint5))
println("Shadow price da restrição 6: ", shadow_price(constraint6))
println("Shadow price da restrição 7: ", shadow_price(constraint7))
println("Shadow price da restrição 8: ", shadow_price(constraint8))
println("Shadow price da restrição 9: ", shadow_price(constraint9))
println("Shadow price da restrição 10: ", shadow_price(constraint10))
println("Shadow price da restrição 11: ", shadow_price(constraint11))
println("Shadow price da restrição 12: ", shadow_price(constraint12))