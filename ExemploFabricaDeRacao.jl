using JuMP, GLPK # Carregando os pacotes necessários

model = Model(GLPK.Optimizer)

@variables model begin # Inicializado as variáveis do problema
    xosso >= 0; xsoja >= 0; xpeixe >= 0
end

# Determinar a função objetivo e especificar se o problema é de minimização ou de maximização
@objective(model, Min, 0.56*xosso+0.81*xsoja+0.46*xpeixe)

constraint1 = @constraint(model, 0.2*xosso + 0.5*xsoja + 0.4*xpeixe >= 0.3)
constraint2 = @constraint(model, 0.6*xosso + 0.4*xsoja + 0.4*xpeixe >= 0.5)
constraint3 = @constraint(model, xosso + xsoja + xpeixe == 1)

# Comando para o solver otimizar a função
optimize!(model)

# Análise de Sensibilidade
report = lp_sensitivity_report(model)

# Valor das variáveis e valor ótimo da função objetivo
println("Valor de xosso: ", value(xosso))
println("Valor de xsoja: ", value(xsoja))
println("Valor de xpeixe: ", value(xpeixe))
println("Valor da função objetivo: ", objective_value(model))

# Intervalos de variabilidade dos coeficientes da funcão objetivo
println("Intervalos de variabilidade do coeficiente de xosso: ", report[xosso])
println("Intervalos de variabilidade do coeficiente de xsoja: ", report[xsoja])
println("Intervalos de variabilidade do coeficiente de xpeixe: ", report[xpeixe])

# Shadow-price das restrições
println("Shadow price da restrição 1: ", shadow_price(constraint1))
println("Shadow price da restrição 2: ", shadow_price(constraint2))
println("Shadow price da restrição 3: ", shadow_price(constraint3))

# Reduced costs
println("Reduced cost de xosso: ", reduced_cost(x11))
println("Reduced cost de xsoja: ", reduced_cost(x12))
println("Reduced cost de xpeixe: ", reduced_cost(x13))