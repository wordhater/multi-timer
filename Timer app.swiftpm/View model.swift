import SwiftUI
import AVFoundation

enum TimerAppErrors: Error {
    case invalid_input
    case err
}

extension Timer{
    @MainActor class ViewModel: ObservableObject{
        @Published var delete_popup_shown = false
        @Published var timer_progress = 0.0
        @Published var Timer_name = "name"
        @Published var Time_remaining = 0
        @Published var Timer_done = false
        @Published var Timer_running = false
        @Published var length = 0
        @Published var seconds = 0
        @Published var deletion_check = false
        @Published var pause = true
        func clock() async{
            Timer_done = false
            Timer_running = true
            while true{
                if deletion_check == false {
                    if pause == false{
                        do{
                            try await Task.sleep(for: .seconds(1))
                        }catch{
                            print("error in waiting")
                        }
                        UIApplication.shared.isIdleTimerDisabled = true
                        print(Time_remaining)
                        Time_remaining -= 1
                        timer_progress = Double(Time_remaining) / Double(length)
                        seconds = Time_remaining - Int(Int(Time_remaining / 60) * 60)
                        if Time_remaining < 1 {
                            Timer_done = true
                            Timer_running = false
                            UIApplication.shared.isIdleTimerDisabled = false
                            pause = true
                        }
                    }else{
                        do{
                            try await Task.sleep(for: .seconds(1))
                        }catch{
                            print("error in waiting")
                        }
                    }
                }else{
                    break
                }
            }
        }
    }
}
extension start{
    @MainActor class ViewModel: ObservableObject{
        @Published var add_timer_popup_shown = false
        @Published var timernamelist = ["error buffer", "test timer"]
        @Published var timerlengthlist = [1, 10]
        @Published var build_index = 1
        @Published var new_timer_mins_int = 0
        @Published var new_timer_secs_int = 0
        func new_timer(name: String, length_mins: Int, length_secs: Int){
            timernamelist.append(name)
            timerlengthlist.append(length_mins * 60 + length_secs)
        }
    }
    class NumbersOnly: ObservableObject {
        @Published var new_timer_name = ""
            
        @Published var new_timer_mins = ""{
            didSet {
                let filtered = new_timer_mins.filter { $0.isNumber }
                
                if new_timer_mins != filtered {
                    new_timer_mins = filtered
                }
            }
        }
            
        @Published var new_timer_secs = "" {
            didSet {
                let filtered = new_timer_secs.filter { $0.isNumber }
                
                if new_timer_secs != filtered {
                    new_timer_secs = filtered
                }
            }
        }
    }
}
