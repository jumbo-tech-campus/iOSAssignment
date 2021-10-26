import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Attributes

    var window: UIWindow?
    private var coordinator: AppCoordinator?

    // MARK: - Life cycle

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(frame: windowScene.screen.bounds)
        window.windowScene = windowScene

        self.window = window

        coordinator = AppCoordinator(window: window)
        coordinator?.start()
    }
}
