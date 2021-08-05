/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
// Globais
import class SpriteKit.SKShapeNode
import class SpriteKit.SKAction
import struct SpriteKit.CGFloat

/**
    # Criação das Partículas/Bolinhas.
    Criação e configuração da partícula.
    
    ## Atributos
    
    |     Atributos     |                     Descrição                     |
    |:------------------|:--------------------------------------------------|
    | node              | A bolinha em si.                                  |
    | radius            | Raio da bolinha.                                  |
    | initialTime       | Momento (em segundos) da criação da bolinha.      |
    | lifeTime          | Quanto tempo está durando/viva.                   |
    | specialNode       | Caso seja uma bolinha especial.                   |
    | scale             | Escala em relação ao raio.                        |
    |-------------------|---------------------------------------------------|
    
    ## Métodos
    
    |      Métodos      |                     Descrição                     |
    |:------------------|:--------------------------------------------------|
    | getNode           | Retorna a bolinha (node).                         |
    | setPositions      | Define a posição da bolinha.                      |
    | getPositions      | Retorna a posição da bolinha.                     |
    | setSpecialNode    | Define se é uma bolinha especial (verde).         |
    | isSpecialNode     | Verifica se é uma bolinha especial (verde).       |
    | setUserColor      | Define a cor da bolinha do usuário.               |
    | setSpecialColor   | Define a cor da bolinha especial.                 |
    | getRadius         | Retorna o tamanho do raio da bolinha.             |
    | setInitialTime    | Define o segundo em que ela nasceu.               |
    | getInitialTime    | Retorna o segundo em que ela nasceu.              |
    | setLifeTime       | Define quanto tempo ela está durando ("viva").    |
    | getLifeTime       | Retorna quanto tempo ela esta durando ("viva").   |
    | isReady           | Verifica se está pronta para uso .                |
    | setScale          | Define a escala.                                  |
    | getScale          | Retorna a escala.                                 |
    |-------------------|---------------------------------------------------|
*/
public class Particle {
    // Atributos da classe:
    private var node:SKShapeNode!
    private var radius:CGFloat = 7
    private var initialTime:Int = 0
    private var lifeTime:Int = 0
    private var specialNode:Bool = false
    private var scale:CGFloat = 0.5
    
    
    /**
        # Construtor:
            Configurações inicais da bolinha:
            - Tira a borda;
            - Coloca a cor padrão (vermelha);
            - Define a escala inicial;
    */
    init() {
        self.node = SKShapeNode(circleOfRadius: self.radius)
        self.node.lineWidth = 0
        self.node.fillColor = #colorLiteral(red: 0.8296997547, green: 0.2501699328, blue: 0.2907564044, alpha: 1)
        self.node.setScale(self.scale)
    }
    
    
    /**
        # Destrutor:
        Limpa os atributos da classe.
    */
    deinit {
        self.node.removeFromParent()
    }
    
    
    /**
        # Método especial:
        Retorna a bolinha com as configurações feitas.
    */
    public func getNode() -> SKShapeNode {return self.node}
    
    
    /**
     # Método especial:
     Define as posições de x e y.
     
     ## Parâmetros:
     `CGFloat` x_: posição em x.
     `CGFloat` y_: posição em y.
    */
    public func setPositions(_ x_:CGFloat, _ y_:CGFloat) -> Void {
        self.node.position.x = x_
        self.node.position.y = y_
    }
    
    /**
        # Método especial:
        Rotorna uma lista com as posições x e y respectivamente.
    */
    public func getPositions() -> [CGFloat] {return [self.node.position.x, self.node.position.y]}
    
    
    /**
        # Método especial:
        Define o tipo da bolinha: convencional (vermelha) ou especial (verde ou do usuário).
        
        ## Parâmetro:
        `Bool` b_: `true` pra esepcial ou `false` para comum.
    */
    public func setSpecialNode(_ b_:Bool) -> Void {
        self.specialNode = b_
        self.setScale(1)
    }
    
    
    /**
        # Método especial:
        Mostra se ela é especial ou convencional.
        
        ## Retorno:
        `Bool` b_: `true` pra esepcial ou `false` para comum.
    */
    public func isSpecialNode() -> Bool {return self.specialNode}
    
    
    /**
        # Método especial:
        Define a cor da bolinha que o usuário controla e algumas pré-configurações que a tornam desse tipo.
    */
    public func setUserColor() -> Void {
        self.node.fillColor = #colorLiteral(red: 0, green: 0.9089414477, blue: 0.4565228224, alpha: 1)
        self.setSpecialNode(true)
    }
    
    /**
        # Método especial:
        Define a cor da bolinha especial e algumas pré-configurações que a tornam desse tipo.
    */
    public func setSpecialColor() -> Void {
        self.node.fillColor = #colorLiteral(red: 0.9878974557, green: 0.9603099227, blue: 0.9356864095, alpha: 1)
        self.setSpecialNode(true)
    }
    
    
    /**
        # Método especial:
        Retorna o tamanho do raio da bolinha.
    */
    public func getRadius() -> CGFloat {return self.radius}
    
    
    /**
        # Método especial:
        Define o segundo em que a bolinha foi criada em relação ao cronômetro.
        ## Parâmetro:
        `Int` t_: Tempo do cronômetro em que a bolinha foi criado.
    */
    public func setInitialTime(_ t_:Int) -> Void {
        self.initialTime = t_
        self.setLifeTime(t_)
    }
    
    
    /**
        # Método especial:
        Retorna o segundo em que a bolinha foi criada em relação ao cronômetro.
    */
    public func getInitialTime() -> Int {return self.initialTime}
    
    
    /**
        # Método especial:
        Define quanto tempo será acrescentado na duração de vida dela.
        
        ## Parâmetro:
        `Int` t_: Tempo que vai ser acrescentado.
    */
    public func setLifeTime(_ t_:Int) -> Void {self.lifeTime += t_}
    
    
    /**
        # Método especial:
        Retorna quanto tempo a bolinha está ativa/viva.
    */
    public func getLifeTime() -> Int {return self.lifeTime}
    
    
    /**
        # Método especial:
        Verifica se está pronta para ser movimentada.
        
        ## Retorno:
        `true` se está pronta ou `false` caso esteja em crescimento.
    */
    public func isReady() -> Bool {
        if (self.getLifeTime() > self.getInitialTime()+1 && self.scale >= 1) {
            return true
        }; return false
    }
    /**
     
     
        # Método especial:
        Define a escala da bolinha.
        
        ## Parâmetro:
        `CGFloat` s_: define a escala em relação ao raio.
    */
    public func setScale(_ s_:CGFloat) -> Void {
        self.scale = s_
        self.node.setScale(self.scale)
        self.node.alpha = self.scale
    }
    
    
    /**
        # Método especial:
        Retorna a escala atual da bolinha.
    */
    public func getScale() -> CGFloat {return self.scale}
}
