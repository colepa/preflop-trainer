//
//  ContentView.swift
//  preflop-practice
//
//  Created by Cole Paris on 2/19/24.
//

//Cards are randomly generated displayed on home screen
//user presses either fold or open
// new screen pops up (overlayed, not transitioned to) that has a background red or green depending on if it is correct
// shows equity of folding or opening
// tap anywhere to go back to home screen


import SwiftUI
import Foundation
func LoadCurrDecision()-> String{
    if let file_url = Bundle.main.url(forResource: "\(curr_position)-default1" , withExtension: "txt"){
        if let file_contents = try? String(contentsOf: file_url){
            let lines = file_contents.split(separator:",")
            var formatted_num1 = String()
            var formatted_num2 = String()
            if curr_num1 == 10{
                formatted_num1 = "T"
            }
            else{
                formatted_num1 = numToString(curr_num1)
            }
            if curr_num2 == 10{
                formatted_num2 = "T"
            }
            else{
                formatted_num2 = numToString(curr_num2)
            }
            var suited: Character
            if curr_suit1 == curr_suit2{
                suited = "s"
            }
            else if curr_num1 == curr_num2{
                suited = "x"
            }
            else{
                suited = "o"
            }
            for line in lines{
                let parts = line.split(separator: ":")
                let curr_line = [Character](parts[0])
                if (curr_line[0] == Character(formatted_num1))&&(curr_line[1] == Character(formatted_num2)){
                    if (curr_line.count < 3){
                        if suited == "x"{
                            return String(parts[1])
                        }
                    }
                    else if (curr_line[2] == suited){
                        return String(parts[1])
                    }
                }
            
            }
           
        }
        
    }
    return "0.0"
    
}

