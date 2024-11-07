using JuMP, GLPK # Carregando os pacotes necessários

model = Model(GLPK.Optimizer)


@variable(model, y1 >= 0.0, Int)
@variable(model, y2 >= 0.0, Int)
@variable(model, y3 >= 0.0, Int)
@variable(model, y4 >= 0.0, Int)
@variable(model, y5 >= 0.0, Int)
@variable(model, y6 >= 0.0, Int)

# @variables model begin # Inicializado as variáveis do problema
#     y1 >= 0.0; y2 >= 0.0; y3 >= 0.0; y4 >= 0.0; y5 >= 0.0; y6 >= 0.0
# end

# Determinar a função objetivo e especificar se o problema é de minimização ou de maximização
@objective(model, Min, y1+y2+y3+y4+y5+y6)

constraint1 = @constraint(model, 10.0*0.1*y1 + 1.0*0.1*y2 + 0.1*y4 == 5.0)
constraint2 = @constraint(model, 8.0*0.1125*y2 + 4.0*0.1125*y5 == 3.5)
constraint3 = @constraint(model, 7.0*0.1375*y3 + 4.0*0.1375*y5 + 4.0*0.1375*y6 == 4.0)
constraint4 = @constraint(model, 6.0*0.15*y4 + 3.0*0.15*y6 == 5.0)

map = relax_with_penalty!(model)

# Comando para o solver otimizar a função
optimize!(model)

# Análise de Sensibilidade
# report = lp_sensitivity_report(model)

# Valor das variáveis e valor ótimo da função objetivo
println("Valor de y1: ", value(y1))
println("Valor de y2: ", value(y2))
println("Valor de y3: ", value(y3))
println("Valor de y4: ", value(y4))
println("Valor de y5: ", value(y5))
println("Valor de y6: ", value(y6))
println("Valor da função objetivo: ", objective_value(model))

# Intervalos de variabilidade dos coeficientes da funcão objetivo
# println("Intervalos de variabilidade do coeficiente de y1: ", report[y1])
# println("Intervalos de variabilidade do coeficiente de y2: ", report[y2])
# println("Intervalos de variabilidade do coeficiente de y3: ", report[y3])
# println("Intervalos de variabilidade do coeficiente de y4: ", report[y4])
# println("Intervalos de variabilidade do coeficiente de y5: ", report[y5])
# println("Intervalos de variabilidade do coeficiente de y6: ", report[y6])

# Shadow-price das restrições
# println("Shadow price da restrição 1: ", shadow_price(constraint1))
# println("Shadow price da restrição 2: ", shadow_price(constraint2))
# println("Shadow price da restrição 3: ", shadow_price(constraint3))
# println("Shadow price da restrição 4: ", shadow_price(constraint4))

# # Reduced costs
# println("Reduced cost de y1: ", reduced_cost(y1))
# println("Reduced cost de y2: ", reduced_cost(y2))
# println("Reduced cost de y3: ", reduced_cost(y3))
# println("Reduced cost de y4: ", reduced_cost(y4))
# println("Reduced cost de y5: ", reduced_cost(y5))