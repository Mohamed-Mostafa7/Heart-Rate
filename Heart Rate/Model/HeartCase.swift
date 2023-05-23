//
//  HeartCase.swift
//  Heart Rate
//
//  Created by Mohamed Mostafa on 23/05/2023.
//

import Foundation

class HeartCase {
    
    func getHeartCase(_ heartSpeed: HeartSpeed) -> Heart{
        if heartSpeed == .slow {
            return Heart(background: .yellow, message: "Slow Heart Rate!", timeForBeat: 2)
        } else if heartSpeed == .fast {
            return Heart(background: .red, message: "Fast Heart Rate!", timeForBeat: 0.25)
        } else {
            return Heart(background: .green, message: "Perfect Heart Rate!", timeForBeat: 1)
        }
    }
}


enum HeartSpeed: String {
    
    case slow
    case modirate
    case fast
    
}
