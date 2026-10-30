
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let profileVC = ProfileViewController()
        profileVC.tabBarItem = UITabBarItem(title: "Profile",
                                            image: UIImage(systemName: "person.circle"),
                                            tag: 0)

        let hobbiesVC = HobbiesViewController()
        hobbiesVC.tabBarItem = UITabBarItem(title: "Hobbies",
                                            image: UIImage(systemName: "star.circle"),
                                            tag: 1)

        let contactVC = ContactViewController()
        contactVC.tabBarItem = UITabBarItem(title: "Contact",
                                            image: UIImage(systemName: "envelope.circle"),
                                            tag: 2)

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [profileVC, hobbiesVC, contactVC]

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
    }
}
