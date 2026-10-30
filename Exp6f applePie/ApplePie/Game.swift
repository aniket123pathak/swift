//
//  Game.swift
//  ApplePie
//
//  The "Model" in MVC: it only knows about the word and the player's progress.
//  It has no idea that buttons or labels exist.
//

import Foundation

struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetters: [Character] = []

    /// Shows the word with "_" for every letter the player hasn't found yet.
    var formattedWord: String {
        var result = ""
        for letter in word {
            if guessedLetters.contains(letter) {
                result.append(letter)
            } else {
                result.append("_")
            }
        }
        return result
    }

    var hasWon: Bool {
        return !formattedWord.contains("_")
    }

    var hasLost: Bool {
        return incorrectMovesRemaining <= 0
    }

    var isOver: Bool {
        return hasWon || hasLost
    }

    /// Records a guess and costs the player an apple if the letter isn't in the word.
    mutating func playerGuessed(letter: Character) {
        guard !guessedLetters.contains(letter) else { return }
        guessedLetters.append(letter)
        if !word.contains(letter) {
            incorrectMovesRemaining -= 1
        }
    }
}
