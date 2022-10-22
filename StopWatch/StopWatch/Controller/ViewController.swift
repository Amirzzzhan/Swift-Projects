//
//  ViewController.swift
//  StopWatch
//
//  Created by Amirzhan Armandiyev on 20.10.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeDisplay: UILabel!
    @IBOutlet weak var lapTimeDisplay: UILabel!
    @IBOutlet weak var lapTimesTable: UITableView!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var lapResetButton: UIButton!
    
    private var mainTime = Time()
    private var lapTime = Time()
    private var lapTimesStorage = LapTimesStorage()
    private var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Stopwatch"
        lapTimesTable.delegate = self
    }
    
    @IBAction func lapResetPressed(_ sender: Any) {
        if(timer.isValid) {
            lapTimesStorage.addTime(lapTime.description)
        } else {
            lapTimesStorage = LapTimesStorage()
            mainTime = Time()
            timeDisplay.text = mainTime.description
            lapResetButton.setAttributedTitle(getAttributedTitle(myString: "Lap"), for: .normal)
        }
        lapTime = Time()
        lapTimeDisplay.text = "00:00.00"
        lapTimesTable.reloadData()
    }
    
    @objc func timeGoes() {
        mainTime.increment()
        lapTime.increment()
        lapTimeDisplay.text = lapTime.description
        timeDisplay.text = mainTime.description
    }
    
    @IBAction func startStopPressed(_ sender: Any) {
        if(!timer.isValid) {
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timeGoes), userInfo: nil, repeats: true)
            RunLoop.current.add(self.timer, forMode: RunLoop.Mode.common)
        
            startStopButton.setAttributedTitle(getAttributedTitle(myString: "Stop", color: .red), for: .normal)
            lapResetButton.setAttributedTitle(getAttributedTitle(myString: "Lap"), for: .normal)
        } else {
            timer.invalidate()
            
            startStopButton.setAttributedTitle(getAttributedTitle(myString: "Start", color: .green), for: .normal)
            lapResetButton.setAttributedTitle(getAttributedTitle(myString: "Reset"), for: .normal)
        }
    }
}

func getAttributedTitle(myString: String, color: UIColor = .black) -> NSAttributedString {
    let myAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: UIFont(name: "Apple Symbols", size: 38)!]
    return NSAttributedString(string: myString, attributes: myAttributes)
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lapTimesStorage.size
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = lapTimesTable.dequeueReusableCell(withIdentifier: "LabCell", for: indexPath) as! LapTableViewCell
        
        let index = lapTimesStorage.size - indexPath.row - 1
        cell.lapCounter.text = "Lap " + String(index + 1)
        cell.lapTime.text = lapTimesStorage.labArr[index]
        
        
        
        if(lapTimesStorage.size > 1) {
            if(lapTimesStorage.labArr[index] == lapTimesStorage.minVal) {
                cell.lapTime.textColor = .green
                cell.lapCounter.textColor = .green
            } else if(lapTimesStorage.labArr[index] == lapTimesStorage.maxVal) {
                cell.lapTime.textColor = .red
                cell.lapCounter.textColor = .red
            } else {
                cell.lapTime.textColor = .black
                cell.lapCounter.textColor = .black
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        false
    }
}

