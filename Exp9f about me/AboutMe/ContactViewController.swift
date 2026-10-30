
import UIKit

class ContactViewController: UIViewController {

    // ✏️ Change these to your own contact details
    let email = "aniketpathak581@gmail.com"
    let phone = "9322420667"
    let city = "Pune, Maharashtra"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let titleLabel = UILabel()
        titleLabel.text = "Contact Me"
        titleLabel.font = .boldSystemFont(ofSize: 28)
        titleLabel.textAlignment = .center

        let emailLabel = makeInfoLabel(icon: "✉️", text: email)
        let phoneLabel = makeInfoLabel(icon: "📞", text: phone)
        let cityLabel = makeInfoLabel(icon: "📍", text: city)

        let emailButton = makeButton(title: "Send Email", action: #selector(emailTapped))
        let callButton = makeButton(title: "Call", action: #selector(callTapped))

        let stack = UIStackView(arrangedSubviews: [titleLabel, emailLabel, phoneLabel, cityLabel, emailButton, callButton])
        stack.axis = .vertical
        stack.spacing = 18
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: guide.topAnchor, constant: 40),
            stack.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -24)
        ])
    }

    func makeInfoLabel(icon: String, text: String) -> UILabel {
        let label = UILabel()
        label.text = "\(icon)  \(text)"
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }

    func makeButton(title: String, action: Selector) -> UIButton {
        var config = UIButton.Configuration.filled()
        config.title = title
        config.cornerStyle = .large
        let button = UIButton(configuration: config)
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }

    @objc func emailTapped() {
        open("mailto:\(email)")
    }

    @objc func callTapped() {
        let digits = phone.filter { $0.isNumber || $0 == "+" }
        open("tel:\(digits)")
    }

    /// Opens a URL, or explains politely if the device (e.g. the Simulator) can't.
    func open(_ urlString: String) {
        guard let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) else {
            let alert = UIAlertController(title: "Not available",
                                          message: "This device can't open that link.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        UIApplication.shared.open(url)
    }
}
