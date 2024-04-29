//
//  GameViewController.swift
//  quiz
//
//  Created by Students on 22/04/24.
//

import UIKit

class GameViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var gamemodel = [question]()
    
    var currentquestion: question?
    @IBOutlet var label: UILabel!
    @IBOutlet var table: UITableView!
    var score = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        setupquestions()
        configureUI(question: gamemodel.first!)
        
    }
    
    
    private func configureUI(question: question ){
        label.text = question.text
        currentquestion = question
        table.reloadData()
        
        
    }
    
    private func checkAnswer(answer: Answer, question: question) -> Bool{
        
        
        return question.answers.contains(where: {$0.text == answer.text}) && answer.correct
        
                
    }
    
    
    
    private func setupquestions(){
        gamemodel.append(question(text: "WHAT IS THE FULL FORM OF RAM", answers:
                                    [Answer(text: "RANDOM ACQUIRING MEMORY", correct: false),
                                     Answer(text: "READ ACCESS MEMORY", correct: false),
                                     Answer(text: "RANDOM ACCESS MOMENT", correct: false),
                                     Answer(text: "RANDOM ACCESS MEMORY", correct: true),
                                    ]))
        
        gamemodel.append(question(text: "WHO IS THE FATHER OF COMPUTERS", answers:
                                    [Answer(text: "JAMES GOSLING", correct: false),
                                     Answer(text: "CHARLES BABBAGE", correct: true),
                                     Answer(text: "DENNIS RITCHIE", correct: false),
                                     Answer(text: "ARYAN SHARMA", correct: false),
                                    ]))
        
        gamemodel.append(question(text: "WHAT IS THE FULL FORM OF CPU", answers:
                                    [Answer(text: "COMPUTER PROCESSING UNIT", correct: false),
                                     Answer(text: "COMPUTER PRINCIPLE UNIT", correct: false),
                                     Answer(text: "CENTRAL PROCESSING UNIT", correct: true),
                                     Answer(text: "CONTROL PROCSSING UNIT", correct: false),
                                    ]))
        
        gamemodel.append(question(text: "WHICH LANGUAGE DOES THE COMPUTER UNDERSTANDS", answers: [
            Answer(text: "ENGLISH", correct: false),
            Answer(text: "MATHS", correct: false),
            Answer(text: "PYTHON", correct: false),
            Answer(text: "BINARY", correct: true),
        ]))
        
        gamemodel.append(question(text: "WHAT IS THE BRAIN OF COMPUTER", answers:
                                    [Answer(text: "CENTRAL PROCESSING UNIT", correct: true),
                                     Answer(text: "MEMORY", correct: false),
                                     Answer(text: "KEYBOARDS", correct: false),
                                     Answer(text: "CONTROL UNIT", correct: false),
                                    ]))
        
        gamemodel.append(question(text: "WHICH OF THE FOLLOWING IS NOT A CHARACTERISTIC OF COMPUTER", answers: 
                                    [Answer(text: "VERSATILITY", correct: false),
                                     Answer(text: "ACCURACY", correct: false),
                                    Answer(text: "I.Q.", correct: true),
                                    Answer(text: "DILIGENCE", correct: false),
                                    ]))
        
        gamemodel.append(question(text: "WHAT IS THE SMALLEST UNIT OF DATA", answers:
                                    [Answer(text: "BIT", correct: true),
                                     Answer(text: "KB", correct: false),
                                     Answer(text: "NIBBLE", correct: false),
                                     Answer(text: "BYTE", correct: false),
                                    ]))
        
        gamemodel.append(question(text: "WHICH IS NOT A COMPUTER CODE", answers:
                                    [Answer(text: "EDIC", correct: true),
                                     Answer(text: "BCD", correct: false),
                                     Answer(text: "EBCDIC", correct: false),
                                     Answer(text: "ASCII", correct: false),
                                    ]))
        
        gamemodel.append(question(text: "WHICH OF THE FOLLOWING IS NOT A HARDWARE?", answers:
                                    [Answer(text: "KEYBOARD", correct: false),
                                     Answer(text: "ARITHEMETIC AND LOGIC UNIT", correct: true),
                                     Answer(text: "SPEAKER", correct: false),
                                     Answer(text: "MONITOR", correct: false),
                                    ]))
        
        gamemodel.append(question(text: "WHICH OF THE FOLLOWING CAN ACCESS THE SERVER?", answers:
                                    [Answer(text: "WEB CLIENT", correct: true),
                                     Answer(text: "USER", correct: false),
                                     Answer(text: "WEB BROWSER", correct: false),
                                     Answer(text: "WEB SERVER", correct: false),
                                    ]))
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentquestion?.answers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath )
        cell.textLabel?.text = currentquestion?.answers[indexPath.row].text
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let question = currentquestion else{
            return
        }
        let answer = question.answers[indexPath.row]
      
        if checkAnswer(answer: answer, question: question){
            score += 1
            
        }
            if let index = gamemodel.firstIndex(where: { $0.text == currentquestion?.text}){
                if index < (gamemodel.count-1){
                    let nextquestion = gamemodel[index+1]
                    print("\(nextquestion.text)")
                    currentquestion = nil
                    configureUI(question: nextquestion)
                    
                }
                else{
                    let alert = UIAlertController(title: "done", message: "You beat the game . Your score is \(score) ", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "dismiss", style: .cancel, handler: nil))
                    present(alert, animated: true)
                    
                }
                
            
        }
        else{
            let alert = UIAlertController(title: "wrong", message: "try better", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
    
    
}
    struct question{
        let text: String
        let answers: [Answer]
    }
    struct Answer{
        let text: String
        let correct: Bool
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
