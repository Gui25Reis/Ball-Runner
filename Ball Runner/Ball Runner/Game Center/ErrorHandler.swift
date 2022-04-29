/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import struct Foundation.URLError

/**
    Classe responsável pelo tratamento dos erros que podem acontecer no Game Center.
 
    Todos os erros são categorizados e tratados, podendo ter acesso á eles pelo que é mostrado ao usuário
 (`localizedDescription` ) ou para o desenvolvedor (`description`).
*/
enum ErrorHandler: Error, CustomStringConvertible {
    case noAuthenticaded
    case authenticationError
    case scoreNotFound
    case scoreNotSubmited
    case badCommunication

    /// Feedback para o usuário
    var localizedDescription: String {
        switch self {
        case .noAuthenticaded:
            return "Game Center não autenticado"
        case .authenticationError:
            return "Game Center desligado"
        case .scoreNotFound, .badCommunication, .scoreNotSubmited:
            return "Erro com o Game Center"
        }
    }

    /// Feedback completo para desenvolver
    var description: String {
        switch self {
        case .noAuthenticaded: return "Game Center off"
        case .authenticationError: return "Erro na hora de autenticar com o Game Center"
        case .scoreNotFound: return "Pontuação não foi encontrado"
        case .scoreNotSubmited: return "Pontuação não foi postada."
        case .badCommunication: return "Houve um erro na hora de se conectar com o Leaderboard"
        }
    }
}
