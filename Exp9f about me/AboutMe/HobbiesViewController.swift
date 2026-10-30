
import UIKit

class HobbiesViewController: UIViewController {

    let hobbies = [
       "Music",
       "Cricket",
       "Cooking"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let titleLabel = UILabel()
        titleLabel.text = "My Hobbies"
        titleLabel.font = .boldSystemFont(ofSize: 28)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let textView = UITextView()
        textView.isEditable = false
        textView.font = .systemFont(ofSize: 20)
        textView.text = hobbies.joined(separator: "\n\n")
        textView.backgroundColor = .secondarySystemBackground
        textView.layer.cornerRadius = 12
        textView.textContainerInset = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
        textView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(titleLabel)
        view.addSubview(textView)

        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20),

            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            textView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20),
            textView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -20)
        ])
    }
}
