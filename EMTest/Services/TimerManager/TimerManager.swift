//
//  TimerManager.swift
//  EMTest
//
//  Created by Сергей Никитин on 17.03.2023.
//

import Foundation

protocol TimerManagerProtocol {
 
    func searchText(_ text: String)
    
}

final class TimerManager {
    
    private var delegate: TimerManagerProtocol!
    
    private var selectedHint: String!
    
    private var timer: Timer?
    
    func setManagerDelegate(with delegate: TimerManagerProtocol, andHint hint: String) {
        self.delegate = delegate
        self.selectedHint = hint
    }
    
    func start() {
        if let timer = self.timer, timer.isValid { timer.invalidate() }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(timerAction),
                                     userInfo: nil, repeats: false)
        
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    func finish() {
        guard let timer = self.timer, timer.isValid else { return }
        timer.invalidate()
    }
    
    @objc private func timerAction() {
        delegate?.searchText(selectedHint)
        finish()
    }
}
