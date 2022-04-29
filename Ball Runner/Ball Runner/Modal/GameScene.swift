/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import SpriteKit


class GameScene: SKScene {
    
    /* MARK: - Atributos */
    
    private var allParticles: [Particle] = []
    private var particlesDying: [Particle] = []
    private var specialParticles: [Particle] = []
    private var userNode = Particle()
    private var gameOn: Bool = false
    private var gameStart: Bool = true
    private var gameOver: Bool = false
    private var specialTime: Int = 4
    private var isDragging: Bool = false
    private let speedNode: CGFloat = 0.9 // CGFloat(UserDefaults.standard.double(forKey: "speed"))
    private var touchPosition: CGPoint = CGPoint()
    private var userPosition: CGPoint = CGPoint()
    private var timer: Int = 0
    
    
    /* MARK: - Ciclo de Vida */
    
    /**
        # Método [lifecycle]:
        Toda vez que a tela é carregada (inicializada) essas configuraçôes serão feitas.
    */
    public override func didMove(to view: SKView) -> Void {
        super.didMove(to: view)
        self.backgroundColor = UIColor(with: .game) ?? #colorLiteral(red: 0.01540698763, green: 0.1682468057, blue: 0.2544359863, alpha: 1)
        
        self.userNode.setColor(by: .user)
        
        self.addChild(self.userNode.getNode())
    }
    
    /**
        # Método [lifecycle]:
        Configurações feitas quando tem alguma alteração no tamanho de tela.
    */
    public override func didChangeSize(_ oldSize: CGSize) -> Void {
        self.userNode.setPosition(x: self.size.width/2, y: self.size.height/2)
        self.scaleMode = .resizeFill
    }
    
    /**
        # Método [lifecycle]:
        Ação de cada frame que acontece (fps).
    */
    public override func update(_ currentTime: TimeInterval) -> Void {
        if (self.gameOn && !self.gameOver) {
            self.moveParticles()
        } else if (self.gameStart) {
            let userPos: CGPoint = self.userNode.getPosition()
            if (userPos.x != self.size.width/2) && (userPos.y != self.size.height/2) {
                self.gameOn = true
                self.gameStart = false
            }
        }
    }
    
    /* MARK: - Encapsulamento */
    
    public func setStatuGame(to status: Bool) -> Void {
        if !self.gameOver {
            self.gameOn = status
        }
    }
    
    public func isGameOver() -> Bool{return self.gameOver}
    
    public func isGameStart() -> Bool{return self.gameStart}
    
    
    public func updadePerSecond(gameTime: Int) -> Void{
        self.timer = gameTime
        
        // Criando as bolinhas:
        for _ in 0..<abs(gameTime/2){
            self.createNode(isSpecial: false)
        }
        
        // Criando a bolinha especial
        if (gameTime == self.specialTime) {
            if (self.specialParticles.count != 3) {
                self.createNode(isSpecial: true)
            }
            self.specialTime += 4
        }
        
        
        for p in particlesDying {
            self.allParticles.remove(at: p.getIndex())
            p.erase()
        }
        
        self.particlesDying = []
        
        for p in 0..<self.allParticles.count {
            self.allParticles[p].setLifeTime(at: 1)
            
            if self.allParticles[p].isDying() {
                self.allParticles[p].setIndex(at: p)
                self.particlesDying.append(self.allParticles[p])
            }
        }
    }
    
    
    /**
        # Método:
        Criação e configuração inicial das bolinhas
        
        ## Parâmetro:
        `Bool` isSpecial_: `true` pra esepcial ou `false` para comum.
    */
    private func createNode(isSpecial: Bool) -> Void {
        let node = Particle()
        
        // Define a posição da bolinha
        let x: CGFloat = CGFloat.random(in: 0...self.size.width)
        let y: CGFloat = CGFloat.random(in: 0...self.size.height-40)
        node.setPosition(x: x, y: y)
        
        node.setInitialTime(at: self.timer)
    
        self.addChild(node.getNode())
        
        switch isSpecial {
        case true:
            node.setColor(by: .power)
            self.specialParticles.append(node)
        case false:
            self.allParticles.append(node)
        }
    }
    
