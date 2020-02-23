import QtQuick 2.0
import Felgo 3.0
import QtQuick.Layouts 1.3
import QtQuick.LocalStorage 2.12
import Qt.labs.settings 1.1
import "../DbManager.js" as Store
/*

// EXAMPLE USAGE:
// add the following piece of code inside your App { } to display the List Page

Material {

}

*/

Page {

    title: qsTr("Stock")
    signal update
    // show error if too long
       AppText {
           id:errorShow
         text: "Error: Check your input"
         color: "red"

         anchors.topMargin: dp(16)

         visible: false
       }
       Settings{
           id:setting
           property var idText: 0
       }


   ColumnLayout{
       anchors.rightMargin: dp(5)
       anchors.leftMargin: dp(5)
       anchors.bottomMargin: dp(5)
       anchors.topMargin: dp(5)
       anchors.fill: parent
       spacing: dp(10)
       ColumnLayout {
           id: rowLayout
           Layout.fillHeight: true
           Layout.fillWidth: true
           Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

       Row{
           Layout.fillWidth: true
           Layout.fillHeight: true
           Layout.preferredHeight: dp(18)
       AppCard{
           id:card
           content: AppText{
               text: qsTr("IN")
               anchors.horizontalCenter: parent.horizontalCenter
               color: "#0510b6"
               padding: dp(10)
               font.pixelSize: sp(16)
               font.family: "Verdana"
           }
       }
       }
       Row{
           Layout.fillHeight: true
           Layout.fillWidth: true
           Layout.preferredHeight: dp(20)
           AppPaper {
               anchors.centerIn: parent
                  width:dp(300)
                  height: parent.height
                  shadowColor: "#5c76f4"

                  AppText{
                         id: textId
                         text: setting.idText
                         width: dp(200)
                         color: "#0510b6"
                         font.pixelSize: sp(14)
                         font.family: "Verdana"
                         padding: dp(10)
                         anchors.centerIn: parent
                       }
                }
       }

       Row{
           Layout.fillHeight: true
           Layout.fillWidth: true
           Layout.preferredHeight: dp(20)
           AppPaper {
                  anchors.centerIn: parent
                  width:dp(300)
                  height: parent.height
                  shadowColor: "#5c76f4"

                  AppTextInput {
                         id: textName
                         width: dp(200)
                         color: "#0510b6"
                         placeholderText: "What's your product name?"
                         font.pixelSize: sp(14)
                         font.family: "Verdana"
                         anchors.centerIn: parent
                         validator: RegExpValidator {
                                regExp: /[A-Za-z]+/
                              }
                       }
                }
       }
       Row{
           Layout.fillHeight: true
           Layout.fillWidth: true
           Layout.preferredHeight: dp(20)
           AppPaper {
                  anchors.centerIn: parent
                  width:dp(300)
                  shadowColor: "#5c76f4"
                  height: parent.height

                  AppTextInput {
                         id: textPrice
                         width: dp(200)
                         color: "#0510b6"
                         inputMask: qsTr("")
                         selectionColor: "#7f7feb"
                         placeholderText: "What's the price?"
                         font.pixelSize: sp(14)
                         font.family: "Verdana"
                         anchors.centerIn: parent
                         validator: IntValidator{
                             bottom: 0
                             top:5000
                         }
                       }
                }
       }
       Row{
           Layout.fillWidth: true
           Layout.fillHeight: true
           Layout.preferredHeight: dp(18)

           AppButton{
               id:but1
               width: parent.width
               icon: IconType.plus
               onClicked: {
                   if(textPrice.text == "" | textName.text == ""){
                       //NativeUtils.vibrate()
                       backgroundColor = "red"
                   }else{
                       backgroundColor = "blue"
                       Store.dbStockInit();
                       if(textId.text === 0){
                           setting.setValue(idText,1);
                       }else{

                       var db =Store.dbStockInsert(textId.text,textName.text,textPrice.text)
                       console.log("Inserting in stock: " + db);
                       textName.text="";textPrice.text=""
                       var id = Store.dbReadStockAll();
                       setting.idText = db;
                       textPrice.text == ""
                       textName.text == ""
                           update()
                       }
                   }
               }

           }
       }
       Row{
           Layout.fillWidth: true
           Layout.fillHeight: true
           Layout.preferredHeight: dp(18)
       AppCard{
           id:cardq
           content: AppText{
               color: "#0510b6"
               padding: dp(10)
               text: qsTr("Out")
               anchors.horizontalCenter: parent.horizontalCenter
               font.pixelSize: sp(16)
               font.family: "Verdana"

           }

       }
       }
       Row{
           Layout.fillHeight: true
           Layout.fillWidth: true
           Layout.preferredHeight: dp(20)
           AppPaper {
                  anchors.centerIn: parent
                  width:dp(300)
                  shadowColor: "#5c76f4"
                  height: parent.height

                  AppTextInput{
                         id: textOutId
                         width: dp(200)
                         placeholderText: "ID to be deleted"
                         color: "#0510b6"                         
                         anchors.centerIn: parent
                         font.family: "Verdana"
                       }
                }
       }

       Row{
           Layout.fillHeight: true
           Layout.fillWidth: true
           Layout.preferredHeight: dp(20)
           AppPaper {
                  anchors.centerIn: parent
                  width:dp(300)
                  shadowColor: "#5c76f4"
                  height: parent.height

                  AppTextInput {
                         id: textOutName
                         width: dp(200)
                         color: "#0510b6"
                         placeholderText: "What's your product name?"
                         anchors.centerIn: parent
                         validator: RegExpValidator {
                                regExp: /[A-Za-z]+/
                              }

                       }
                }
       }
       Row{
           Layout.fillHeight: true
           Layout.preferredHeight: dp(20)

           Layout.fillWidth: true
           AppPaper {
                  anchors.centerIn: parent
                 width:dp(300)
                  shadowColor: "#5c76f4"
                  height: parent.height

                  AppTextInput {
                         id: textOutPrice
                         width: dp(200)
                         color: "#0510b6"
                         placeholderText: "What's the price?"
                         anchors.centerIn: parent
                         validator:IntValidator{
                                        bottom: 0
                                        top:5000
                                    }
                       }

                }
       }
       Row{
           Layout.fillWidth: true
           Layout.fillHeight: true
           Layout.preferredHeight: dp(18)

           AppButton{
               id:but2
               width: parent.width
               icon: IconType.plus
               onClicked: {
                   if(textOutPrice.text == "" | textOutName.text == "" | textOutId.text==""){
                       backgroundColor = "red"
                   }else{
                       var db = Store.dbReadStockAll();
                       if(db.rows.length > textOutId.id){
                       backgroundColor = "red"
                       }else{
                       but2.backgroundColor = "blue"
                       Store.dbStockInit();
                       Store.dbStockOutInit()
                       Store.dbStockInsertOut(textOutId.text,textOutName.text,textOutPrice.text)
                       Store.dbDeleteStock(textOutId.text)
                       textOutPrice.text == "";
                       textOutName.text == "";
                       textOutId.text=="";
                       update()
                       }
                   }
               }
           }
       }
   }

   }

}
