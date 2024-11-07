## Introdução

### O que é JuMP?

JuMP é uma linguagem de modelagem específica para otimização matemática, incorporada no Julia.

JuMP facilita a formulação e resolução de uma variedade de classes de problemas, incluindo programas lineares, programas inteiros, programas cônicos, programas semidefinidos e 
programas não lineares com restrições. Além disso, JuMP é geralmente usado em conjunto com pacotes de solucionadores e extensões.

#### O que é um solucionador?

Um solucionador é um pacote de software que incorpora algoritmos para encontrar soluções para uma ou mais classes de problemas.
Por exemplo, o GLPK é um solucionador para problemas de programação linear (LP) e programação inteira mista (MIP). Ele incorpora algoritmos como o método simplex e o método de ponto interior.

#### Um exemplo

Vamos resolver o seguinte problema de programação linear usando o JuMP e o GLPK. Primeiro, veremos o código completo para resolver o problema e depois o analisaremos passo a passo.
Aqui está o problema:

![Alt text](https://github.com/petimatematica/intro_otimizacao_linear/blob/main/Problema.PNG)

aqui está o código para resolver este problema:

```julia
using JuMP # Carregar o JuMP
using GLPK # Carregando o solver

model = Model(GLPK.Optimizer) #Criando um modelo passando um otimizador para a função Model

@variables model begin # Inicializado as variáveis do problema e algumas das restrições
    x1 >= 320.0 # Restrição 5
    x2 >= 380.0 # Restrição 6
    x3 >= 450.0 # Restrição 7
    x4 >= 240.0 # Restrição 8
    x5 >= 280.0 # Restrição 9
end

# Determinar a função objetivo e especificar se o problema é de minimização ou de maximização
@objective(model, Max, 0.80x1+0.70x2+1.15x3+1.30x4+0.70x5) # Neste caso o problema é de maximização

# Restrições do problema
@constraint(model, 0.70x1+0.40x2+0.40x3+0.60x4+0.60x5 <= 1200.0) # Restrição 1
@constraint(model, 0.16x1+0.22x2+0.32x3+0.19x4+0.23x5 <= 460.0) # Restrição 2
@constraint(model, 0.25x1+0.33x2+0.33x3+0.40x4+0.47x5 <= 650.0) # Restrição 3
@constraint(model, 0.05x1+0.12x2+0.09x3+0.04x4+0.16x5 <= 170.0) # Restrição 4

# Comando para o solver otimizar a função
optimize!(model)

# Valor das variáveis e valor ótimo da função objetivo
println("Valor de x1: ", value(x1))
println("Valor de x2: ", value(x2))
println("Valor de x3: ", value(x3))
println("Valor de x4: ", value(x4))
println("Valor de x5: ", value(x5))
println("Valor da função objetivo: ", objective_value(model))
```

Rodando o código acima obtemos o seguinte resultado:
