/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import GameKit


class GameCenterService: GKGameCenterViewController {
    
    /* MARK: - Atributos */
    
    static let shared = GameCenterService()
    
    static let leaderboardID = "lbHighScoreAppStore"
    
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
                completionHandler(vc, nil, .noAuthenticaded)
                return
            }
            
            // Pega o Score salvo no Game Center
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
                    
                    
                    let localScore = UserDefaults.getIntValue(with: .highScore)
                    
                    if score > localScore {     // Conectou depois no Game Center
                        UserDefaults.updateValue(in: .highScore, with: score)
                    } else {                    // Bateu record e estava sem internet
                        self.submitHighScore(score: localScore) { error in
                            if let error = error {
                                completionHandler(.failure(error))
                            }
                        }
                    }
                    
                    completionHandler(.success(UserDefaults.getIntValue(with: .highScore)))
                    return
                }
            }
        }
        completionHandler(.failure(.noAuthenticaded))
    }
    
    /// Define o score no Game Center
    public func submitHighScore(score: Int, _ completionHandler: @escaping (_ error: ErrorHandler?) -> Void ) {
        // Define no highscore
        UserDefaults.updateValue(in: .highScore, with: score)
        
        if (GKLocalPlayer.local.isAuthenticated) {
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
    public func showGameCenterPage(_ state: GKGameCenterViewControllerState = .leaderboards) -> GKGameCenterViewController? {
        if (GKLocalPlayer.local.isAuthenticated) {
            let vc = GKGameCenterViewController(state: state)
            vc.gameCenterDelegate = self.gameCenterProtocol
            return vc
        }
        return nil
    }
}
