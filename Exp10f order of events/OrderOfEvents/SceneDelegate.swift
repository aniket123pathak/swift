import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let first = LoggingViewController(name: "First", color: .systemRed)
        first.tabBarItem = UITabBarItem(title: "First", image: UIImage(systemName: "1.circle"), tag: 0)

        let second = LoggingViewController(name: "Second", color: .systemGreen)
        second.tabBarItem = UITabBarItem(title: "Second", image: UIImage(systemName: "2.circle"), tag: 1)

        let third = LoggingViewController(name: "Third", color: .systemBlue)
        third.tabBarItem = UITabBarItem(title: "Third", image: UIImage(systemName: "3.circle"), tag: 2)

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [first, second, third]

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
    }
}
