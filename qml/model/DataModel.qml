import QtQuick 2.0

Item{
   readonly property bool userLoggedIn: _.userLoggedIn

   // property to configure target dispatcher / logic
  property alias dispatcher: logicConnection.target

   // listen to actions from dispatcher
   Connections {
     id: logicConnection
     // action 1 - login
     onLogin: _.userLoggedIn = true

     // action 2 - logout
     onLogout: _.userLoggedIn = false


   }
// private
Item {
  id: _

  // data properties
  //property var todos: []  // Array
  //property var todoDetails: ({}) // Map

  // auth
  property bool userLoggedIn: false

}
}
