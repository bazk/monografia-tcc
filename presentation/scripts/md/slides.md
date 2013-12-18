title: Introdução
class: big
build_fade_lists: true

- Robótica de enxame
- Robótica evolutiva
- Contorno do problema e o ambiente de simulação
- Experimentos e resultados

---

title: Robótica de enxame
subtitle: <i style="font-style: italic;">Swarm robotics</i>
class: segue dark nobackground

---

title: Inspiração
content_class: flexbox vcenter

Grupos de indivíduos simples para realização de tarefas complexas

![Enxame de formigas](images/swarm-ants-reduced.jpg) ![Enxame de robôs](images/swarm-scape-reduced.jpg)

Uma colônia pode ser vista como um único super-organismo

---

title: Motivação
build_lists: true

- Flexibilidade
- Robustez
- Descentralização
- Auto-organização

---

title: Classificação

- Movimento coletivo (<i style="font-style: italic;">formation, flocking</i>)
- Busca por alimento
- Transporte coletivo
<li class="highlight">Formação de caminho
- etc.

---

title: Robótica evolutiva
subtitle: <i style="font-style: italic;">Evolutionary robotics</i>
class: segue dark nobackground

---

title: Robótica evolutiva

Síntese de controladores para robôs com uso de algoritmos evolutivos

<br>

Representação do controlador:

- Programas em linguagem de alto nível (programação genética)
<li class="highlight">Redes neurais artificias
- Lógica difusa
- etc.

---

title: Algoritmos

- <i style="font-style: italic;">Genetic Algorithm</i> (GA)
- <i style="font-style: italic;">Coarse-Grained Parallel Genetic Algorithm</i> (CGPGA)
- <i style="font-style: italic;">Particle Swarm Optimization</i> (PSO)
- <i style="font-style: italic;">Discrete Particle Swarm Optimization</i> (DPSO)

---

title: Contorno do problema e o ambiente de simulação
class: segue dark nobackground

---

title: O robô
content_class: flexbox vcenter

![o robô e-puck](images/epuck-big.jpg)

---

title: O ambiente
content_class: flexbox vcenter

![o ambiente](images/path-formation.png)

---

title: A função de <i style="font-style: italic;">fitness</i>
content_class: flexbox vcenter

![função de fitness](images/fitness.png)

---

title: O simulador
content_class: flexbox vcenter

## 500 x 120 x 16 x 10 min = 9.600.000 min

---

title: O simulador
content_class: flexbox vcenter

## No simulador com OpenCL: 300 min

---

title: Experimentos e resultados
class: segue dark nobackground

---

title: Comportamento observado

[Link para os experimentos](http://solace.eburatti.org)

---

title: Comparações entre funções de <i style="font-style: italic;">fitness</i>

<table>
    <tr><th>Instância</th><th>Função</th><th>A (eixos)</th><th>D (distâncias)</th></tr>
    <tr><td><b>f1</b></td><td>16-FFM</td><td>-</td><td>-</td></tr>
    <tr><td><b>f2</b></td><td>1-FFC</td><td>{0; 45; 90; 135}</td><td>{0, 8; 1, 0; 1, 2; 1, 4}</td></tr>
    <tr><td><b>f3</b></td><td>4-FFC</td><td>{0; 45; 90; 135}</td><td>{1, 2}</td></tr>
    <tr><td><b>f4</b></td><td>4-FFC</td><td>{1, 2}</td><td>{0, 8; 1, 0; 1, 2; 1, 4}</td></tr>
</table>
---

title: Comparações entre funções de <i style="font-style: italic;">fitness</i>
content_class: flexbox vcenter

![f1](charts/fitness-f1.png) ![f2](charts/fitness-f2.png)

![f3](charts/fitness-f3.png) ![f4](charts/fitness-f4.png)

---

title: Comparações entre funções de <i style="font-style: italic;">fitness</i>
content_class: flexbox vcenter

![reeval](charts/reeval.png)

---

title: Comparações entre algoritmos de treinamento
content_class: flexbox vcenter

![compare](charts/compare.png)

---

title: Comparações entre algoritmos de treinamento
content_class: flexbox vcenter

![GA](charts/fitness-GA.png) ![CGPGA](charts/fitness-CGPGA.png)

![PSO](charts/fitness-PSO.png) ![DPSO](charts/fitness-DPSO.png)
---

title: Ajuste de parâmetros
content_class: flexbox vcenter

![mutation](charts/mutation.png) ![elitism](charts/elitism.png)

---

title: Trabalhos futuros

- Análise outras topologias de vizinhança para o PSO

- Experimentação com outras redes neurais, em especial as auto-organizáveis