func RandomNum() ->Int {
    return Int.random(in: 2...14)
}
func RandomSuit() ->Int {
   return Int.random(in:1...4)
}
func RandomPos() ->String {
    return position_array[Int.random(in:0...4)]
}
func NewHand () ->Void {
    curr_num1 = RandomNum()
    curr_suit1 = RandomSuit()
    curr_num2 = RandomNum()
    curr_suit2 = RandomSuit()
    while (curr_num1 == curr_num2) && (curr_suit1 == curr_suit2){
        curr_num2 = RandomNum()
        curr_suit2 = RandomSuit()
    }
    if curr_num2 > curr_num1{
        let temp = curr_num2
        curr_num2 = curr_num1
        curr_num1 = temp
    }
}
func suitToString(_ suit: Int) -> String {
        switch suit {
        case 1: return "suit.heart.fill"
        case 2: return "suit.diamond.fill"
        case 3: return "suit.club.fill"
        case 4: return "suit.spade.fill"
        default: return " "
        }
}
func suitColor(_ suit: Int) -> Color {
    switch suit {
    case 1: return .red
    case 2: return .blue
    case 3: return .green
    case 4: return .black
    default: return .black
    }
}
func numToString(_ suit: Int) -> String {
        switch suit {
        case 2: return "2"
        case 3: return "3"
        case 4: return "4"
        case 5: return "5"
        case 6: return "6"
        case 7: return "7"
        case 8: return "8"
        case 9: return "9"
        case 10: return "10"
        case 11: return "J"
        case 12: return "Q"
        case 13: return "K"
        case 14: return "A"
        default: return " "
        }
}
var curr_num1 = RandomNum()
var curr_suit1 = RandomSuit()
var curr_num2 = RandomNum()
var curr_suit2 = RandomSuit()
var position_array = ["UTG","HJ","CO","BTN","SB","BB"]
var curr_position = RandomPos()
var curr_decision = Double(LoadCurrDecision())
struct ContentView: View {
    @State var show_result = false
    @State private var resultColor: Color = .red
    @State private var resultText: String = ""
    var body: some View {
        NavigationStack{
            ZStack{
                
                VStack {
                    HStack{
                        ZStack{
                            RoundedRectangle(cornerRadius: 0.0, style: .continuous)
                                .foregroundColor(.white)
                                .frame(width:150, height: 250, alignment: .topLeading)
                                .border(.black)
                            
                            HStack{
                                VStack{
                                    Text(numToString(curr_num1))
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                    Spacer()
                                        .frame(height:200)
                                }
                                Spacer()
                                    .frame(width:100)
                            }
                            HStack{
                                VStack{
                                    Image(systemName: "\(suitToString(curr_suit1))")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(suitColor(curr_suit1))
                                    Spacer()
                                        .frame(width: 60, height:130)
                                }
                                Spacer()
                                    .frame(width:100)
                            }
                            
                            
                            VStack{
                                Spacer()
                                    .frame(height: 40)
                                Image(systemName: "\(suitToString(curr_suit1))")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120, height: 120)
                                    .foregroundColor(suitColor(curr_suit1))
                            }
                            
                        }
                       
                        ZStack{
                            RoundedRectangle(cornerRadius: 0.0, style: .continuous)
                                .foregroundColor(.white)
                                .frame(width:150, height: 250, alignment: .topLeading)
                                .border(.black)
                            
                            HStack{
                                VStack{
                                    Text(numToString(curr_num2))
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        
                                    Spacer()
                                    .frame(height:200)
                                }
                                Spacer()
                                    .frame(width:100)
                            }
                            HStack{
                                VStack{
                                    Image(systemName: "\(suitToString(curr_suit2))")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(suitColor(curr_suit2))
                                    Spacer()
                                        .frame(width: 60, height:130)
                                }
                                Spacer()
                                    .frame(width:100)
                            }
                            
                            
                            VStack{
                                Spacer()
                                    .frame(height: 40)
                                Image(systemName: "\(suitToString(curr_suit2))")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120, height: 120)
                                    .foregroundColor(suitColor(curr_suit2))
                            }
                            
                        }
                    }
                    Text("Position: \(curr_position)")
                        .font(.title)
                    Spacer()
                        .frame(height:30)
                    HStack {
                        Button(action: {
                            show_result = true
                            if (curr_decision!<=0.5){
                                resultColor = .green
                                resultText = "Correct!"
                            }
                            else{
                                resultColor = .red
                                resultText = "Incorrect"
                            }
                            
                        }, label: {
                            DecisionView(color: .gray, text: "Fold")

                        })
                        Button(action: {
                            show_result = true
                            if (curr_decision!>=0.5){
                                resultColor = .green
                                resultText = "Correct!"
                            }
                            else{
                                resultColor = .red
                                resultText = "Incorrect"
                            }
                        }, label: {
                            DecisionView(color: .blue, text: "Open")

                        })
                        
                    }

                   
                }
                if show_result == true{
                    ResultView(color: resultColor ,text:"\(resultText)")
                        .onTapGesture {
                            show_result = false
                            NewHand()
                            curr_position = RandomPos()
                            curr_decision = Double(LoadCurrDecision())
                            let myDouble = Double(LoadCurrDecision())
                            
                        }
                    
                }
                
                
            }
            
        }
    }
    
    struct DecisionView: View {
        var color: Color
        var text: String
        var body: some View{
            ZStack{
                
                RoundedRectangle(cornerRadius: 20.0, style: .continuous)
                    .frame(width:180, height: 100)
                    .foregroundColor(color)
                
                Text("\(text)")
                    .foregroundColor(.white)
                    .font(.system(size:50, weight: .bold))
            }
        }
        
    }
    
    struct ResultView: View {
        
        var color: Color
        var text: String
        var body: some View{
            ZStack{
                
                RoundedRectangle(cornerRadius: 20.0, style: .continuous)
                    .frame(width:4000, height: 2000)
                    .foregroundColor(color)
                Text("\(text)")
                    .foregroundColor(.white)
                    .font(.system(size:30, weight: .bold))
                
            }
        }
    }

    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View{
            ContentView()
        }
    }
}
