import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2

Window {
    width: 640
    height: ipAddressRow.implicitHeight + controlsRow.implicitHeight
    visible: true
    title: qsTr("Client")

    SystemPalette { id: mainPalette; colorGroup: SystemPalette.Active }

    FileDialog {
        id: fileDialog
        onAccepted: {
            img_clnt.sendImage(fileDialog.fileUrl)
        }
    }

    RowLayout {
        id: ipAddressRow
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        Label {
            id: ipLabel
            text: qsTr("IP:")
        }

        TextField {
            id: ipTextInput1
            text: "127"
            overwriteMode: true

            background: Rectangle {
                color: mainPalette.dark
            }
        }

        Label {
            text: "."
        }

        TextField {
            id: ipTextInput2
            text: "0"
            overwriteMode: true

            background: Rectangle {
                color: mainPalette.dark
            }
        }

        Label {
            text: "."
        }

        TextField {
            id: ipTextInput3
            text: "0"
            overwriteMode: true

            background: Rectangle {
                color: mainPalette.dark
            }
        }

        Label {
            text: "."
        }

        TextField {
            id: ipTextInput4
            text: "1"
            overwriteMode: true

            background: Rectangle {
                color: mainPalette.dark
            }
        }
        Item {
            id: separatorItem
            Layout.fillWidth: true
            implicitHeight: 1
        }

        Item {
            id: portContainer
            implicitHeight: portTextInput.implicitHeight
            implicitWidth: portLabel.implicitWidth + portTextInput.implicitWidth+20
            Label {
                id: portLabel
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                text: qsTr("Port:")
            }

            TextField {
                id: portTextInput
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                text: "13500"
                overwriteMode: true

                background: Rectangle {
                    color: mainPalette.dark
                }
            }
        }
    }

    RowLayout {
        id: controlsRow
        anchors.left: parent.left
        anchors.right: statusContainer.left
        anchors.bottom: parent.bottom
        anchors.top: ipAddressRow.bottom

        Button {
            id: connectButton
            text: qsTr("Connect")

            onClicked: {
                var s = ipTextInput1.text+"."+ipTextInput2.text+"."+ipTextInput3.text+"."+ipTextInput4.text
                img_clnt.connectToServer(s, portTextInput.text)
            }
        }

        Button {
            id: sendButton
            text: qsTr("Send")

            onClicked: fileDialog.open()
        }

        Button {
            id: disconnectButton
            text: qsTr("Disconnect")

            onClicked: img_clnt.disconnect()
        }

    }

    Item {
        id: statusContainer
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: ipAddressRow.bottom
        implicitWidth: statusLabel.implicitWidth + statusLabel.height
        implicitHeight: statusLabel.height
        Label {
            id: statusLabel
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr("Status:")
        }

        Rectangle {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            id: statusDiode
            radius: width / 2
            width: statusLabel.height / 2
            height: statusLabel.height / 2
            color: "red"

            Connections {
                target: img_clnt

                onDisconnected: {
                    statusDiode.color = "red"
                }

                onConnected: {
                    statusDiode.color = "green"
                }
            }
        }

    }
}
