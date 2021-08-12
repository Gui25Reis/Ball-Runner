/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import SpriteKit

/**
    # Ação e funcionamento do jogo
    Toda a lógica e funcionamento do jogo está nessa classe.
    
    ## Atributos
    
    |     Atributos     |                     Descrição                     |
    |:------------------|:--------------------------------------------------|
    | allParticles      | Lista com todas as partículas vermelhas.          |
    | specialParticle   | Lista com todas as partículas verdes (especiais). |
    | userNode          | Partícula que o usuário controla.                 |
    | gameOn            | Verifica se o jogo já começou.                    |
    | gameStart         | Incialização do jogo.                             |
    | renderTime        | Tempo de renderização do fps                      |
    | gameTime          | Cronômetro.                                       |
    | specialTime       | Momento de criação das bolinhas especiais.        |
    | isDragging        | Verifica se está movendo a bolinha do usuário.    |
    | speedNode         | Velocidade das boolinhas vermelhas.               |
    |-------------------|---------------------------------------------------|
    
    ## Métodos
    
    |      Métodos      |                     Descrição                     |
    |:------------------|:--------------------------------------------------|
    | didMove           | Configurações de quando a cena é carregada.       |
    | didChangeSize     | Configurações da tela.                            |
    | update            | Configuração e ação de cada frame (fps).          |
    | createNode        | Criação e configuração inicial de uma partícula.  |
    | moveParticles     | Movimentação das partículas.                      |
    | getDistance       | Cálculo da distância entre dois pontos.           |
    | startDrag         | Ação de quando clica na tela.                     |
    | drag              | Ação de quando arrasta com o click pressionado.   |
    | drop              | Ação de quando solta o click.                     |
    |-------------------|---------------------------------------------------|
*/
public class GameScene: SKScene {
    // Atributos da classe
    private var allParticles:[Particle] = []
    private var specialParticles:[Particle] = []
    private var userNode:Particle = Particle()
    private var gameOn:Bool = false
    private var gameStart:Bool = true
    private var gameOver:Bool = false
    private var specialTime:Int = 4
    private var isDragging:Bool = false
    private let speedNode:CGFloat = 0.9 // CGFloat(UserDefaults.standard.double(forKey: "speed"))
    private var startPosition:[[CGFloat]] = []
    private var timer:Int = 0
    
    /**
        # Método [lifecycle]:
        Toda vez que a tela é carregada (inicializada) essas configuraçôes serão feitas.
    */
    public override func didMove(to view: SKView) -> Void {
        super.didMove(to: view)
        self.backgroundColor = #colorLiteral(red: 0.01540698763, green: 0.1682468057, blue: 0.2544359863, alpha: 1)
        
        self.userNode.setUserColor()
        
        self.addChild(self.userNode.getNode())
    }
    
    /**
        # Método [lifecycle]:
        Configurações feitas quando tem alguma alteração no tamanho de tela.
    */
    public override func didChangeSize(_ oldSize: CGSize) -> Void {
        self.userNode.setPositions(self.size.width / 2, self.size.height / 2)
        self.scaleMode = .resizeFill
    }
    
    /**
        # Método [lifecycle]:
        Ação de cada frame que acontece (fps).
    */
    public override func update(_ currentTime: TimeInterval) -> Void {
        if (self.gameOn && !self.gameOver) {
            self.moveParticles()
        } else if (self.gameStart){
            let uPos:[CGFloat] = self.userNode.getPositions()
            if ((uPos[0] != self.size.width/2) && (uPos[1] != self.size.height/2)) {
                self.gameOn = true
                self.gameStart = false
            }
        }
    }
    
    
    public func updadePerSecond(gameTime:Int) -> Void{
        self.timer = gameTime
        
        // Criando as bolinhas:
        for _ in 0..<abs(gameTime/2){
            self.createNode(isSpecial_: false)
        }
        
        // Criando a bolinha especial
        if (gameTime == self.specialTime) {
            if (self.specialParticles.count != 3) {
                self.createNode(isSpecial_: true)
            }
            self.specialTime += 4
        }
        for p in self.allParticles {p.setLifeTime(1)}
    }
    
    public func setStatuGame(is_:Bool) -> Void {if (!self.gameOver) {self.gameOn = is_}}
    public func isGameOver() -> Bool{return self.gameOver}
    
    public func isGameStart() -> Bool{return self.gameStart}
    
    
    /**
        # Método:
        Criação e configuração inicial das bolinhas
        
        ## Parâmetro:
        `Bool` isSpecial_: `true` pra esepcial ou `false` para comum.
    */
    private func createNode(isSpecial_:Bool) {
        let p:Particle = Particle()
        // Define a posição da bolinha
        let x:CGFloat = CGFloat.random(in: 0...self.size.width)
        let y:CGFloat = CGFloat.random(in: 0...self.size.height-40)
        p.setPositions(x, y)
        
        // Define o tempo da bolinha
        p.setInitialTime(self.timer)
        
        // Coloca na tela
        self.addChild(p.getNode())
        
        // Caso seja uma bolinha especial
        if (isSpecial_) {
            p.setSpecialColor()
            self.specialParticles.append(p)
        } else {
            self.allParticles.append(p)
        }
    }
    
