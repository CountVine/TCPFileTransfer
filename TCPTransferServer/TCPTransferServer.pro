QT += quick network gui

SOURCES += \
        main.cpp \
        server.cpp \
        serverimageprovider.cpp

resources.files = main.qml 
resources.prefix = /$${TARGET}
RESOURCES += resources

TRANSLATIONS += \
    TCPTransferServer_ru_RU.ts
CONFIG += lrelease
CONFIG += embed_translations

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    server.h \
    serverimageprovider.h

DISTFILES += \
    main.qml
