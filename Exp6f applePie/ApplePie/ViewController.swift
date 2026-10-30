

import UIKit

class ViewController: UIViewController {

    // MARK: - Game data

    let listOfWords = ["swift", "xcode", "button", "storyboard", "simulator",
                       "protocol", "optional", "closure", "variable", "function",
                       "enumeration", "controller"]
    let incorrectMovesAllowed = 7
    var totalWins = 0
    var totalLosses = 0

    var currentGame: Game!
    var remainingWords: [String] = []

    // MARK: - UI

    let treeImageView = UIImageView()
    let wordLabel = UILabel()
    let scoreLabel = UILabel()
    let lettersStack = UIStackView()
    var letterButtons: [UIButton] = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        buildInterface()
        remainingWords = listOfWords.shuffled()
        newRound()
    }

    // MARK: - Building the screen

    func buildInterface() {
        treeImageView.contentMode = .scaleAspectFit
        treeImageView.translatesAutoresizingMaskIntoConstraints = false

        wordLabel.font = .monospacedSystemFont(ofSize: 34, weight: .bold)
        wordLabel.textAlignment = .center
        wordLabel.adjustsFontSizeToFitWidth = true
        wordLabel.minimumScaleFactor = 0.5
        wordLabel.translatesAutoresizingMaskIntoConstraints = false

        scoreLabel.font = .systemFont(ofSize: 17, weight: .medium)
        scoreLabel.textAlignment = .center
        scoreLabel.textColor = .secondaryLabel
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false

        lettersStack.axis = .vertical
        lettersStack.spacing = 8
        lettersStack.distribution = .fillEqually
        lettersStack.translatesAutoresizingMaskIntoConstraints = false

        // Build A-Z buttons in rows of 7 (7+7+7+5)
        let alphabet = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        let rowSize = 7
        var index = 0
        while index < alphabet.count {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = 8
            rowStack.distribution = .fillEqually
            for letter in alphabet[index ..< min(index + rowSize, alphabet.count)] {
                let button = UIButton(type: .system)
                button.setTitle(String(letter), for: .normal)
                button.titleLabel?.font = .systemFont(ofSize: 22, weight: .semibold)
                button.backgroundColor = .systemGray5
                button.layer.cornerRadius = 8
                button.addTarget(self, action: #selector(letterButtonTapped(_:)), for: .touchUpInside)
                letterButtons.append(button)
                rowStack.addArrangedSubview(button)
            }
            // Pad the last row with empty views so buttons keep the same width
            if rowStack.arrangedSubviews.count < rowSize {
                for _ in 0 ..< (rowSize - rowStack.arrangedSubviews.count) {
                    rowStack.addArrangedSubview(UIView())
                }
            }
            lettersStack.addArrangedSubview(rowStack)
            index += rowSize
        }

        view.addSubview(treeImageView)
        view.addSubview(wordLabel)
        view.addSubview(lettersStack)
        view.addSubview(scoreLabel)

        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            treeImageView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 20),
            treeImageView.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            treeImageView.widthAnchor.constraint(equalToConstant: 220),
            treeImageView.heightAnchor.constraint(equalToConstant: 160),

            wordLabel.topAnchor.constraint(equalTo: treeImageView.bottomAnchor, constant: 24),
            wordLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20),
            wordLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20),

            lettersStack.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 24),
            lettersStack.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16),
            lettersStack.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -16),
            lettersStack.heightAnchor.constraint(equalToConstant: 250),

            scoreLabel.topAnchor.constraint(equalTo: lettersStack.bottomAnchor, constant: 20),
            scoreLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20),
            scoreLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20)
        ])
    }

    // MARK: - Game flow

    func newRound() {
        if remainingWords.isEmpty {
            // All words used: show the final score and restart the list
            let alert = UIAlertController(title: "Game Over",
                                          message: "Final score — Wins: \(totalWins), Losses: \(totalLosses)",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Play Again", style: .default) { _ in
                self.remainingWords = self.listOfWords.shuffled()
                self.totalWins = 0
                self.totalLosses = 0
                self.newRound()
            })
            present(alert, animated: true)
            enableLetterButtons(false)
            return
        }
        let newWord = remainingWords.removeFirst()
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed)
        enableLetterButtons(true)
        updateUI()
    }

    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
            button.alpha = enable ? 1.0 : 0.4
        }
    }

    func updateUI() {
        let letters = currentGame.formattedWord.map { String($0) }
        wordLabel.text = letters.joined(separator: " ")
        scoreLabel.text = "Wins: \(totalWins)   Losses: \(totalLosses)"
        treeImageView.image = appleImage(count: currentGame.incorrectMovesRemaining)
    }

    func updateGameState() {
        if currentGame.hasLost {
            totalLosses += 1
            newRound()
        } else if currentGame.hasWon {
            totalWins += 1
            newRound()
        } else {
            updateUI()
        }
    }

    // MARK: - Actions

    @objc func letterButtonTapped(_ sender: UIButton) {
        sender.isEnabled = false
        sender.alpha = 0.4
        guard let title = sender.title(for: .normal),
              let letter = title.lowercased().first else { return }
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }

    // MARK: - Drawing the apples (stands in for the tree images)

    /// Draws `count` apple emoji into an image, so no asset catalog files are required.
    func appleImage(count: Int) -> UIImage {
        let size = CGSize(width: 220, height: 160)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            let text = count > 0 ? String(repeating: "🍎", count: count) : "🥧"
            let font = UIFont.systemFont(ofSize: count > 4 ? 30 : 40)
            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = .center
            let attributes: [NSAttributedString.Key: Any] = [.font: font, .paragraphStyle: paragraph]
            let rect = CGRect(x: 0, y: 30, width: size.width, height: size.height - 30)
            text.draw(in: rect, withAttributes: attributes)
        }
    }
}
