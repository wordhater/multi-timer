import SwiftUI


struct start: View {
    @StateObject private var data = ViewModel()
    @ObservedObject var input = NumbersOnly()
    var body: some View{
        VStack {
            HStack{
                Image(systemName: "square.and.pencil.circle.fill")
                    .padding(15)
                    .scaleEffect(CGSize(width: 2.0, height: 2.0), anchor: .center)
                    .onTapGesture {
                    data.add_timer_popup_shown = true
                }
                .alert("Add Timer", isPresented: $data.add_timer_popup_shown, actions: {
                    TextField("name", text: $input.new_timer_name)
                        .padding(10)
                        .keyboardType(.default)
                    TextField("mins", text: $input.new_timer_mins)
                        .padding(10)
                        .keyboardType(.decimalPad)
                    TextField("secs", text: $input.new_timer_secs)
                        .padding(10)
                        .keyboardType(.decimalPad)
                    
                    Button("Add", action: {
                        Task{
                            if input.new_timer_mins.count == 0 {
                                data.new_timer_mins_int = 0
                            }else{
                                data.new_timer_mins_int = Int(input.new_timer_mins)!
                            }
                            if input.new_timer_secs.count == 0{
                                data.new_timer_secs_int = 0
                            }else{
                                data.new_timer_secs_int = Int(input.new_timer_secs)!
                            }
                            data.new_timer(name: input.new_timer_name, length_mins: data.new_timer_mins_int, length_secs: data.new_timer_secs_int)
                        }
                    })
                    Button("Cancel", role: .cancel, action: {})
                }, message: {
                    Text("Please enter a name and a length for your timer.")
                })
                Text("New Timer")
                    .font(.subheadline)
                Spacer()
            }
            List {
                    ForEach((1...data.timernamelist.count), id: \.self) { t in 
                        if t-1 == 0{
                            HStack {
                                Text("Timers")
                                    .font(.title)
                                    .bold()
                                    .onAppear(perform: {
                                        data.build_index = t
                                    })
                                Spacer()
                            }
                        }else{
                            Timer(name: $data.timernamelist[t-1], length: $data.timerlengthlist[t-1], index: $data.build_index)
                                .onAppear(perform: {
                                    data.build_index = t
                                })
                        }
                    }
            }
            .listStyle(.inset)
        }
    }
}

