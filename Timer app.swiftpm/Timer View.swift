import SwiftUI

struct Timer: View {
    @StateObject private var data = ViewModel()
    @Binding var name : String
    @Binding var length : Int
    @Binding var index : Int
    var body: some View {
        if data.deletion_check == false {
            VStack {
                Section {
                    HStack {
                        Text(name)
                        Gauge(value: Float(data.seconds), in: 0...Float(length)) {}
                            .gaugeStyle(.accessoryCircularCapacity)
                            .animation(.timingCurve(1, 1, 1, 1, duration: 1.1))
                        Text("Time Remaining: \(String(format: "%02d:%02d", Int(data.Time_remaining / 60), data.seconds))")
                        ZStack{
                            if data.pause == true{
                                Image(systemName: "play")
                                    .imageScale(.small)
                                    .onTapGesture {
                                        Task{
                                            if data.Timer_running == false {
                                                data.Time_remaining = length
                                                data.length = length
                                            }
                                            print("tapped")
                                            data.pause = false
                                        }
                                    }
                            }else{
                                Image(systemName: "pause")
                                    .imageScale(.small)
                                    .onTapGesture {
                                        Task{
                                            print("tapped")
                                            data.pause = true
                                        }
                                    }
                            }
                        }
                        Spacer()
                        
                        Image(systemName: "trash.fill")
                            .onTapGesture {
                                data.delete_popup_shown = true
                            }
                        .alert("Delete Timer", isPresented: $data.delete_popup_shown, actions: {
                            Button("Cancel", role: .cancel, action: {})
                            Button("DELETE", role: .destructive, action: {
                                data.deletion_check = true
                            })
                        })
                    }
                }
            }
            .onAppear(perform: {
                data.Time_remaining = length
                Task{
                    await data.clock()
                }
            })
        }
    }
}
