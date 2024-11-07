using JuMP, GLPK # Carregando os pacotes necessários

model = Model(GLPK.Optimizer)

@variables model begin # Inicializado as variáveis do problema
    xluxo >= 0; xbasico >= 0
end

# Determinar a função objetivo e especificar se o problema é de minimização ou de maximização
@objective(model, Max, 100*xluxo+50*xbasico)

constraint1 = @constraint(model, 10*xluxo + 8*xbasico <= 25000.0)
constraint2 = @constraint(model, xluxo + xbasico <= 4500.0)
constraint3 = @constraint(model, xluxo <= 1500.0)
constraint4 = @constraint(model, xluxo <= 6000.0)

# Comando para o solver otimizar a função
optimize!(model)

# Análise de Sensibilidade
report = lp_sensitivity_report(model)

# Valor das variáveis e valor ótimo da função objetivo
println("Valor de xluxo: ", value(xluxo))
println("Valor de xbasico: ", value(xbasico))
println("Valor da função objetivo: ", objective_value(model))

# Intervalos de variabilidade dos coeficientes da funcão objetivo
println("Intervalos de variabilidade do coeficiente de xluxo: ", report[xluxo])
println("Intervalos de variabilidade do coeficiente de xbasico: ", report[xbasico])

# Shadow-price das restrições
println("Shadow price da restrição 1: ", shadow_price(constraint1))
println("Shadow price da restrição 2: ", shadow_price(constraint2))
println("Shadow price da restrição 3: ", shadow_price(constraint3))
println("Shadow price da restrição 4: ", shadow_price(constraint4))

# Reduced costs
println("Reduced cost de xluxo: ", reduced_cost(xluxo))
println("Reduced cost de xbasico: ", reduced_cost(xbasico))