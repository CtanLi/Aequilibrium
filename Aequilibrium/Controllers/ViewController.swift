//
//  ViewController.swift
//  Aequilibrium
//
//  Created by CtanLI on 2019-09-10.
//  Copyright © 2019 aequilibrium. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let showAddedTransformers = "showAddedTransformers"
    @IBOutlet weak var botName: UITextField!
    @IBOutlet weak var confirmationMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addDoneButtonOnKeyboard()
    }

    func getRandomValue() -> Int {
       return Int.random(in: 0 ... 10)
    }
    
    func getRandomTeams() -> String {
        let teams = ["A", "D"]
        let random = teams[Int(arc4random_uniform(UInt32(teams.count)))]
        return random
    }
    
    func createTransformer() {
        let name = botName.text
        let strength = getRandomValue()
        let intelligence = getRandomValue()
        let speed = getRandomValue()
        let endurance = getRandomValue()
        let rank = getRandomValue()
        let courage = getRandomValue()
        let firepower = getRandomValue()
        let skill = getRandomValue()
        let team = getRandomTeams()
        
        let params = ["name": name ?? "", "strength": strength, "intelligence": intelligence, "speed": speed, "endurance": endurance, "rank": rank, "courage": courage, "firepower": firepower, "skill": skill, "team": team, ] as [String : Any]
        let createUrl = BaseAPIClient.urlFromPath(path: APIEndPoints.transformers)
        APIService.shared.fetchGenericData(method: .post, urlString: createUrl, params: params, headers: APIEndPoints.authorizationHeader) { (result: CreateModel?, code) in
            if code == nil {
                self.confirmationMessage.text = "New Transformer \(result?.name ?? "") Created"
                 self.botName.text = String()
            } else {
                 self.confirmationMessage.text = "Transformer already exist please create another one"
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    self.confirmationMessage.text = "Progress message goes here"
                })
            }
        }
    }

    @IBAction func createTransformer(_ sender: UIButton) {
        createTransformer()
    }
    
    //
    // Mark: Dismiss KeyBoard
    //
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30))
        doneToolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        botName.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction(){
        self.view.endEditing(true)
    }
    
    @IBAction func showAddedTransformers(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: showAddedTransformers, sender: nil)
    }
}

