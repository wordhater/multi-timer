import SwiftUI

extension Timer{
    @MainActor class ViewModel: ObservableObject{
        @Published var timer_progress = 0.0
        @Published var Timer_name = "name"
    }

}
extension start{
    @MainActor class ViewModel: ObservableObject{
        @Published var add_timer_popup_shown = false
        @Published var timernamelist = ["timer1", "timer2"]
        @Published var timerlengthlist = [100, 30]
        @Published var new_timer_name = ""
        @Published var new_timer_mins = ""
        @Published var new_timer_secs = ""
        @Published var new_timer_mins_int = 0
        @Published var new_timer_secs_int = 0
        func new_timer(name: String, length_mins: Int, length_secs: Int){
            timernamelist.append(name)
            timerlengthlist.append(length_mins * 60 + length_secs)
        }
    }
    
}
