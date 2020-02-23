import QtQuick 2.0
import Felgo 3.0
import QtQuick.LocalStorage 2.12
import "../DbManager.js" as Store
import "../logic"
/*

// EXAMPLE USAGE:
// add the following piece of code inside your App { } to display the List Page

Summary {

}

*/

ListPage {
    id: listPage
    title: qsTr("Summary")
    signal logoutClicked
    signal dataChanged
    rightBarItem:NavigationBarRow {
        ActivityIndicatorBarItem{
            id:activity
            visible: false
        }
    }


    Item{
        visible: false
        WorkersPage{

            onDataEnter: {
                dataList = []
                Store.display();
                activity.visible = false
            }
        }
    Material{

        onUpdate: {
            dataList = []
            Store.display()
            activity.visible = false
        }
    }}

    property var dataList:[]
    //onActiveFocusChanged:  {Store.display()}

    onAppeared: {
        dataList = []
        Store.display()
    activity.visible = false}
    model:dataList
    //onPushed: Store.display();
    //Component.onCompleted: {Store.display();}

    emptyText.text: qsTr("No data available")
    // TODO add your model
    delegate: SimpleRow{}
    section.property: "type"
    AppButton {
        text: qsTr("Logout")
        anchors.bottom: parent.bottom
        anchors.bottomMargin: dp(10)
        onClicked: logoutClicked()

    }

}
