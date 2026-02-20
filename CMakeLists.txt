cmake_minimum_required(VERSION 3.16)

project(WH VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(QML_IMPORT_PATH ${CMAKE_SOURCE_DIR}/qml ${CMAKE_BINARY_DIR}/imports CACHE STRING "" FORCE)
# if(ANDROID)
#     # Explicitly set versions - no auto-detection
#     set(ANDROID_PLATFORM "android-33" CACHE STRING "" FORCE)
#     set(QT_ANDROID_TARGET_SDK_VERSION 33)
#     set(QT_ANDROID_MIN_SDK_VERSION 23)
# endif()
find_package(Qt6 REQUIRED COMPONENTS Quick Gui QuickControls2 Charts Core5Compat  )
find_package(Qt6 REQUIRED COMPONENTS Widgets)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appWH
    main.cpp
)

qt_add_qml_module(appWH
        URI WH
        QML_FILES
            Main.qml

        SOURCES
            MainWindow.h
            MainWindow.cpp
            app_status.cpp

        RESOURCES
            rsc/background.png
            rsc/add.png
            rsc/bin.png
            rsc/edit.png
            rsc/pause.png
            rsc/play-button.png
            rsc/reset.png
            rsc/stop-button.png
            images/stop-button.png
            images/reset.png
            images/play-button.png
            images/pause.png
            images/edit.png
            images/bin.png
            images/add.png

            rsc/bkgr.png
            rsc/play.png
            rsc/square.png
            rsc/squarePause.png
            rsc/submit.png
            rsc/exit.png
            rsc/options.png
            rsc/done.png

            rsc/intropic.png rsc/logo.png
            rsc/intropic.png
            rsc/bkgr.jpg

            android/gradle/wrapper/gradle-wrapper.jar
            android/gradle/wrapper/gradle-wrapper.properties
            android/res/drawable/intropic.png
            android/res/values/libs.xml
            android/AndroidManifest.xml
            android/build.gradle
            android/gradle.properties
            android/gradlew
            android/gradlew.bat
            android/res/drawable/intropic.png  android/res/drawable/splash.xml
            android/res/values/apptheme.xml
            rsc/logo.png
            android/res/drawable/logo.png
            resources.qrc

            fonts/Candara.ttf
            fonts/Square721_BT.ttf
            fonts/Square721BTBold.ttf
            fonts/Square721BTItalicV2.ttf
            fonts/Square721BTRoman.ttf
            fonts/Candara.ttf
            fonts/Square721_BT.ttf
            fonts/Square721BTBold.ttf
            fonts/Square721BTItalicV2.ttf
            fonts/Square721BTRoman.ttf
            android/assets/fonts/Candara.ttf
            android/assets/fonts/Square721_BT.ttf
            android/assets/fonts/Square721BTBold.ttf
            android/assets/fonts/Square721BTItalicV2.ttf
            android/assets/fonts/Square721BTRoman.ttf
            rsc/button.png rsc/no.png rsc/switch.png
            rsc/background.jpg
        )
    qt_add_resources(appWH
        PREFIX "/"
        FILES
            fonts/Candara.ttf
            fonts/Square721_BT.ttf
            fonts/Square721BTBold.ttf
            fonts/Square721BTItalicV2.ttf
            fonts/Square721BTRoman.ttf
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
    QT_ANDROID_PACKAGE_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/android
)

target_link_libraries(appWH PRIVATE Qt6::Quick Qt6::Gui Qt6::QuickControls2 Qt6::Charts )
target_link_libraries(appWH PRIVATE Qt6::Widgets)

include(GNUInstallDirs)
install(TARGETS appWH
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
