import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Server")

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
            validator: RegularExpressionValidator {
                regularExpression: /^([01]?[0-9]?[0-9]|2([0-4][0-9]|5[0-5]))$/
            }

            background: Rectangle {
                color: parent.palette.dark
            }
        }

        Label {
            text: "."
        }

        TextField {
            id: ipTextInput2
            text: "0"
            overwriteMode: true
            validator: RegularExpressionValidator {
                regularExpression: /^([01]?[0-9]?[0-9]|2([0-4][0-9]|5[0-5]))$/
            }

            background: Rectangle {
                color: parent.palette.dark
            }
        }

        Label {
            text: "."
        }

        TextField {
            id: ipTextInput3
            text: "0"
            overwriteMode: true
            validator: RegularExpressionValidator {
                regularExpression: /^([01]?[0-9]?[0-9]|2([0-4][0-9]|5[0-5]))$/
            }

            background: Rectangle {
                color: parent.palette.dark
            }
        }

        Label {
            text: "."
        }

        TextField {
            id: ipTextInput4
            text: "1"
            overwriteMode: true
            validator: RegularExpressionValidator {
                regularExpression: /^([01]?[0-9]?[0-9]|2([0-4][0-9]|5[0-5]))$/
            }

            background: Rectangle {
                color: parent.palette.dark
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
                validator: RegularExpressionValidator {
                    regularExpression: /^([01]?[0-9]?[0-9]|2([0-4][0-9]|5[0-5]))$/
                }

                background: Rectangle {
                    color: parent.palette.dark
                }
            }
        }
    }

    Image {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: ipAddressRow.bottom
        anchors.bottom: controlsRow.top
        id: imageView
        fillMode: Image.PreserveAspectFit
        source: ""
        cache: false

        Connections {
            target: img_srv
            function onImageUpdated() {
                imageView.source = imageView.source.toString() === "image://server_provider/first" ? "image://server_provider/second" : "image://server_provider/first"
            }
        }
    }

    RowLayout {
        id: controlsRow
        anchors.left: parent.left
        anchors.right: statusContainer.left
        anchors.bottom: parent.bottom

        Button {
            id: startButton
            text: qsTr("Start")
            onClicked: {
                var s = ipTextInput1.text+"."+ipTextInput2.text+"."+ipTextInput3.text+"."+ipTextInput4.text
                img_srv.startListening(s, portTextInput.text)
            }
        }

        Button {
            id: stopButton
            text: qsTr("Stop")
            onClicked: {
                img_srv.stopListening()
            }
        }
    }

    Item {
        id: statusContainer
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        implicitWidth: statusLabel.implicitWidth + statusLabel.height
        implicitHeight: statusLabel.implicitHeight
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
                target: img_srv

                function onWaiting() {
                    statusDiode.color = "yellow"
                }

                function onConnected() {
                    statusDiode.color = "green"
                }

                function onStopped() {
                    statusDiode.color = "red"
                }
            }
        }

    }
}
