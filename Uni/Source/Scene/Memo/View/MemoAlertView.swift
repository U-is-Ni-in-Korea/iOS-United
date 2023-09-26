//
//  CustomAlertView.swift
//  MemoFeatureTestForSparkleApp
//
//  Created by 부창현 on 2023/09/16.
//

import SwiftUI
import SDSKit

class mySIngleton {
    static let shared = mySIngleton()
    private init() {}
}

enum ClickedButton{
    case 취소
    case 나가기
    case none
}
struct CustomAlertView: View {
    
    @Binding var Shown: Bool
    @Binding var buttonClicked: ClickedButton
    @State private var isPresented = false
    
    var body: some View {
        
        ZStack{
           Rectangle()
              .ignoresSafeArea()
                .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.0, opacity: 0.4))
        VStack(spacing: 0){
            VStack{
                
                Text("메모장을 나가시나요?")
                    .font(Font(SDSFont.subTitle.font))
                    .foregroundColor(Color(uiColor: .gray600))
                    .padding(.top, 24)
                    .frame(width: 223, height: 24)
                Text("승부가 끝나기 전에는 내용이 남아있지만")
                    .font(Font(SDSFont.body2Long.font))
                    .foregroundColor(Color(uiColor: .gray400))
                    .padding(.top, 8)
                Text("앱을 종료하면 내용이 사라질 수 있어요")
                    .font(Font(SDSFont.body2Long.font))
                    .foregroundColor(Color(uiColor: .gray400))
                //여기 텍스트 두개로 분리해야 할 듯
                //  .frame(width: 223, height: 40)
                //  .padding(.top, 4)
            }.frame(width: 271, height: 116)
            
            
            Divider()
                .frame(width: 271, height: 1)
                .foregroundColor(Color(uiColor: .gray200))
            
            
            HStack(spacing: 0){
                //오예, 이거 프레임 사이 간격 벌어지는거->프레임이나 디바이더 문제가 아니라 스택 자체 스페이싱 문제
                
                Button("취소") {
                    Shown.toggle()
                    buttonClicked = .취소
                }
                
                .frame(width: 135, height: 52, alignment: .center)
                .foregroundColor(Color(uiColor: .lightBlue600))
                .font(Font(SDSFont.body1Regular.font))
                //이거 폰트를 모르겠음
                
                
                //여기 수정했음
                Divider()
                    .frame(width: 1, height: 52)
                    .foregroundColor(Color(uiColor: .gray200))
                
                
                
                Button("나가기"){
                    Shown.toggle()
                    buttonClicked = .나가기
                    //여기에 네비게이션 링크를 어떻게 넣을지 생각해 보자
                
                }
                .frame(width: 135, height: 52, alignment: .center)
                .foregroundColor(Color(uiColor: .lightBlue600))
                .font(Font(SDSFont.subTitle.font))
                //여기 수정했음
            }
            .frame(height: 51)
            
            
        }   .frame(width: 271, height: 168)
            .background(Color.white)
            .cornerRadius(10)
            .clipped()
            .shadow(radius:3)
        //shadow x=2, blur=3/262626 10%
        
        
        
    }
    }
}

struct CustomAlertView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlertView(Shown: .constant(false), buttonClicked: .constant(.none))
    }
}
