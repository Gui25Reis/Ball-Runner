/* Gui Reis    -    gui.sreis25@gmail.com */


struct TutorialTopic {
    let title: String
    let description: String
    
    init(for title: String) {
        self.title = title.localized()
        self.description = "\(title)-Description".localized()
    }
}
