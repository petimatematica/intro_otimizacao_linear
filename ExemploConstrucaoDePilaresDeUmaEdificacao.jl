using JuMP, GLPK # Carregando os pacotes necessários

model = Model(GLPK.Optimizer)

@variables model begin # Inicializado as variáveis do problema
    tA >= 0; tB >= 0; tC >= 0; tD >= 0; tE >= 0; tF >= 0; tG >= 0; tH >= 0
end

# Determinar a função objetivo e especificar se o problema é de minimização ou de maximização
@objective(model, Min, tH+3)

# Deteminar as restrições
constraint1 = @constraint(model, tC >= tA+6)
constraint2 = @constraint(model, tD >= tB+5)
constraint3 = @constraint(model, tD >= tC+4)
constraint4 = @constraint(model, tF >= tE+2)
constraint5 = @constraint(model, tF >= tD+2)
constraint6 = @constraint(model, tG >= tF+3)
constraint6 = @constraint(model, tH >= tG+72)

# Comando para o solver otimizar a função
optimize!(model)

# Análise de Sensibilidade
report = lp_sensitivity_report(model)

# Valor das variáveis e valor ótimo da função objetivo
println("Valor de tA: ", value(tA))
println("Valor de tB: ", value(tB))
println("Valor de tC: ", value(tC))
println("Valor de tD: ", value(tD))
println("Valor de tE: ", value(tE))
println("Valor de tF: ", value(tF))
println("Valor de tG: ", value(tG))
println("Valor de tH: ", value(tH))
println("Valor da função objetivo: ", objective_value(model))

# Intervalos de variabilidade dos coeficientes da funcão objetivo
println("Intervalos de variabilidade do coeficiente de tA: ", report[tA])
println("Intervalos de variabilidade do coeficiente de tB: ", report[tB])
println("Intervalos de variabilidade do coeficiente de tC: ", report[tC])
println("Intervalos de variabilidade do coeficiente de tD: ", report[tD])
println("Intervalos de variabilidade do coeficiente de tE: ", report[tE])
println("Intervalos de variabilidade do coeficiente de tF: ", report[tF])
println("Intervalos de variabilidade do coeficiente de tG: ", report[tG])
println("Intervalos de variabilidade do coeficiente de tH: ", report[tH])

# Shadow-price das restrições
println("Shadow price da restrição 1: ", shadow_price(constraint1))
println("Shadow price da restrição 2: ", shadow_price(constraint2))
println("Shadow price da restrição 3: ", shadow_price(constraint3))
println("Shadow price da restrição 4: ", shadow_price(constraint4))
println("Shadow price da restrição 5: ", shadow_price(constraint5))
println("Shadow price da restrição 6: ", shadow_price(constraint6))

# Reduced costs
println("Reduced cost de tA: ", reduced_cost(tA))
println("Reduced cost de tB: ", reduced_cost(tB))
println("Reduced cost de tC: ", reduced_cost(tC))
println("Reduced cost de tD: ", reduced_cost(tD))
println("Reduced cost de tE: ", reduced_cost(tE))
println("Reduced cost de tF: ", reduced_cost(tF))
println("Reduced cost de tG: ", reduced_cost(tG))
println("Reduced cost de tH: ", reduced_cost(tH))