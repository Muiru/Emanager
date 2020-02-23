import QtQuick 2.0
import Felgo 3.0
import QtQuick.LocalStorage 2.12
import "../DbManager.js" as Store

/*

// EXAMPLE USAGE:
// add this piece of code to your App or NavigationStack to display the Tabbed Page

WorkersPage {
  id: tabbedPage
}

*/
import QtQuick.Layouts 1.3

Page {
    id: page
    title: qsTr("Employee")
    property var noww:new Date()
    signal dataEnter
    AppText {
      id:errorShow
      z:1
      text: "Error: Check your input"
      color: "red"
      visible: false

    }

    GridLayout {
        id: gridLayout
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.bottomMargin: 5
        anchors.topMargin: 5
        anchors.fill: parent

        ColumnLayout {
            id: rowLayout
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            Column{
                id: columnLayout
                Layout.fillHeight: true
                Layout.fillWidth: true

                AppPaper {
                       anchors.centerIn: parent
                       width:dp(300)
                       height: parent.height
                       shadowColor: "#5c76f4"

                       AppTextInput {
                              id: textEdit
                              width: dp(200)
                              placeholderText: "What's your name?"
                              color: "#0510b6"
                              font.pixelSize: sp(14)
                              font.family: "Verdana"
                              anchors.centerIn: parent
                              Keys.onEnterPressed: {
                                  console.log("focus")
                                 forceActiveFocus();
                              }
                            }
                     }
            }

            Column{
                id: titLe
                //width: 100
                //height: 100
                Layout.fillHeight: true
                Layout.fillWidth: true

                AppPaper {
                       anchors.centerIn: parent
                       width:dp(300)
                       height: parent.height
                       shadowColor: "#5c76f4"

                       AppTextInput {
                              id: textTitle
                              width: dp(200)
                              placeholderText: "What's your job title?"
                              color: "#0510b6"
                              font.pixelSize: sp(14)
                              font.family: "Verdana"
                              anchors.centerIn: parent
                              Keys.onEnterPressed: {
                                  console.log("focus")
                                 forceActiveFocus();
                              }
                            }
                     }
            }
            Column{
                id: columnDate
                //width: 100
               // height: 100
                Layout.fillHeight: true
                Layout.fillWidth: true

                AppPaper {
                       anchors.centerIn: parent
                       width:dp(300)
                       height: parent.height
                       shadowColor: "#5c76f4"

                       AppText{
                              id: textDate
                              width: dp(200)
                              text:noww.toLocaleString()
                              color: "#0510b6"
                              font.pixelSize: sp(14)
                              font.family: "Verdana"
                              padding: dp(10)
                              anchors.centerIn: parent
                              Keys.onEnterPressed: {
                                  console.log("focus")
                                 forceActiveFocus();
                              }
                            }
                     }
            }
            Column{
                id: columnSalary
                //width: 100
                //height: 100
                Layout.fillHeight: true
                Layout.fillWidth: true
                spacing: dp(5)
                AppPaper {
                       anchors.centerIn: parent
                       width: dp(300)
                       height: parent.height
                       shadowColor: "#5c76f4"

                       AppTextInput {
                              id: textSalary
                              width: dp(200)
                              placeholderText: "What's your Salary?"
                              color: "#0510b6"
                              font.pixelSize: sp(14)
                              validator: IntValidator{
                                  bottom: 0
                                  top:50000
                              }
                              font.family: "Verdana"
                              anchors.centerIn: parent
                              Keys.onEnterPressed: {
                                  console.log("focus")
                                 forceActiveFocus();
                              }
                            }

                     }
            }
            Row{
                Layout.fillWidth: true
                AppButton{
                    width: parent.width
                    icon: IconType.plus

                    onClicked: {
                        textDate.text = new Date().toLocaleString()
                        errorShow.visible = false
                        if(textEdit.text == "" | textTitle.text == "" | textSalary.text == "" )
                        {
                            var man = new Date().getSeconds();
                            backgroundColor ="red"
                            NativeUtils.displayAlertDialog("Error","No data Entered","OK","Re-enter")

                        }else{
                            backgroundColor ="blue"
                            Store.dbPeopleInit();
                            var db = Store.dbPeopleInsert(textEdit.text,textTitle.text,textDate.text,textSalary.text);
                            //NativeUtils.displayAlertSheet("Updated")
                           dataEnter();
                            console.log("db: " + db);
                            textEdit.text = ""
                            textTitle.text = ""
                            textSalary.text = ""
                        }
                    }
                }
            }
        }

    }
}
