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

Execute a cena "movimento_4_direcoes".
![cena movimento em 4 direções](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/cenaMovimento4Direcoes.png)

### CharacterBody2D
O nó "CharacterBody2D" é um nó de física que vem com comportamentos pré definidos para simular gravidade e colisão com outros nós como "RigidBody2D" e "StaticBody2D". Ele é recomendado quando se tem um controle de movimento pela programação. Ele precisa de um "CollisionShape2D" para delimitar a area tocável. Geralmente é usado em personagens de plataforma, como o projeot não precisa de simulação de gravidade é necessário mudar o parâmetro "Motion Mode"(Modo de Movimento) para Floating(Flutuando).
![exemplo de player com CharacterBody2D](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/characterbody2d.png) ![modo floating do CharacterBody2D](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/modoFloating.png)

### StaticBody2D
Utilizei o "StaticBody2D" para fazer as paredes da cena. Ele também precisa de uma área de colisão, usei o "Polygon2D" e "CollisionPolygo2D" para desenhar a parte visível e a parte tocável das paredes. 
![Paredes feitas com polygon2D](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/paredesPolygon2D.png)

### Programação do Controle e Movimento
O movimento do "CharacterBody2D" foi criado com o método move_and_collide(). Ele movimenta o "corpo"(física) com base em um Vector2D como argumento. Exemplo move_and_collide(Vector2(100,0)) move o corpo para a direira pois estamos incrementando o "x". Outro Exemplo move_and_collide(Vector2(0,-100)) move o corpo para cima pois subtrai o "y" da posição do corpo. Ao se mover com esse método o "corpo" para ou oferece resistência quando colide com outros corpos.
![método move_and_collide](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/move_and_collideMetodo.png)
![exemplo de uso do move_and_collide](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/move_and_collideExemplo.png)

O movimento ocorre dentro de "_physics_process()" que se repete para sempre com dinâmicas físicas. Usei Input.is_action_pressed() para detectar as teclas e atribuir a direção do movimento. A propriedade "velocity" pertence ao "CharacterBody2D".
![código de controle de personagem em 4 direções](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/programacao4direcoes.png)

### Colisões
A detecção de colisão entre dois corpos é configurada na região "collision". Ele tem duas sessões, o "Layer"(camada) que delimita quem pode tocar no corpo, o "mask"(máscara) que delimita quem o corpo pode tocar. Por padrão esses corpos vem marcados como "1" ou seja todos se encostam. Por isso tanto o player como a parede tem interação de collisão.

![propriedades layer e mask do Collision](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/CollisionLAYERmask.png)

## Atirar Projéteis
Essa mecânica "atira" coisas, pode ser usada tanto para ataque do personagem principal como de inimigos. O mais importante dessa parte é saber como "criar instâncias" dentro da cena. Esse teste de exemplo usa 2 cenas, um com um canhão que aponta na direção do mouse e outro que é a "bala" que será gerada como instância da cena do canhão.
![canhão branco atirando balas roxas que somem ao tocar na borda](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/projeteis.gif)

Execute a cena projeteis:

![cena projeteis](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/CenaProjeteis.png)

### VisibleOnScreenNotifier2D
Para fazer a bala utilizei um "node2D" genérico como raiz junto com "Area2D" e "VisibleOnScreenNotifier2D". Esse segundo serve para avisar quando o nó sai ou entra na tela visível. O objetivo é fazer a bala desaparecer ao sair da tela, então esse nó será importante.

![cena da bala com VisibleOnScreenNotifier2D](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/visibleOnScreenNotifier2D.png)

### Marker2D
Um nó importante para fazer o objeto atirador é o "Marker2D", é um ponto que marcamos no desenho para inidicar onde vai ser criado algo. Nesse exemplo usei na ponta do canhão. Ele tem que ser colocado como filho do nó para que seu movimento seja relativo ao do "pai".

![Marker2D na ponta do canhão](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/Marker2DCanhao.png)

### Programação do movimento da bala
O movimento da bala é feito incrementando a posição dentro de "_process()". Combinando o valor de velocidade com a propriedade "transform.x" temos o movimento com relação ao ângulo de rotação. Usei o sinal screen_exited() do VisibleOnScreenNotifier2D para excluir a instância.

![codigo programação do movimento da bala](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/codigoMovimentoBala.png)
![destruir cena da bala quando o sinal VisibleOnScreenNotifier2D acionado](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/SinalDestruirBalaSairTela.png)

### Criando a instância da bala
Na cena do objeto que atira precisamos carregar a bala no início dentro de uma variável(ou constante) usando a função "preload()", nele colocamos o caminho da cena. Para criar a instância no momento certo é preciso fazer uma nova variável com o método .instantiate() da cena precarregada. Depois precisamos adicinar a cena raiz com get_tree().root.add_child(). Depois disso definimos a posição inicial da bala atribuindo a posição global para a posição do "Marker2D". Também aplicamos a rotação do objeto atirador para o a instância da bala.

