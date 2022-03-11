//
//  Home.swift
//  UI-500
//
//  Created by nyannyan0328 on 2022/03/11.
//

import SwiftUI

struct Home: View {

    
    @State var offset : CGFloat = 0
    
    @GestureState var isDragging : Bool = false
    
    @State var currentSliderProgreess : CGFloat = 0.5
    var body: some View {
       
        
        VStack{
            
            Text(getAttributed(string:"How was \nyour Food?"))
                .font(.title.weight(.semibold))
            
             
            GeometryReader{proxy in
                
                let size = proxy.size
                LottieAnimationView(lottiFile: "Rating", progress: $currentSliderProgreess)
                    .frame(width: size.width, height: size.height)
                    .scaleEffect(1.5)
            }
            
            ZStack{
                
                Rectangle()
                    .fill(.white)
                    .frame(height:1)
                
                
                Group{
                    
                    RoundedRectangle(cornerRadius: 9, style: .continuous)
                        .fill(.black)
                        .frame(width: 60, height: 60)
                    
                    Circle()
                        .fill(.white)
                        .frame(width: 15, height: 15)
                    
                }
          .frame(maxWidth:.infinity)
                .contentShape(Rectangle())
                .offset(x: offset)
                .gesture(
                
                    DragGesture(minimumDistance: 0.5).updating($isDragging, body: { _, out, _ in
                        out = true
                    })
                    .onChanged({ value in
                        
                        let width = UIScreen.main.bounds.width - 30
                        var translation = value.location.x
                    
                        translation = (translation > 30 ? translation : 30)
                        
                        translation = (translation < (width - 30) ? translation : (width - 30))
                        
                        translation = isDragging ? translation : 0
                        offset = translation - (width / 2)
                        
                        
                        let progress = (translation - 27) / (width - 55)
                        
                        currentSliderProgreess = progress

                        
                        
                    })
                
                )
                
                
            }
            
               
        }
     // .frame(maxWidth:.infinity,maxHeight: .infinity)
        .padding()
        .overlay(alignment: .topTrailing, content: {
            
            Button {
                
            } label: {
                
                Image(systemName: "xmark")
                    .font(.title)
                    .foregroundColor(.orange)
                    .padding()
                    .background(.white,in: Circle())
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 5, y: 5)
            }
            .padding(.trailing,10)

            
        })
        
        .background(
        
            LinearGradient(colors: [
            
            Color("BG1"),
            Color("BG2"),
            Color("BG3"),
            
            
            ], startPoint: .top, endPoint: .bottom)
        
        
        )
    }
    
    func getAttributed(string : String)->AttributedString{
        
        var str = AttributedString(string)
        
        if let range = str.range(of: "Food?"){
            
            str[range].foregroundColor = .white
            str[range].font = .title3.weight(.black)
        }
        
        return str
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
