//
//  TransformersController.swift
//  Aequilibrium
//
//  Created by CtanLI on 2019-09-11.
//  Copyright © 2019 aequilibrium. All rights reserved.
//

import UIKit

class TransformersController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let battleControllerSegue = "BattleControllerSegue"
    @IBOutlet weak var transformerTable: UITableView!
    var fighters = [TransformerViewModel]()
    var transformers = [TransformerViewModel]() {
        didSet {
            transformerTable.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select Fighters"
        getTransformers()
    }

    func getTransformers() {
        let getUrl = BaseAPIClient.urlFromPath(path: APIEndPoints.transformers)
        APIService.shared.fetchGenericData(method: .get, urlString: getUrl, params: nil, headers: APIEndPoints.authorizationHeader) { (result: TransformerModel?, errorCode) in
            if errorCode == nil {
                let bots = result?.transformers
                let _ = bots.map { values in
                    let sorted = values.sorted {$0.rank > $1.rank}
                    self.transformers = sorted.map({return TransformerViewModel(tvm: $0)})
                }
            } else {
                print(errorCode ?? 0)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transformers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "TransformerCell") as! TransformerCell
        cell.transformers = transformers[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = tableView.cellForRow(at: indexPath) as! TransformerCell
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
            } else {
                cell.accessoryType = .checkmark
                if fighters.count == 2 {
                     cell.accessoryType = .none
                   return
                } else if fighters.count != 2 {
                     fighters.append(obj.transformers)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let obj = tableView.cellForRow(at: indexPath) as! TransformerCell
       if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            cell.accessoryType = .none
            let _ = fighters.remove(object: obj.transformers)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    
    @IBAction func fight(_ sender: UIButton) {
        self.performSegue(withIdentifier: battleControllerSegue, sender: nil)
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == battleControllerSegue {
            let battle = segue.destination as! BattleController
            battle.fighters = fighters
        }
    }
}