    /**
        # Método:
        Configuração do movimento das bolinhas.
    */
    private func moveParticles() -> Void {
        // Posição atual do UserNode
        let uPos:[CGFloat] = self.userNode.getPositions()
        var pos:[CGFloat]
        
        // Bolinhas especiais: verifica se encostou em alguma
        for s in 0..<self.specialParticles.count {
            pos = self.specialParticles[s].getPositions()
            if (self.getDistance(pos, uPos)-self.userNode.getRadius() < self.userNode.getRadius()) {
                self.specialParticles.remove(at: s)
                self.allParticles = []
                return
            }
        }
            
        var dist:CGFloat
        var x:CGFloat
        var y:CGFloat
        
        // Movimentação das bolinhas
        for p in self.allParticles {
            if (p.isReady()) {                      // Perseguindo
                pos = p.getPositions()
                dist = self.getDistance(pos, uPos)
                
                // Parada do jogo
                if ((dist-self.userNode.getRadius()+5) < self.userNode.getRadius()) {
                    self.gameOn = false
                    self.gameOver = true
                    return
                }
                
                // Definindo uma nova direção
                x = uPos[0]-pos[0]
                y = uPos[1]-pos[1]
                
                p.setPositions(pos[0]+((x*self.speedNode)/dist), pos[1]+((y*self.speedNode)/dist))
                
            } else {                                // Nascendo
                if (p.getScale() > CGFloat(1)) {p.setScale(1)}
                else {p.setScale(p.getScale()+0.01)}
            }
        }
    }
        
    /**
        # Método:
        Pega a distância entre dois os pontos.
        
        ## Parâmetros:
        `[CGFloat]` n1_: bolinha 1/2 pra pegar a distãncia.
        `[CGFloat]` n2_: bolinha 2/2 pra pegar a distãncia.
    */
    public func getDistance(_ n1_:[CGFloat], _ n2_:[CGFloat]) -> CGFloat {
        return CGFloat(sqrt(pow(n1_[0] - n2_[0], 2) + pow(n1_[1] - n2_[1], 2)))
    }
        
    /* Movimentando a bolinha com o mouse (node) */
    
    /**
        # Método:
        Ação de quando clica na tela.
    */
    public func startDrag(_ pos_:[CGFloat]) -> Void {
        if (self.gameOn || self.gameStart && !gameOver) {
            self.startPosition = [pos_, self.userNode.getPositions()]
            self.isDragging = true
            
        }
    }
        
    /**
        # Método:
        Ação de quando arrasta algo na tela.
        
        ## Parâmetro:
        `[CGFloat]` pos_: nova posição da bolinha do usuário.
    */
    public func drag(_ pos_:[CGFloat]) -> Void {
        if ((self.gameOn && self.isDragging) || (self.gameStart)) {
            
            let speed:CGFloat = self.speedNode + 0.6
            
            let angle = atan2(pos_[1]-self.startPosition[0][1], pos_[0]-self.startPosition[0][0])
            let dist = self.getDistance(pos_, self.startPosition[0])
            
            let posX = self.startPosition[1][0] + dist * cos(angle) * speed
            let posY = self.startPosition[1][1] + dist * sin(angle) * speed
            
            
            if (posX < 0 && posY < 0) {                 // 3º Quadrante (x e y são negativos)
                self.userNode.setPositions(0, 0)
            } else if (posX < 0) {                      // Canto esquerdo
                if posY > self.size.height{
                    self.userNode.setPositions(0, self.size.height)
                }else{
                    self.userNode.setPositions(0, posY)
                }
            } else if (posY < 0) {                      // Canto de baixo
                if posX > self.size.width{
                    self.userNode.setPositions(self.size.width, 0)
                }else{
                    self.userNode.setPositions(posX, 0)
                }
            } else if (posX > self.size.width) {        // Canto direito
                if posY > self.size.height{
                    self.userNode.setPositions(self.size.width, self.size.height)
                }else{
                    self.userNode.setPositions(self.size.width, posY)
                }
            } else if (posY > self.size.height) {       // Canto de cima
                if posX > self.size.width{
                    self.userNode.setPositions(self.size.width, self.size.height)
                }else{
                    self.userNode.setPositions(posX, self.size.height)
                }
            } else {                                    // Qualquer posição da tela
                self.userNode.setPositions(posX, posY)
            }
        }
    }
        
    /**
        # Método:
        Ação de quando para de clicar na tela.
    */
    public func drop() -> Void {self.isDragging = false}
}
