/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import GameKit


class GameCenterService: GKGameCenterViewController {
    
    /* MARK: - Atributos */
    
    static let shared = GameCenterService()
    
    static let leaderboardID = "lbHighScore"
    
    private var controller: UIViewController?
    
    private var gameCenterProtocol = GameCenterDelegate()
    
    /* MARK: - Métodos */
    
    /// Faz a autenticação do usuário
    public func autenticateUser(_ completionHandler: @escaping (_ vc: UIViewController?, _ score: Int?, _ error: ErrorHandler?) -> Void) {
        GKLocalPlayer.local.authenticateHandler = {vc, error in
            
            // Se tiver algum erro
            if let _ = error {
                completionHandler(nil, nil, .authenticationError)
                return
            }
            
            // Caso não esteja autenticado (Devolve a ViewController reponsável para fazer o login)
            if let vc = vc {
                completionHandler(vc, nil, nil)
                return
            }
            
            // Pega o Score do GameCenter
            self.getHighScore { result in
                switch result {
                case .success(let score):
                    completionHandler(nil, score, nil)
                case .failure(let error):
                    completionHandler(nil, nil, error)
                }
            }
        }
    }
    
    /// Pega o score salvo no Game Center
    public func getHighScore(_ completionHandler: @escaping (Result<Int, ErrorHandler>) -> Void) {
        if (GKLocalPlayer.local.isAuthenticated) {
            GKLeaderboard.loadLeaderboards(IDs: [GameCenterService.leaderboardID]) {leaderboards, error in
        
                // Verifica se tem algum erro
                if error != nil {
                    completionHandler(.failure(.badCommunication))
                    return
                }
                
                leaderboards?[0].loadEntries(for: [GKLocalPlayer.local], timeScope: .allTime) { player, _, error in
                    
                    // Verifica se tem algum erro
                    if error != nil {
                        completionHandler(.failure(.badCommunication))
                        return
                    }
                    
                    // Verifica se o player e o score existem
                    guard let score = player?.score else {
                        completionHandler(.failure(.scoreNotFound))
                        return
                    }
                    
                    // Atualiza o user defaults caso necessário
                    if UserDefaults.getIntValue(with: .highScore) < score {
                        UserDefaults.updateValue(in: .highScore, with: score)
                    }
                    
                    completionHandler(.success(score))
                    return
                }
            }
        }
        completionHandler(.failure(.noAuthenticaded))
    }
    
    /// Define o score no Game Center
    public func submitHighScore(score: Int, _ completionHandler: @escaping (_ error: ErrorHandler?) -> Void ) {
        if (GKLocalPlayer.local.isAuthenticated) {
            // Define no highscore
            //UserDefaults.standard.set(score, forKey: GameCenterService.highscoreKey)
            
            // Manda pro Game Center
            GKLeaderboard.submitScore(score, context: 0, player: GKLocalPlayer.local, leaderboardIDs: [GameCenterService.leaderboardID]) {error in
                
                if let _ = error {
                    completionHandler(.scoreNotSubmited)
                }
                completionHandler(nil)
            }
            return
        }
        completionHandler(.noAuthenticaded)
    }
    
    /// Abre a página do game center
    public func showGameCenterPage(_ state: GKGameCenterViewControllerState = .leaderboards) {
        if (GKLocalPlayer.local.isAuthenticated) {
            let vc = GKGameCenterViewController(state: state)
            vc.gameCenterDelegate = self.gameCenterProtocol
            
            self.controller?.present(vc, animated: true)
        }
    }
    
    /// Mostra o avatar do Game Center
    public func showAvatar(isVisible: Bool) -> Void {
        if (GKLocalPlayer.local.isAuthenticated) {
            GKAccessPoint.shared.location = .topLeading
            GKAccessPoint.shared.showHighlights = false
            GKAccessPoint.shared.isActive = isVisible
        }
    }
    
    /// Define a ViewController que vai mostrar as telas
    public func setController(_ vc: UIViewController) {
        self.controller = vc
    }
}