    /**
        # Método:
        Configuração do movimento das bolinhas.
    */
    private func moveParticles() -> Void {
        // Posição atual do UserNode
        let userPos: CGPoint = self.userNode.getPosition()
        var pos: CGPoint
        
        let radius = self.userNode.getRadius()
        
        // Bolinhas especiais: verifica se encostou em alguma
        for s in 0..<self.specialParticles.count {
            pos = self.specialParticles[s].getPosition()
            
            if (self.getDistance(pos, userPos)-radius < radius) {
                self.specialParticles.remove(at: s)
                self.allParticles = []
                return
            }
        }
            
        var dist: CGFloat
        var x: CGFloat
        var y: CGFloat
        
        let gap = radius-5
        
        // Movimentação das bolinhas
        for p in self.allParticles {
            if (p.isReady()) {                      // Perseguindo
                pos = p.getPosition()
                dist = self.getDistance(pos, userPos)
                
                // Parada do jogo
                if dist-gap < radius {
                    self.gameOn = false
                    self.gameOver = true
                    return
                }
                
                // Definindo uma nova direção
                x = userPos.x - pos.x
                y = userPos.y - pos.y
                
                p.setPosition(
                    x: pos.x + ((x*self.speedNode)/dist),
                    y: pos.y + ((y*self.speedNode)/dist)
                )
                
            } else {                                // Nascendo
                if (p.getScale() > CGFloat(1)) {
                    p.updateScale(with: 1)
                } else {
                    p.updateScale(with: p.getScale()+0.01)
                }
            }
        }
        
        for p in self.particlesDying {
            p.updateScale(with: p.getScale()-0.01)
        }
    }
        
    /**
        # Método:
        Pega a distância entre dois os pontos.
        
        ## Parâmetros:
        `[CGFloat]` n1_: bolinha 1/2 pra pegar a distãncia.
        `[CGFloat]` n2_: bolinha 2/2 pra pegar a distãncia.
    */
    public func getDistance(_ n1: CGPoint, _ n2: CGPoint) -> CGFloat {
        return CGFloat(sqrt(pow(n1.x - n2.x, 2) + pow(n1.y - n2.y, 2)))
    }
        
    /* Movimentando a bolinha com o mouse (node) */
    
    /**
        # Método:
        Ação de quando clica na tela.
    */
    public func startDrag(at position: CGPoint) -> Void {
        if (self.gameOn || self.gameStart && !gameOver) {
            self.touchPosition = position
            self.userPosition = self.userNode.getPosition()
            self.isDragging = true
        }
    }
        
    /**
        # Método:
        Ação de quando arrasta algo na tela.
        
        ## Parâmetro:
        `[CGFloat]` pos_: nova posição da bolinha do usuário.
    */
    public func drag(at pos: CGPoint) -> Void {
        if ((self.gameOn && self.isDragging) || (self.gameStart)) {
            
            let speed: CGFloat = self.speedNode + 0.6
            
            let angle = atan2(pos.y-self.touchPosition.y, pos.x-self.touchPosition.x)
            let dist = self.getDistance(pos, self.touchPosition)
            
            let posX = self.userPosition.x + dist * cos(angle) * speed
            let posY = self.userPosition.y + dist * sin(angle) * speed
                        
            if (posX < 0 && posY < 0) {                 // 3º Quadrante (x e y são negativos)
                self.userNode.setPosition(x: 0, y: 0)
            } else if (posX < 0) {                      // Canto esquerdo
                if posY > self.size.height{
                    self.userNode.setPosition(x: 0, y: self.size.height-10)
                }else{
                    self.userNode.setPosition(x: 0, y: posY)
                }
            } else if (posY < 0) {                      // Canto de baixo
                if posX > self.size.width{
                    self.userNode.setPosition(x: self.size.width, y: 0)
                }else{
                    self.userNode.setPosition(x: posX, y: 0)
                }
            } else if (posX > self.size.width) {        // Canto direito
                if posY > self.size.height{
                    self.userNode.setPosition(x: self.size.width, y: self.size.height)
                }else{
                    self.userNode.setPosition(x: self.size.width, y: posY)
                }
            } else if (posY > self.size.height) {       // Canto de cima
                if posX > self.size.width{
                    self.userNode.setPosition(x: self.size.width, y: self.size.height)
                }else{
                    self.userNode.setPosition(x: posX, y: self.size.height)
                }
            } else {                                    // Qualquer posição da tela
                self.userNode.setPosition(x: posX, y: posY)
            }
        }
    }
        
    /**
        # Método:
        Ação de quando para de clicar na tela.
    */
    public func drop() -> Void {self.isDragging = false}
}
