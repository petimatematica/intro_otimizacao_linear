using JuMP, GLPK # Carregando os pacotes necessários

# Exemplo 6.2 Patricia Belfiore (Programação Inteira)

model = Model(GLPK.Optimizer)

@variable(model, x[1:2], Int)

# Determinar a função objetivo e especificar se o problema é de minimização ou de maximização
@objective(model, Max, 4x[1]+5x[2])

@constraint(model, c1, 5x[1]+7x[2] <= 44)
@constraint(model, c2, 4x[1]+2x[2] <= 27)
@constraint(model, c3, 6x[1]+3x[2] <= 24)
@constraint(model, c4, x[1] >= 0)
@constraint(model, c5, x[2] >= 0)


# Comando para o solver otimizar a função
optimize!(model)

# Análise de Sensibilidade
# report = lp_sensitivity_report(model)

# Valor das variáveis e valor ótimo da função objetivo
println("Valor de x1(Int): ", value(x[1]))
println("Valor de x2(Int): ", value(x[2]))
println("Valor da função objetivo: ", objective_value(model))

# Exemplo 6.4 Patricia Belfiore (Programação Binária)

# model = Model(GLPK.Optimizer)

# @variable(model, x[1:3], Bin)

# # Determinar a função objetivo e especificar se o problema é de minimização ou de maximização
# @objective(model, Min, 4x[1]+3x[2]+2x[3])

# @constraint(model, c6, 2x[1]+2x[2]+4x[3] >= 8)
# @constraint(model, c7, 3x[1]+2x[2]+3x[3] >= 6)
# @constraint(model, c8, 4x[1]+3x[2]+2x[3] >= 7)


# # Comando para o solver otimizar a função
# optimize!(model)

# # Análise de Sensibilidade
# # report = lp_sensitivity_report(model)

# # Valor das variáveis e valor ótimo da função objetivo
# println("Valor de x1(Bin): ", value(x[1]))
# println("Valor de x2(Bin): ", value(x[2]))
# println("Valor de x3(Bin): ", value(x[3]))
# println("Valor da função objetivo: ", objective_value(model))

# # Exemplo 6.5 Patricia Belfiore (Programação Inteira Mista)

# model = Model(GLPK.Optimizer)

# @variable(model, x1 >=0, Int)
# @variable(model, x2 >=0, Int)
# @variable(model, x3 >=0)

# # Determinar a função objetivo e especificar se o problema é de minimização ou de maximização
# @objective(model, Max, 2x1+3x2+2x3)

# @constraint(model, c9, x1+1.5x3 <=19)
# @constraint(model, c10, x1+3x2 <= 33)
# @constraint(model, c11, 4x2 <= 37)


# # Comando para o solver otimizar a função
# optimize!(model)

# # Análise de Sensibilidade
# # report = lp_sensitivity_report(model)

# # Valor das variáveis e valor ótimo da função objetivo
# println("Valor de x1: ", value(x1))
# println("Valor de x2: ", value(x2))
# println("Valor de x3: ", value(x3))
# println("Valor da função objetivo: ", objective_value(model))

# # Exemplo 6.8 Patricia Belfiore 

# model = Model(GLPK.Optimizer)

# @variable(model, x[1:5], Bin)

# # Determinar a função objetivo e especificar se o problema é de minimização ou de maximização
# @objective(model, Max, 22x[1]+17x[2]+16x[3]+14x[4]+20x[5])

# @constraint(model, c12, 5x[1]+4x[2]+3x[3]+4x[4]+5x[5] <= 12)
# @constraint(model, c13, 4x[1]+3x[2]+2x[3]+1x[4]+3x[5] <= 10)
# @constraint(model, c14, 6x[1]+3x[2]+1x[3]+2x[4]+6x[5] <= 9)


# # Comando para o solver otimizar a função
# optimize!(model)

# # Valor das variáveis e valor ótimo da função objetivo
# println("Valor de x1(Bin): ", value(x[1]))
# println("Valor de x2(Bin): ", value(x[2]))
# println("Valor de x3(Bin): ", value(x[3]))
# println("Valor de x4(Bin): ", value(x[4]))
# println("Valor de x5(Bin): ", value(x[5]))
# println("Valor da função objetivo: ", objective_value(model))

