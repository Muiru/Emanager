import QtQuick 2.0
import Felgo 3.0
import QtQuick.Layouts 1.1

Page {

    title: "New Page"
    id:register
     backgroundColor: Qt.rgba(5,9,10, 0.80)
    Rectangle {
        id: loginForm
        anchors.centerIn: parent
        color: "#FF8C3BA8"
        width: content.width + dp(80)
        height: content.height + dp(25)
        radius: dp(4)
    }
    GridLayout{
        id: content
        anchors.centerIn: loginForm
        columnSpacing: dp(20)
        rowSpacing: dp(10)
        columns: 2

        // headline
        AppText {
            Layout.topMargin: dp(8)
            Layout.bottomMargin: dp(12)
            Layout.columnSpan: 2
            Layout.alignment: Qt.AlignHCenter
            text: "Login"
        }

        // email text and field
        AppText {
            text: qsTr("E-mail")
            font.pixelSize: sp(12)
        }

        AppTextField {
            id: txtUsername
            Layout.preferredWidth: dp(200)
            showClearButton: true
            font.pixelSize: sp(14)
            borderColor: Theme.tintColor
            borderWidth: !Theme.isAndroid ? dp(2) : 0
        }

        // password text and field
        AppText {
            text: qsTr("Password")
            font.pixelSize: sp(12)
        }

        AppTextField {
            id: txtPassword
            Layout.preferredWidth: dp(200)
            showClearButton: true
            font.pixelSize: sp(14)
            borderColor: Theme.tintColor
            borderWidth: !Theme.isAndroid ? dp(2) : 0
            echoMode: TextInput.Password
        }

        Column {
            Layout.fillWidth: true
            Layout.columnSpan: 2
            Layout.topMargin: dp(12)

            // buttons
            AppButton {
                text: qsTr("Login")
                flat: false
                icon: IconType.backward
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    loginPage.visible = true
                    loginPage.forceActiveFocus() // move focus away from text fields

                    // simulate successful login
                    console.debug("logging in ...")
                    register.visible = false
                    register.opacity = 0

                    //logic.login(txtUsername.text, txtPassword.text)
                    //loginSucceeded()
                }
            }

            AppButton {
                text: qsTr("Save")
                flat: true
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    logic.login(txtUsername.text, txtPassword.text)// call your server code to register here
                    console.debug("registering...")
                }
            }
        }
    }

}
