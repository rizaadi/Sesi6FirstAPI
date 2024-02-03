//
//  ContentView.swift
//  Sesi6FirstAPI
//
//  Created by Hidayat Abisena on 28/01/24.
//

import SwiftUI

struct CardView: View {
    @State private var fadeIn: Bool = false
    @State private var moveDownward: Bool = false
    @State private var moveUpward: Bool = false
    @State private var showPunchline: Bool = false
    @State private var soundNumber = 4
    let totalSounds = 24
    
    @StateObject private var jokeVM = JokeVM()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ZStack {
                    VStack {
                        Text("Setup:")
                            .foregroundStyle(.white)
                            .font(.custom("PermanentMarker-Regular", size: 30))
                        
                        Text(jokeVM.joke?.setup ?? Constants.DefaultValues.noJokes)
                            .foregroundStyle(.white)
                            .fontWeight(.light)
                            .italic()
                    }
                    .offset(y: moveDownward ? -218 : -300)
                    
                    Group {
                        if showPunchline {
                            Text(jokeVM.joke?.punchline ?? "")
                                .foregroundStyle(.white)
                                .font(.custom("PermanentMarker-Regular", size: 35))
                                .multilineTextAlignment(.center)
                        }
                    }
                    
                    Button {
                        playSound(soundName: "\(soundNumber)")
                        soundNumber += 1
                        if soundNumber > totalSounds {
                            soundNumber = 0
                        }
                        showPunchline.toggle()
                       
                    } label: {
                        HStack {
                            Text("Punchline".uppercased())
                                .fontWeight(.heavy)
                                .foregroundStyle(.white)
                            
                            Image(systemName: "arrow.right.circle")
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                        }
                        .padding(.vertical)
                        .padding(.horizontal, 24)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.color07, Color.color08]), startPoint: .leading, endPoint: .trailing)
                        )
                        .clipShape(Capsule())
                        .shadow(color: Color("ColorShadow"), radius: 6, x: 0, y: 3)
                    }
                    .offset(y: moveUpward ? 210 : 300)
                    
                }
                .navigationTitle("Swift Jokes")
                .frame(width: 335, height: 545)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.color07, Color.color08]), startPoint: .top, endPoint: .bottom)
                )
                .opacity(fadeIn ? 1.0 : 0.0)
                .onAppear() {
                  withAnimation(.linear(duration: 1.2)) {
                    self.fadeIn.toggle()
                  }
                    
                  withAnimation(.linear(duration: 0.6)) {
                    self.moveDownward.toggle()
                    self.moveUpward.toggle()
                  }
                }
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .task {
                   await jokeVM.fetchJoke()
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            Task {
                                playSingleSound(sound: "sound-chime", type: "mp3")
                                await jokeVM.fetchJoke()
                                showPunchline = false
                            }
                        } label : {
                            Image(systemName: "arrow.clockwise")
                                .foregroundStyle(.black)
                        }
                    }
                }
            }
            JokesTypePicker(jokesTypeVM: jokeVM)
        }
    }
}

#Preview {
    CardView()
}
