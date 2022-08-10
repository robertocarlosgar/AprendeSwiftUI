//
//  ContentView.swift
//  AprendeSwiftUI
//
//  Created by alp1 on 19/7/22.
//

import SwiftUI
import AVKit

class SoundPlayer {
    var player: AVAudioPlayer?
    func play(withURL url: URL) {
        player = try! AVAudioPlayer(contentsOf: url)
        player?.prepareToPlay()
        player?.play()
    }
}

struct ContentView: View {
    private let soundPlayer = SoundPlayer()
    @AppStorage ("number") var number: Int = 0
    @StateObject private var viewModel = ViewModel()
    @Environment(\.scenePhase) var scenePhase
    @State var data = Data()
    
    var body: some View {
        //modify that
        if viewModel.isUnlocked{
            NavigationView{
                VStack{
                    Group{
                        Button(action: {
                            number += 1
                            guard let url = Bundle.main.url(forResource: "errorsound", withExtension: "mp3") else {return}
                            soundPlayer.play(withURL: url)
                        }) {
                            Text("\(number)")
                                .frame(width: 150, height: 150)
                                .foregroundColor(Color.white)
                                .font(.system(size: 30))
                                .background(Color.red)
                                .clipShape(Circle())
                        }
                        Button(action: {
                            let date = Date()
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "dd MMMM yyyy"
                            let spacer = ": "
                            let stringToAppend = dateFormatter.string(from: date) + spacer + String(number)
                            data.historial.append(stringToAppend)
                            number = 0
                        }, label: {
                            Text("Send data")
                                .foregroundColor(.white)
                                .frame(width: 200, height: 50)
                                .background(Color.green)
                                .cornerRadius(15)
                                .padding()
                        })
                    }.frame(maxHeight: .infinity, alignment: .bottom)
                    NavigationLink(destination: HistorialView()) {
                        Text("Historial")
                    }.padding()
                }.onChange(of: scenePhase) { newPhase in
                    if newPhase == .background {
                        print("Background")
                        viewModel.isUnlocked = false
                    }
                }
            }
        }else{
            VStack{
                Image(systemName: "faceid").font(.system(size: 56.0))
                VStack{
                    Text("App bloqueada").font(.system(size: 30.0).bold())
                    Text("Desbloquear con Face ID para abrir App")
                        .multilineTextAlignment(.center)
                }
                .padding()
                Button("Usar Face ID") {
                    viewModel.authenticationWithBiometrics()
                }.onAppear{
                    viewModel.authenticationWithBiometrics()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


