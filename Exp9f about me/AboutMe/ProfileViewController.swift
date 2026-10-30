import UIKit

class ProfileViewController: UIViewController {

    let fullName = "Aniket Pathak"
    let age = "20"
    let course = "B.Tech, Computer Engineering"
    let college = "JSPM RSCOE, Pune"
    let aboutText = "Hello I am Aniket and i am passionate about Competative programming"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Profile"

        let avatar = UIImageView(image: UIImage(systemName: "person.crop.circle.fill"))
        avatar.tintColor = .systemBlue
        avatar.contentMode = .scaleAspectFit
        avatar.translatesAutoresizingMaskIntoConstraints = false

        let nameLabel = UILabel()
        nameLabel.text = fullName
        nameLabel.font = .boldSystemFont(ofSize: 28)
        nameLabel.textAlignment = .center

        let detailsLabel = UILabel()
        detailsLabel.text = "Age: \(age)\n\(course)\n\(college)"
        detailsLabel.numberOfLines = 0
        detailsLabel.textAlignment = .center
        detailsLabel.textColor = .secondaryLabel
        detailsLabel.font = .systemFont(ofSize: 17)

        let aboutLabel = UILabel()
        aboutLabel.text = aboutText
        aboutLabel.numberOfLines = 0
        aboutLabel.textAlignment = .center
        aboutLabel.font = .systemFont(ofSize: 16)

        let stack = UIStackView(arrangedSubviews: [avatar, nameLabel, detailsLabel, aboutLabel])
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            avatar.heightAnchor.constraint(equalToConstant: 130),
            stack.topAnchor.constraint(equalTo: guide.topAnchor, constant: 40),
            stack.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -24)
        ])
    }
}
