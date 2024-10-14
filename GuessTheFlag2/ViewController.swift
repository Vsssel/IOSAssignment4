import UIKit

class ViewController: UIViewController {
    
    var currentQuestion: Question?
    var score: Int = 0
    var countries: [Country] = []
    var questionOptions: [Country] = []
    var selectedContinent: Continent?

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var buttons: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let selectedContinent = selectedContinent {
            countries = selectedContinent.countries ?? []
            questionOptions = selectedContinent.countries ?? []
            questionOptions.shuffle()
            setQuestion()
        } else {
            print("Error: selectedContinent is nil!")
        }
    }
    
    func setQuestion() {
        if questionOptions.count <= 0 {
            showScore()
        }else{
            let correctCountry = questionOptions[0]
            let otherOptions = countries.shuffled().filter { $0 != correctCountry }.prefix(3)
            let options = Array(otherOptions) + [correctCountry]
            currentQuestion = Question(flag: correctCountry.flagName, correctAnswer: correctCountry, options: Array(options.shuffled()))
            questionOptions.remove(at: 0)
            
            if let flagName = currentQuestion?.flag {
                image.image = UIImage(named: flagName)
            }
            
            for (index, button) in buttons.enumerated() {
                if index < currentQuestion?.options.count ?? 0 {
                    button.setTitle(currentQuestion?.options[index].name, for: .normal)
                }
            }
        }
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        guard let question = currentQuestion else { return }
        
        if let buttonIndex = buttons.firstIndex(of: sender) {
            let selectedCountry = question.options[buttonIndex]
            if selectedCountry == question.correctAnswer {
                score += 1
                showAlert(title: "Correct", message: "You got it right")
            } else {
                showAlert(title: "Wrong", message: "That was not the correct country.")
            }
            
            scoreLabel.text = "Score: \(score)"
            setQuestion()
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Next", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showScore() {
        let alert = UIAlertController(title: "Game is over", message: "Your score: \(score)", preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
        }
}

