
import UIKit

final class EventLog {
    static var counter = 0
    static func next() -> Int {
        counter += 1
        return counter
    }
}

class LoggingViewController: UIViewController {

    let screenName: String
    let accentColor: UIColor
    let logTextView = UITextView()
    var logText = ""

    init(name: String, color: UIColor) {
        self.screenName = name
        self.accentColor = color
        super.init(nibName: nil, bundle: nil)
        log("init")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func log(_ event: String) {
        let line = "\(EventLog.next()). [\(screenName)] \(event)"
        print(line)                             
        logText += line + "\n"
        if isViewLoaded {                        
            logTextView.text = logText
            let end = NSRange(location: max(logText.count - 1, 0), length: 1)
            logTextView.scrollRangeToVisible(end)
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = accentColor.withAlphaComponent(0.15)

        let titleLabel = UILabel()
        titleLabel.text = "\(screenName) Screen"
        titleLabel.font = .boldSystemFont(ofSize: 30)
        titleLabel.textColor = accentColor
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let hintLabel = UILabel()
        hintLabel.text = "Switch tabs and watch the order of events"
        hintLabel.font = .systemFont(ofSize: 15)
        hintLabel.textColor = .secondaryLabel
        hintLabel.textAlignment = .center
        hintLabel.numberOfLines = 0
        hintLabel.translatesAutoresizingMaskIntoConstraints = false

        logTextView.isEditable = false
        logTextView.font = .monospacedSystemFont(ofSize: 13, weight: .regular)
        logTextView.backgroundColor = .systemBackground
        logTextView.layer.cornerRadius = 10
        logTextView.textContainerInset = UIEdgeInsets(top: 12, left: 10, bottom: 12, right: 10)
        logTextView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(titleLabel)
        view.addSubview(hintLabel)
        view.addSubview(logTextView)

        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20),

            hintLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            hintLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20),
            hintLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20),

            logTextView.topAnchor.constraint(equalTo: hintLabel.bottomAnchor, constant: 16),
            logTextView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16),
            logTextView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -16),
            logTextView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -16)
        ])

        log("viewDidLoad")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        log("viewWillAppear")
    }

    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        log("viewIsAppearing")
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // Layout runs many times; logged only once so the log stays readable
        if !didLogLayout {
            didLogLayout = true
            log("viewWillLayoutSubviews (first time)")
        }
    }
    private var didLogLayout = false

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        log("viewDidAppear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        log("viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        log("viewDidDisappear")
    }
}
