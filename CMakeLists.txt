cmake_minimum_required(VERSION 3.16)

project(WH VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(QML_IMPORT_PATH ${CMAKE_SOURCE_DIR}/qml ${CMAKE_BINARY_DIR}/imports CACHE STRING "" FORCE)
find_package(Qt6 REQUIRED COMPONENTS Quick Gui QuickControls2 Charts)
find_package(Qt6 REQUIRED COMPONENTS Widgets)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appWH
    main.cpp
)

qt_add_qml_module(appWH
    URI WH
    QML_FILES
        Main.qml
        RESOURCES rsc/background.png
        SOURCES
        SOURCES MainWindow.h MainWindow.cpp
        RESOURCES rsc/add.png rsc/bin.png rsc/edit.png rsc/pause.png rsc/play-button.png rsc/reset.png rsc/stop-button.png
        RESOURCES images/stop-button.png
        RESOURCES images/reset.png
        RESOURCES images/play-button.png
        RESOURCES images/pause.png
        RESOURCES images/edit.png
        RESOURCES images/bin.png
        RESOURCES images/add.png
        QML_FILES
        SOURCES
        RESOURCES rsc/bkgr.png

        RESOURCES rsc/play.png rsc/square.png rsc/squarePause.png
        RESOURCES rsc/submit.png
        RESOURCES rsc/exit.png
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appWH PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appWH
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
    #QT_ANDROID_PACKAGE_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/android
)

target_link_libraries(appWH PRIVATE Qt6::Quick Qt6::Gui Qt6::QuickControls2 Qt6::Charts)
target_link_libraries(appWH PRIVATE Qt6::Widgets)

include(GNUInstallDirs)
install(TARGETS appWH
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
