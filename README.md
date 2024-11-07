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

![Alt text](https://github.com/petimatematica/intro_otimizacao_linear/blob/main/ProblemaI.PNG)

```julia
include("testfunctions.jl"); include("projections.jl")

x0 = ones(100) # guess
F = gradsumsquares # see testfunctions.jl for more details
proj = projRplus # see projections.jl for more details

x,k,t,nFx,Fevals,error=ding(x0,F,proj, maxiter=1.e4) # see search.jl for more details
```
