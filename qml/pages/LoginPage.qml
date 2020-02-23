import QtQuick 2.0
import QtQuick.Layouts 1.1
import Felgo 3.0

/*

// EXAMPLE USAGE:
// add the following piece of code inside your App { } to display the Login Page

// property to store whether user is logged
property bool userLoggedIn: false

// login page is always visible if user is not logged in
LoginPage {
  z: 1 // show login above actual app pages
  visible: opacity > 0
  enabled: visible
  opacity: userLoggedIn ? 0 : 1 // hide if user is logged in
  onLoginSucceeded: userLoggedIn = true

  Behavior on opacity { NumberAnimation { duration: 250 } } // page fade in/out
}

*/

Page {
    id: loginPage
    title: "Login"
    //signal loginSucceeded

    RegisterPage{
        id:registerNow
        visible: false
        enabled: false
        opacity: 0
        Behavior on visible {NumberAnimation {duration : 259}}
    }

    backgroundColor: Qt.rgba(0,0,0, 0.75) // page background is translucent, we can see other items beneath the page

    // login form background
    Rectangle {
        id: loginForm
        anchors.centerIn: parent
        color: "#FF8C3BA8"
        width: content.width + dp(48)
        height: content.height + dp(16)
        radius: dp(4)
    }

    // login form content
    GridLayout {
        id: content
        anchors.centerIn: loginForm
        columnSpacing: dp(20)
        rowSpacing: dp(10)
        columns: 2

        // headline
        AppText {
            color: "#0510b6"
            Layout.topMargin: dp(8)
            Layout.bottomMargin: dp(12)
            Layout.columnSpan: 2
            Layout.alignment: Qt.AlignHCenter
            text: "Login"
            style: Text.Sunken
            font.weight: Font.ExtraBold
            font.capitalization: Font.AllUppercase
            font.pixelSize: sp(15)
            font.bold: true
            font.family: "Tahoma"
        }

        // email text and field
        AppText {
            color: "#0510b6"
            text: qsTr("E-mail")
            font.pixelSize: sp(15)
            style: Text.Sunken
            font.weight: Font.ExtraBold
            font.capitalization: Font.AllUppercase
            font.bold: true
            font.family: "Tahoma"            
        }

        AppTextField {
            id: txtUsername
            Layout.preferredWidth: dp(200)
            showClearButton: true
            font.weight: Font.ExtraBold
            font.pixelSize: sp(14)
            borderColor: Theme.tintColor
            color: "#0510b6"
            borderWidth: !Theme.isAndroid ? dp(2) : 0
            validator: RegExpValidator {
                   regExp: /[A-Za-z]+/
                 }
        }

        // password text and field
        AppText {
            text: qsTr("Password")
            color: "#0510b6"
            font.pixelSize: sp(15)
            style: Text.Sunken
            font.weight: Font.ExtraBold
            font.capitalization: Font.AllUppercase
            font.bold: true
            font.family: "Tahoma"
        }

        AppTextField {
            id: txtPassword
            Layout.preferredWidth: dp(200)
            showClearButton: true
            font.pixelSize: sp(14)
            borderColor: Theme.tintColor
            font.weight: Font.ExtraBold
            color: "#0510b6"
            borderWidth: !Theme.isAndroid ? dp(2) : 0
            echoMode: TextInput.Password
        }

        // column for buttons, we use column here to avoid additional spacing between buttons
        Column {
            Layout.fillHeight: false
            Layout.fillWidth: true
            Layout.columnSpan: 2
            Layout.topMargin: dp(12)

            // buttons
            AppButton {
                text: qsTr("Login")
                flat: false
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    loginPage.forceActiveFocus() // move focus away from text fields

                    // simulate successful login
                    console.debug("logging in ...")
                    logic.login(txtUsername.text, txtPassword.text)
                    //loginSucceeded()
                }
            }

            AppButton {
                text: qsTr("No account yet? Register now")
                flat: true
                icon: IconType.forward
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {

                    registerNow.visible = true
                    registerNow.enabled = true
                    registerNow.z = 1
                    registerNow.opacity = 1
                    registerNow.forceActiveFocus()
                    loginPage.forceActiveFocus() // move focus away from text fields
                    //loginPage.visible = false
                    loginPage.z = 0

                    // call your server code to register here
                    console.debug("registering...")
                }
            }
        }
    }
}
