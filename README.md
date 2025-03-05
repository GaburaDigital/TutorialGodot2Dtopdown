# Tutorial Godot2D topdown

Olá nerds! Fiz esse material como recurso didático para quem tá começando a estudar programação de jogos na Engine GODOT. São um conjunto de 6 exemplos que ajudam a fazer um jogo 2D na Godot 4.

O jogo base para esse projeto está disponível aqui: https://gabura.itch.io/topdown-tank-shooter

As mecânicas deste tutorial são:
- Movimento em 4 direções
- Atirar projéteis
- Obstáculos quebráveis
- Portas com botão de acionamento remoto
- Coletáveis, Hud e Câmera
- Movimento de inimigos

## Movimento em 4 direções e Colisão
Mecânica base para mover personagens de jogo com mapa "topdown"(com a Câmera vendo a ação de cima). A opção de mover apenas em 4 direções(Cima, Baixo, Esquerda e Direita) é uma escolha estética comum em jogos de RPG. A base do código pode ser utilizado em jogos com apenas 2 direções(Esquerda e Direita) como "Space Invaders" ou então para criar jogos com movimento em 8 direções(4 movimentos mais diagonais).

![gif de jogo com icone de tank se movendo e colidindo com paredes](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/movimento4direcoes.gif)

### CharacterBody2D
O nó "CharacterBody2D" é um nó de física que vem com comportamentos pré definidos para simular gravidade e colisão com outros nós como "RigidBody2D" e "StaticBody2D". Ele é recomendado quando se tem um controle de movimento pela programação. Ele precisa de um "CollisionShape2D" para delimitar a area tocável. Geralmente é usado em personagens de plataforma, como o projeot não precisa de simulação de gravidade é necessário mudar o parâmetro "Motion Mode"(Modo de Movimento) para Floating(Flutuando).

### StaticBody2D
Utilizei o "StaticBody2D" para fazer as paredes da cena. Ele também precisa de uma área de colisão, usei o "Polygon2D" e "CollisionPolygo2D" para desenhar a parte visível e a parte tocável das paredes. 

### Programação do Controle e Movimento
O movimento do "CharacterBody2D" foi criado com o método move_and_collide(). Ele movimenta o "corpo"(física) com base em um Vector2D como argumento. Exemplo move_and_collide(100,0) move o corpo para a direira pois estamos incrementando o "x". Outro Exemplo move_and_collide(0,-100) move o corpo para cima pois subtrai o "y" da posição do corpo. Ao se mover com esse método o "corpo" para ou oferece resistência quando colide com outros corpos.

O movimento ocorre dentro de "_physics_process()" que se repete para sempre com dinâmicas físicas. Usei Input.is_action_pressed() para detectar as teclas e atribuir a direção do movimento. A propriedade "velocity" pertence ao "CharacterBody2D".

### Colisões Rígidas
A detecção de colisão entre dois corpos é configurada na região "collision". Ele tem duas sessões, o "Layer"(camada) que delimita quem pode tocar no corpo, o "mask"(máscara) que delimita quem o corpo pode tocar. Por padrão esses corpos vem marcados como "1" ou seja todos se encostam.

## Atirar Projéteis
Essa mecânica "atira" coisas, pode ser usada tanto para ataque do personagem principal como de inimigos. O mais importante dessa parte é saber como "criar instâncias" dentro da cena. Esse teste de exemplo usa 2 cenas, um com um canhão que aponta na direção do mouse e outro que é a "bala" que será gerada como instância da cena do canhão.
![canhão branco atirando balas roxas que somem ao tocar na borda](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/projeteis.gif)

### VisibleOnScreenNotifier2D
Para fazer a bala utilizei um "node2D" genérico como raiz junto com "Area2D" e "VisibleOnScreenNotifier2D". Esse segundo serve para avisar quando o nó sai ou entra na tela visível. O objetivo é fazer a bala desaparecer ao sair da tela, então esse nó será importante.

### Marker2D
Um nó importante para fazer o objeto atirador é o "Marker2D", é um ponto que marcamos no desenho para inidicar onde vai ser criado algo. Nesse exemplo usei na ponta do canhão. Ele tem que ser colocado como filho do nó para que seu movimento seja relativo ao do "pai".

### Programação do movimento da bala
O movimento da bala é feito incrementando a posição dentro de "_process()". Combinando o valor de velocidade com a propriedade "transform.x" temos o movimento com relação ao ângulo de rotação. Usei o sinal screen_exited() do VisibleOnScreenNotifier2D para excluir a instância.

### Criando a instância da bala
Na cena do objeto que atira precisamos carregar a bala no início dentro de uma variável(ou constante) usando a função "preload()", nele colocamos o caminho da cena. Para criar a instância no momento certo é preciso fazer uma nova variável com o método .instantiate() da cena precarregada. Depois precisamos adicinar a cena raiz com get_tree().root.add_child(). Depois disso definimos a posição inicial da bala atribuindo a posição global para a posição do "Marker2D".

## Obstáculos quebráveis
![sprite com martelo batendo em cubos e quebrando](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/quebrarPedra.gif)

## Porta com acionamento remoto
![Sprite apertando botão que gira portão e abre passagem](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/portaControle.gif)

## Coletáveis, Hud e Câmera
![Sprite moviendo pela tela coletando moedas, texto de pontos dendo atualizado](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/coletHUDcamera.gif)

## Movimento dos inimigos
![Sprites de inimigos se movendo em padrão linear](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/inimigoMOVIMENTO.gif)