# # Exemplo 6.9 Patricia Belfiore (Caixeiro Viajante)

# model = Model(GLPK.Optimizer)

# @variable(model, x[1:5, 1:5], Bin)

# D=[0 22.36 72.11 60.00 82.46; 
# 22.36 0 50.00 53.85 70.00;
# 72.11 50.00 0 63.25 56.57;
# 60.00 53.85 63.25 0 28.28;
# 82.46 70.00 56.57 28.28 0]

# # Determinar a função objetivo e especificar se o problema é de minimização ou de maximização
# @objective(model, Min, sum(D[i, j] * x[i, j] for i in 1:5, j in 1:5))

# @constraint(model, d1, x[2,1]+x[3,1]+x[4,1]+x[5,1] == 1)
# @constraint(model, d2, x[1,2]+x[3,2]+x[4,2]+x[5,2] == 1)
# @constraint(model, d3, x[1,3]+x[2,3]+x[4,3]+x[5,3] == 1)
# @constraint(model, d4, x[1,4]+x[2,4]+x[3,4]+x[5,4] == 1)
# @constraint(model, d5, x[1,5]+x[2,5]+x[3,5]+x[4,5] == 1)
# @constraint(model, d6, x[1,2]+x[1,3]+x[1,4]+x[1,5] == 1)
# @constraint(model, d7, x[2,1]+x[2,3]+x[2,4]+x[2,5] == 1)
# @constraint(model, d8, x[3,1]+x[3,2]+x[3,4]+x[3,5] == 1)
# @constraint(model, d9, x[4,1]+x[4,2]+x[4,3]+x[4,5] == 1)
# @constraint(model, d10, x[5,1]+x[5,2]+x[5,3]+x[5,4] == 1)
# @constraint(model, d11, x[1,2]+x[2,1] <= 1)
# @constraint(model, d12, x[1,3]+x[3,1] <= 1)
# @constraint(model, d13, x[1,4]+x[4,1] <= 1)
# @constraint(model, d14, x[1,5]+x[5,1] <= 1)
# @constraint(model, d15, x[2,3]+x[3,2] <= 1)
# @constraint(model, d16, x[2,4]+x[4,2] <= 1)
# @constraint(model, d17, x[2,5]+x[5,2] <= 1)
# @constraint(model, d18, x[3,4]+x[4,3] <= 1)
# @constraint(model, d19, x[3,5]+x[5,3] <= 1)
# @constraint(model, d20, x[4,5]+x[5,4] <= 1)
# @constraint(model, d21, x[1,2]+x[2,3]+x[3,1] <= 2)
# @constraint(model, d22, x[1,2]+x[2,4]+x[4,1] <= 2)
# @constraint(model, d23, x[1,2]+x[2,5]+x[5,1] <= 2)
# @constraint(model, d24, x[1,3]+x[3,4]+x[4,1] <= 2)
# @constraint(model, d25, x[1,3]+x[3,5]+x[5,1] <= 2)
# @constraint(model, d26, x[1,4]+x[4,5]+x[5,1] <= 2)
# @constraint(model, d27, x[2,3]+x[3,4]+x[4,2] <= 2)
# @constraint(model, d28, x[2,3]+x[3,5]+x[5,2] <= 2)
# @constraint(model, d29, x[2,4]+x[4,5]+x[5,2] <= 2)
# @constraint(model, d30, x[3,4]+x[4,5]+x[5,3] <= 2)
# @constraint(model, d31, x[1,2]+x[2,3]+x[3,4]+x[4,1] <= 3)
# @constraint(model, d32, x[1,2]+x[2,3]+x[3,5]+x[5,1] <= 3)
# @constraint(model, d33, x[1,2]+x[2,4]+x[4,5]+x[5,1] <= 3)
# @constraint(model, d34, x[1,3]+x[3,4]+x[4,5]+x[5,1] <= 3)
# @constraint(model, d35, x[2,3]+x[3,4]+x[4,5]+x[5,2] <= 3)

# # Comando para o solver otimizar a função
# optimize!(model)

# # Valor das variáveis e valor ótimo da função objetivo
# for i in 1:5, j in 1:5 
#     if value(x[i,j])==1.0
#         println("Valor de x[$i,$j]: ", value.(x[i,j]))
#     end
# end
# println("Valor da função objetivo: ", objective_value(model))
