import QtQuick 2.2
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.5

Page {
    id: locationPage

    property bool largeScreen: Screen.sizeCategory === Screen.Large
                               || Screen.sizeCategory === Screen.ExtraLarge
    property string latitude: "Unknown"
    property string longitude: "Unknown"
    property string timezone: "Unknown"
    property string continent_code: "Unknown"
    property string country_code: "Unknown"
    property string country_name: "Unknown"
    property string city: "Unknown"
    property string postal_code: "Unknown"
    property string isp: "Unknown"
    property string host: "Unknown"
    property string rdns: "Unknown"

    Python {
        id: python

        Component.onCompleted: {
            scanningIndicator.running = true
            addImportPath(Qt.resolvedUrl('.'))
            importModule('call_location', function () {
                console.log('call_location module is now imported')
            })

            call('call_location.get_geolocation', [], function (result) {
                // console.log(result)
                latitude = result["latitude"]
                longitude = result["longitude"]
                timezone = result["timezone"]
                continent_code = result["continent_code"]
                country_code = result["country_code"]
                country_name = result["country_name"]
                city = result["city"]
                postal_code = result["postal_code"]
                isp = result["isp"]
                host = result["host"]
                rdns = result["rdns"]
                scanningIndicator.running = false
            })
        }

        onError: {
            console.log('Python ERROR: ' + traceback)
            Clipboard.text = traceback
        }
    }
    Item {
        id: busy
        anchors.fill: parent
        Label {
            id: busyLabel
            anchors.bottom: scanningIndicator.top
            color: Theme.highlightColor
            font.pixelSize: Theme.fontSizeLarge
            height: Theme.itemSizeLarge
            horizontalAlignment: Text.AlignHCenter
            text: qsTr("Retrieving IP location info")
            verticalAlignment: Text.AlignVCenter
            visible: scanningIndicator.running
            width: parent.width
        }
        BusyIndicator {
            id: scanningIndicator
            anchors {
                centerIn: parent
            }
            running: false
            size: BusyIndicatorSize.Large
        }
    }

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent
        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        VerticalScrollDecorator {
        }

        Column {
            id: column

            width: locationPage.width
            spacing: largeScreen ? 50 : 7

            PageHeader {
                title: qsTr("IP location info")
            }
            Rectangle {
                height: Theme.paddingLarge
                width: Theme.paddingLarge
                color: "transparent"
            }
            IconButton {
                anchors.horizontalCenter: parent.horizontalCenter
                icon.source: "image://theme/icon-m-location"
                // text: qsTr("View on OpenStreetMap")
                onClicked: {
                    var openstreetmapURL = 'https://www.openstreetmap.org/?mlat='
                            + latitude + '&mlon=' + longitude + '&zoom=12'
                    Qt.openUrlExternally(openstreetmapURL)
                }
                visible: !scanningIndicator.running
            }
            Row {
                width: parent.width
                spacing: Theme.paddingSmall

                Label {
                    width: parent.width * 0.5
                    text: qsTr("External IP")
                    visible: !scanningIndicator.running
                    horizontalAlignment: Text.AlignRight
                    color: Theme.primaryColor
                    font.pixelSize: Theme.fontSizeSmall
                    wrapMode: Text.Wrap
                }

                Label {
                    width: parent.width * 0.5
                    text: host
                    visible: !scanningIndicator.running
                    color: Theme.highlightColor
                    font.pixelSize: Theme.fontSizeSmall
                    wrapMode: Text.Wrap
                }
            }
            Row {
                width: parent.width
                spacing: Theme.paddingSmall

                Label {
                    width: parent.width * 0.5
                    text: qsTr("Timezone")
                    visible: !scanningIndicator.running
                    horizontalAlignment: Text.AlignRight
                    color: Theme.primaryColor
                    font.pixelSize: Theme.fontSizeSmall
                    wrapMode: Text.Wrap
                }

                Label {
                    width: parent.width * 0.5
                    text: timezone
                    visible: !scanningIndicator.running
                    color: Theme.highlightColor
                    font.pixelSize: Theme.fontSizeSmall
                    wrapMode: Text.Wrap
                }
            }
            Row {
                width: parent.width
                spacing: Theme.paddingSmall

                Label {
                    width: parent.width * 0.5
                    text: qsTr("Country")
                    visible: !scanningIndicator.running
                    horizontalAlignment: Text.AlignRight
                    color: Theme.primaryColor
                    font.pixelSize: Theme.fontSizeSmall
                    wrapMode: Text.Wrap
                }

                Label {
                    width: parent.width * 0.5
                    text: country_name + " (" + continent_code + "/" + country_code + ")"
                    visible: !scanningIndicator.running
                    color: Theme.highlightColor
                    font.pixelSize: Theme.fontSizeSmall
                    wrapMode: Text.Wrap
                }
            }
            Row {
                width: parent.width
                spacing: Theme.paddingSmall

                Label {
                    width: parent.width * 0.5
                    text: qsTr("City")
                    visible: !scanningIndicator.running
                    horizontalAlignment: Text.AlignRight
                    color: Theme.primaryColor
                    font.pixelSize: Theme.fontSizeSmall
                    wrapMode: Text.Wrap
                }

                Label {
                    width: parent.width * 0.5
                    text: city + " (" + postal_code + ")"
                    visible: !scanningIndicator.running
                    color: Theme.highlightColor
                    font.pixelSize: Theme.fontSizeSmall
                    wrapMode: Text.Wrap
                }
            }
            Row {
                width: parent.width
                spacing: Theme.paddingSmall

                Label {
                    width: parent.width * 0.5
                    text: qsTr("ISP")
                    visible: !scanningIndicator.running
                    horizontalAlignment: Text.AlignRight
                    color: Theme.primaryColor
                    font.pixelSize: Theme.fontSizeSmall
                    wrapMode: Text.Wrap
                }

                Label {
                    width: parent.width * 0.5
                    text: isp
                    visible: !scanningIndicator.running
                    color: Theme.highlightColor
                    font.pixelSize: Theme.fontSizeSmall
                    wrapMode: Text.Wrap
                }
            }
            Row {
                width: parent.width
                spacing: Theme.paddingSmall

                Label {
                    width: parent.width * 0.5
                    text: qsTr("rDNS")
                    visible: !scanningIndicator.running
                    horizontalAlignment: Text.AlignRight
                    color: Theme.primaryColor
                    font.pixelSize: Theme.fontSizeSmall
                    wrapMode: Text.Wrap
                }

                Label {
                    width: parent.width * 0.5 - Theme.paddingMedium
                    text: rdns
                    visible: !scanningIndicator.running
                    color: Theme.highlightColor
                    font.pixelSize: Theme.fontSizeSmall
                    wrapMode: Text.Wrap
                }
            }
        }
    }
}
