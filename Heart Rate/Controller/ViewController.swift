//
//  ViewController.swift
//  Heart Rate
//
//  Created by Mohamed Mostafa on 23/05/2023.
//

import UIKit
import HealthKit

class ViewController: UIViewController {
    
    var timer: Timer?
    var animationTimer: Timer?
    let healthStore = HKHealthStore()
    let heartCase = HeartCase()
    var working: Bool? {
        didSet{
            if working == true {
                startEndButton.setTitle("Stop", for: .normal)
                start()
            } else {
                startEndButton.setTitle("Start", for: .normal)
                stop()
            }
        }
    }
    
    @IBOutlet var heartImageView: UIImageView!
    @IBOutlet var heartRateLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    
    @IBOutlet var startEndButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        start()
    }
    
    
    @IBAction func StartEndButtonClicked(_ sender: UIButton) {
        working = !(working ?? false)
    }
    
    func start() {
        // Create a timer that fires every second.
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {  _ in
            self.getHeartRate()
        }
    }
    
    func stop() {
        // Stop the timer if it's running
        timer?.invalidate()
        timer = nil
        stopAnimatingHeart()
        self.heartRateLabel.text = "0"
        self.messageLabel.text = "Heart Rate"
        self.view.backgroundColor = .darkGray
    }
    
    func getHeartRate() {
        // Set up a query to get the most recent heart rate data
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        
        let currentDate = Date()
        let calendar = Calendar.current
        let firstDate = calendar.date(byAdding: .second, value: -(60*60*24), to: currentDate)
        
        let predicate = HKQuery.predicateForSamples(withStart: firstDate, end: currentDate, options: .strictEndDate)
        
        let query = HKSampleQuery(sampleType: heartRateType, predicate: predicate, limit: 0, sortDescriptors: nil) { (query, results, error) in
            
            guard let result = results?.last as? HKQuantitySample else {
                print("No results")
                return
            }
            
            // Get the heart rate value.
            let heartRateUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
            let heartRate = result.quantity.doubleValue(for: heartRateUnit)
            self.update(heartRate)
        }
        // Execute the query
        healthStore.execute(query)
    }
    
    func update(_ heartRate: Double) {
        var heart: Heart
        if heartRate < 60 {
            heart = self.heartCase.getHeartCase(HeartSpeed.slow)
            updateUI(heart, heartRate: heartRate)
        } else if heartRate > 100 {
            heart = self.heartCase.getHeartCase(HeartSpeed.fast)
            updateUI(heart, heartRate: heartRate)
        } else {
            heart = self.heartCase.getHeartCase(HeartSpeed.modirate)
            updateUI(heart, heartRate: heartRate)
        }
    }
    
    func updateUI(_ heart: Heart, heartRate: Double) {
        stopAnimatingHeart()
        DispatchQueue.main.async {
            self.heartRateLabel.text = String(Int(heartRate))
            self.messageLabel.text = heart.message
            self.view.backgroundColor = heart.background
            UIView.animate(withDuration: heart.timeForBeat, delay: 0) {
                let scale = 1 + 0.5/heart.timeForBeat
                self.heartImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
            } completion: { _ in
                DispatchQueue.main.async {
                    UIView.animate(withDuration: heart.timeForBeat, delay: 0) {
                        self.heartImageView.transform = .identity
                    }
                }
            }

        }
    }
    func stopAnimatingHeart() {
        animationTimer?.invalidate()
        animationTimer = nil
    }
    
}

