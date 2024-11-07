using JuMP, GLPK # Carregando os pacotes necessários

model = Model(GLPK.Optimizer)

@variables model begin # Inicializado as variáveis do problema
    x11 >= 0; x12 >= 0; x13 >= 0; x21 >= 0; x22 >= 0; x23 >= 0; x31 >= 0; x32 >= 0; x33 >= 0; x41 >=0; x42 >= 0; x43 >= 0
end

# Determinar a função objetivo e especificar se o problema é de minimização ou de maximização
@objective(model, Min, 30*x11+13*x12+21*x13+12*x21+40*x22+26*x23+27*x31+15*x32+35*x33+37*x41+25*x42+19*x43)

constraint1 = @constraint(model, x11 + x12 + x13 <= 433.0)
constraint2 = @constraint(model, x21 + x22 + x23 <= 215.0)
constraint3 = @constraint(model, x31 + x32 + x33 <= 782.0)
constraint4 = @constraint(model, x41 + x42 + x43 <= 300.0)
constraint5 = @constraint(model, x11 + x21 + x31 + x41 == 697.0)
constraint6 = @constraint(model, x12 + x22 + x32 + x42 == 421.0)
constraint7 = @constraint(model, x13 + x23 + x33 + x43 == 612.0)

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
println("Valor de x41: ", value(x41))
println("Valor de x42: ", value(x42))
println("Valor de x43: ", value(x43))
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
println("Intervalos de variabilidade do coeficiente de x41: ", report[x41])
println("Intervalos de variabilidade do coeficiente de x42: ", report[x42])
println("Intervalos de variabilidade do coeficiente de x43: ", report[x43])

# Shadow-price das restrições
println("Shadow price da restrição 1: ", shadow_price(constraint1))
println("Shadow price da restrição 2: ", shadow_price(constraint2))
println("Shadow price da restrição 3: ", shadow_price(constraint3))
println("Shadow price da restrição 4: ", shadow_price(constraint4))
println("Shadow price da restrição 5: ", shadow_price(constraint5))
println("Shadow price da restrição 6: ", shadow_price(constraint6))
println("Shadow price da restrição 7: ", shadow_price(constraint7))

# Reduced costs
println("Reduced cost de x11: ", reduced_cost(x11))
println("Reduced cost de x12: ", reduced_cost(x12))
println("Reduced cost de x13: ", reduced_cost(x13))
println("Reduced cost de x21: ", reduced_cost(x21))
println("Reduced cost de x22: ", reduced_cost(x22))
println("Reduced cost de x23: ", reduced_cost(x23))
println("Reduced cost de x31: ", reduced_cost(x31))
println("Reduced cost de x32: ", reduced_cost(x32))
println("Reduced cost de x33: ", reduced_cost(x33))
println("Reduced cost de x41: ", reduced_cost(x41))
println("Reduced cost de x42: ", reduced_cost(x42))
println("Reduced cost de x43: ", reduced_cost(x43))