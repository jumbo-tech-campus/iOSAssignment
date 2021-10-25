import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Attributes

    var window: UIWindow?

    // MARK: - Life cycle

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(frame: windowScene.screen.bounds)
        window.windowScene = windowScene

        self.window = window
    }
}

