# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-infraview

TEMPLATE = subdirs
SUBDIRS = src/infraview-helper src
DEPLOYMENT_PATH = /usr/share/$${TARGET}

translations.path = $${DEPLOYMENT_PATH}

CONFIG += sailfishapp

SOURCES += src/infraview.cpp \
    src/osread.cpp

OTHER_FILES += qml/infraview.qml \
    qml/cover/CoverPage.qml \
    qml/pages/MainPage.qml \
    qml/pages/LocationInfo.qml \
    qml/pages/DeviceList.qml \
    qml/pages/Arp.qml \
    qml/pages/DeviceInfo.qml \
    qml/pages/About.qml \
    qml/pages/call_arp.py \
    qml/pages/call_location.py \
    qml/pages/call_nmap.py \
    qml/pages/call_netstat.py \
    qml/pages/call_ip.py \
    qml/pages/NetstatInfo.qml \
    qml/pages/Netstat.qml \
    qml/pages/ConnmanInfo.qml \
    qml/pages/ConnmanNetServices.qml \
    qml/pages/call_connman.py \
    qml/pages/get_ip_address.sh \
    qml/pages/ToolPage.qml \
    qml/pages/DnsPage.qml \
    qml/pages/TraceroutePage.qml \
    qml/pages/PingPage.qml \
    python/netstat.py \
    python/nmap.py \
    rpm/infraview.spec \
    rpm/infraview.changes \
    translations/*.ts \
    harbour-infraview.desktop \

HEADERS += \
    src/osread.h

icon86.files += icons/86x86/harbour-infraview.png
icon86.path = /usr/share/icons/hicolor/86x86/apps

icon108.files += icons/108x108/harbour-infraview.png
icon108.path = /usr/share/icons/hicolor/108x108/apps

icon128.files += icons/128x128/harbour-infraview.png
icon128.path = /usr/share/icons/hicolor/128x128/apps

icon172.files += icons/172x172/harbour-infraview.png
icon172.path = /usr/share/icons/hicolor/172x172/apps

icon256.files += icons/256x256/harbour-infraview.png
icon256.path = /usr/share/icons/hicolor/256x256/apps

script.files = helper/*
script.path = /usr/share/harbour-infraview/helper

python.files = python/*
python.path = /usr/share/harbour-infraview/python

TRANSLATIONS = translations/harbour-infraview-es.ts \
               translations/harbour-infraview-sv.ts \
               translations/harbour-infraview-ru.ts \
               translations/harbour-infraview-zh_CN.ts \
               translations/harbour-infraview-nl.ts

INSTALLS += icon86 icon108 icon128 icon172 icon256 translations script python translations

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n


# only include these files for translation:
lupdate_only {
    SOURCES = qml/*.qml \
              qml/cover/*.qml \
              qml/pages/*.qml
}