![função de criar bala na cena do canhão](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/CriandoInstanciaBalaNaCena.png)

Por último precisamos "Atirar", ou seja criar a bala no momento certa na cena. Nesse exemplo fiz o canhão apontar para o ponteiro do mouse, ao clicar ele cria a instância da bala.

![input para criar a instância da bala](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/CodigoInputParaAtirar.png)

## Obstáculos quebráveis
Obstáculos como pedras rígidas são uma mecânica que serve para impedir o movimento do jogador no mapa. As "pedras" são corpos físicos que resistem a alguns ataques até serem destruídas. A base para criar essa mecância é a detecção de "áreas".
![sprite com martelo batendo em cubos e quebrando](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/quebrarPedra.gif)

Execute a cena Quebrar pedras:

![cena quebrar pedras](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/CenaQuebrarPedras.png)

### Area2D
A pedra é feita em uma cena própria, ela é feita com um "StaticBody2D" para impedir o movimento na colisão com o CharacterBody2D. O nó importante para a interação é o "Area2D", para usar também precisamos de um "CollisionShape2D" que é a marcação da região. O Area2D pode disparar um sinal quando outra entra ou sai, ou seja com ele vamos detectar se área do martelo entra nele.

![Area2D da cena da pedra](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/Area2DcenaPedra.png)
![Area2D da marreta](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/Area2DdaMarreta.png)

### Configurando os Grupos de Colisão
Na cena de teste temos um "Player" com uma Area2D que precisa ser configurado. Eu(gabura) acho mais interessante criar grupos de areas do que decorar camadas e layers. Então a area da marreta colocarei colacarei no grupo "ataque".

![Grupo "ataque" da area da Marreta](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/grupoAreaAtaque.png)

### Programação do comportamento da pedra
Precisamos definir quantos ataques a pedra aguenta, para isso criei a variável "resistência". Quando a a colisão com a area "ataque" acontece subtraímos 1 dessa variável e verificamos se a pedra precisa ser quebrada.

![código do comportamento da pedra](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/ProgramacaoComportamentoPedra.png)

### programação do ataque
Nesse exemplo programei o input da tecla espaço para ativar a animação de ataque.

![código do input do ataque com a marreta](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/InputAtaqueMarreta.png)

## Porta com acionamento remoto
Essa parte de portas é toda baseada em animações com o nó "AnimationPlayer", aqui fiz a animação de abrir e fechar. Depois programei o botão para acionar as animações.
![Sprite apertando botão que gira portão e abre passagem](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/portaControle.gif)

Execute a cena Porta com Controle:

![cena porta ocm controle](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/CenaPortaComControle.png)

### AnimationPlayer

![AnimationPlayer na cena](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/AnimacaoAnimationPlayer.png)

### Interação com o botão

![Programação do input do botão para ativar animação](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/ProgramacaoInputAtivarAnimacao.png)
![Sinal para detectar se o player esta tocando no botao](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/SinaisDeCOntatoBotaoCenaPorta.png)

## Coletáveis, Hud e Câmera
![Sprite moviendo pela tela coletando moedas, texto de pontos dendo atualizado](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/coletHUDcamera.gif)

Execute a cena hud coletaveis e cameras:
![cena hud coletaveis e camera](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/CenaHudColetaveisCamera.png)

### Instância da moeda

![Cena da moeda coletável](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/CenaMoedaColetavel.png)

### Camera2D

![Camera2D como filho do Player](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/Camera2DFilhoPlayer.png)

### CanvasLayer

![node CanvasLayer usado como HUD](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/CanvasLayerComoHud.png)

### Programação Coleta de Moedas

![programação do Hud para atualizar pontos](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/ProgramacaoHudAtualizarLabelPontos.png)
![programação da moeda para atualizar pontos](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/ProgramacaoMoedaColetavel.png)

## Movimento dos inimigos
![Sprites de inimigos se movendo em padrão linear](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/inimigoMOVIMENTO.gif)

Execute cena inimigos movimento:

![cena inimigos movimento](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/CenaInimigosMovimento.png)

### Path2D e PathFollow2D

![Path2D e PathFollow2D com inimigo](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/path2DPathFollow2D.png)

![progress do Pathfollow2D para mover](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/PathFollow2DProgress.png)

### Programação de movimento do Inimigo

![Programação movimento do inimigo com pathfollow2D](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/programacaoMovimentoPathFollow2D.png)
![Programação do sinal de colisão dentro do movimento do inimigo](https://github.com/GaburaDigital/TutorialGodot2Dtopdown/blob/main/gifs%20EXEMPLOS/CollisaoInimigoPathFoll2DSinal.png)
