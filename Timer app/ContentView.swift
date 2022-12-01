import SwiftUI


struct start: View {
    @StateObject private var data = ViewModel()
    var body: some View{
        VStack {
            HStack{
                Button("New Timer"){
                    data.add_timer_popup_shown = true
                }
                .alert("Add Timer", isPresented: $data.add_timer_popup_shown, actions: {
                    TextField("name", text: $data.new_timer_name)
                    TextField("mins", text: $data.new_timer_mins)
                    TextField("secs", text: $data.new_timer_secs)
                    
                    
                    Button("Add", action: {
                        do{
                            try data.new_timer_mins_int = Int(data.new_timer_mins)!
                            try data.new_timer_secs_int = Int(data.new_timer_secs)!
                        }catch{
                            
                        }
                    })
                    Button("Cancel", role: .cancel, action: {})
                }, message: {
                    Text("Please enter a name and a length for your timer.")
                })
                Spacer()
            }
            List {
                ForEach((1...data.timernamelist.count), id: \.self) { t in 
                    Timer(name: $data.timernamelist[t-1], length: $data.timerlengthlist[t-1])
                }
            }
            .listStyle(.inset)
        }
    }
}
struct Timer: View {
    @StateObject private var data = ViewModel()
    @Binding var name : String
    @Binding var length : Int
    var body: some View {
        VStack {
            Section {
                HStack {
                    Text(name)
                    Gauge(value: Float(data.timer_progress), in: 0...1) {}
                        .gaugeStyle(.accessoryLinearCapacity)
                    
                }
            }
        }
    }
    
}

