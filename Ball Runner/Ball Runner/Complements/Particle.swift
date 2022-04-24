/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
//import class SpriteKit.SKShapeNode
//import struct SpriteKit.CGFloat
import SpriteKit


public class Particle: SKShapeNode {
    
    /* MARK: - Atributos */
    private var radius: CGFloat = 7
    private var initialTime: Int = 0
    private var lifeTime: Int = 0
    private var specialNode: Bool = false
    private var scale: CGFloat = 0.5
    
    
    /* MARK: - Construtor */
    
    override init() {
        super.init()
        let diameter = self.radius * 2
        self.path = CGPath(ellipseIn: CGRect(origin: CGPoint.zero, size: CGSize(width: diameter, height: diameter)), transform: nil)
        self.lineWidth = 0
        self.setColor(by: .enemy)
        self.setScale(self.scale)
    }
    
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
        

    public func setPosition(x: CGFloat, y: CGFloat) -> Void {
        self.position = CGPoint(x: x, y: y)
    }
    
    
    public func getPosition() -> CGPoint {return self.position}
    
    
    private func setupSpecialNode() -> Void {
        self.specialNode = true
        self.setScale(1)
    }
    

    public func isSpecialNode() -> Bool {return self.specialNode}
    
    internal func setColor(by type: ParticleType) -> Void {
        switch type {
        case .enemy:
            self.fillColor = #colorLiteral(red: 0.8296997547, green: 0.2501699328, blue: 0.2907564044, alpha: 1)
        case .user:
            self.fillColor = #colorLiteral(red: 0, green: 0.9089414477, blue: 0.4565228224, alpha: 1)
            self.setupSpecialNode()
        case .power:
            self.fillColor = #colorLiteral(red: 0.9878974557, green: 0.9603099227, blue: 0.9356864095, alpha: 1)
            self.setupSpecialNode()
        }
    }
    
    public func getInitialTime() -> Int {return self.initialTime}
    public func setInitialTime(at time: Int) -> Void {
        self.initialTime = time
        self.setLifeTime(at: time)
    }

    public func getRadius() -> CGFloat {return self.radius}
    
    public func setLifeTime(at time: Int) -> Void {self.lifeTime += time}
    public func getLifeTime() -> Int {return self.lifeTime}
    
    public func getScale() -> CGFloat {return self.scale}
    public func updateScale(with scale: CGFloat) -> Void {
        self.scale = scale
        self.setScale(self.scale)
        self.alpha = self.scale
    }
    
    public func isReady() -> Bool {
        if (self.getLifeTime() > self.getInitialTime()+1 && self.scale >= 1) {
            return true
        }
        return false
    }
}
