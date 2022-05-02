/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import class SpriteKit.SKShapeNode
import struct SpriteKit.CGFloat
import struct SpriteKit.CGPoint

import class UIKit.UIColor


public class Particle {
        
    /* MARK: - Atributos */
    
    private var node: SKShapeNode
    private var radius: CGFloat = 7
    private var initialTime: Int = 0
    private var lifeTime: Int = 0
    private var specialNode: Bool = false
    private var scale: CGFloat = 0.5
    private var index: Int = -1
    private var ready: Bool = false
    
    
    /* MARK: - Construtor */
    
    init() {
        self.node = SKShapeNode(circleOfRadius: self.radius)
        self.node.lineWidth = 0
        self.setColor(by: .enemy)
        self.node.setScale(self.scale)
    }
    
    deinit {
        self.erase()
    }
    
    
    /* MARK: - Encapsulamento */
    
    public func erase() -> Void {
        self.node.removeFromParent()
    }
    
    public func getNode() -> SKShapeNode {return self.node}
    
    public func getPosition() -> CGPoint {return self.node.position}
    public func setPosition(x: CGFloat, y: CGFloat) -> Void {
        self.node.position = CGPoint(x: x, y: y)
    }
    
    public func getInitialTime() -> Int {return self.initialTime}
    public func setInitialTime(at time: Int) -> Void {
        self.initialTime = time
        self.setLifeTime(at: time)
    }

    public func getRadius() -> CGFloat {return self.radius}
    
    public func setLifeTime(at time: Int) -> Void {self.lifeTime += time}
    public func getLifeTime() -> Int {return self.lifeTime - self.initialTime}
    
    public func setIndex(at index: Int) -> Void {self.index = index}
    public func getIndex() -> Int {return self.index}
    
    public func getScale() -> CGFloat {return self.scale}
    public func updateScale(with scale: CGFloat) -> Void {
        self.scale = scale
        self.node.setScale(self.scale)
        self.node.alpha = self.scale
        
        if self.scale >= 1 {
            self.ready = true
        }
    }
    
    public func isSpecialNode() -> Bool {return self.specialNode}
    
    public func isReady() -> Bool {return self.ready}
    
    public func isDying() -> Bool {
        if (self.lifeTime - self.initialTime) >= 10  {
            return true
        }
        return false
    }
    
    internal func setColor(by type: ParticleType) -> Void {
        switch type {
        case .enemy:
            self.node.fillColor = UIColor(with: .enemy) ?? #colorLiteral(red: 0.8296997547, green: 0.2501699328, blue: 0.2907564044, alpha: 1)
        case .user:
            self.node.fillColor = UIColor(with: .player) ?? #colorLiteral(red: 0, green: 0.9089414477, blue: 0.4565228224, alpha: 1)
            self.setupSpecialNode()
        case .power:
            self.node.fillColor = UIColor(with: .power) ?? #colorLiteral(red: 0.9878974557, green: 0.9603099227, blue: 0.9356864095, alpha: 1)
            self.setupSpecialNode()
        }
    }
    
    
    /* MARK: - Configuração */
    
    private func setupSpecialNode() -> Void {
        self.specialNode = true
        self.node.setScale(1)
    }
}
