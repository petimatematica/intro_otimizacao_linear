using JuMP, GLPK # Carregando os pacotes necessários

model = Model(GLPK.Optimizer)

@variables model begin # Inicializado as variáveis do problema
    xC >= 0; xT >= 0
end

# Determinar a função objetivo e especificar se o problema é de minimização ou de maximização
@objective(model, Max, 12*xC+60*xT)

constraint1 = @constraint(model, 0.25*xC + 0.50*xT <= 36.0)
constraint2 = @constraint(model, 0.10*xC + 0.75*xT <= 22.0)
constraint3 = @constraint(model, 0.10*xC + 0.40*xT <= 15.0)

# Comando para o solver otimizar a função
optimize!(model)

# Análise de Sensibilidade
report = lp_sensitivity_report(model)

# Valor das variáveis e valor ótimo da função objetivo
println("Valor de xC: ", value(xC))
println("Valor de xT: ", value(xT))
println("Valor da função objetivo: ", objective_value(model))

# Intervalos de variabilidade dos coeficientes da funcão objetivo
println("Intervalos de variabilidade do coeficiente de xC: ", report[xC])
println("Intervalos de variabilidade do coeficiente de xT: ", report[xT])

# Shadow-price das restrições
println("Shadow price da restrição 1: ", shadow_price(constraint1))
println("Shadow price da restrição 2: ", shadow_price(constraint2))
println("Shadow price da restrição 3: ", shadow_price(constraint3))

# Reduced costs
println("Reduced cost de xC: ", reduced_cost(xC))
println("Reduced cost de xT: ", reduced_cost(xT))