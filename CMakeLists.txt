cmake_minimum_required(VERSION 3.16)

project(qt_test3 VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(FLUENTUI_BUILD_EXAMPLES OFF)
set(FLUENTUI_BUILD_FRAMELESSHEPLER OFF)
find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appqt_test3
    main.cpp
    ../utils/utils.cpp
    ../utils/utils.h
    ../client/doctor/doctor.cpp
    ../client/doctor/doctor.h
    ../client/patient/patient.cpp
    ../client/patient/patient.h
    ../client/database/database.h
    ../client/database/database.cpp
)

#添加qml模块
qt_add_qml_module(appqt_test3
    URI qt_test3
    VERSION 1.0
    QML_FILES
        pages/ChatView.qml
        ChatTest/ChatAvatar.qml
        Main.qml
        windows/patientwindow.qml
        windows/doctorwindow.qml
        button/Roundedbutton.qml
        button/MyComboBox.qml
        button/DisplayFrame.qml
        button/LoginPage.qml
        button/TermsWindow.qml
        button/RegisterPage.qml
        pages/HomePage.qml
        pages/RegisterPage.qml
        pages/ViewCase.qml
        pages/ViewPrescription.qml
        pages/ViewDoctorinfo.qml
        pages/Datagenerate.qml
        pages/Diagnose.qml
        pages/Bookpage.qml
        pages/EditDoctorInfo.qml
        pages/EditPatientInfo.qml
        pages/FreeConsultationPage.qml
        pages/ChatViewDoctor.qml
        pages/AdministratorLogin.qml
        pages/table.qml
        pages/table1.qml
        pages/table2.qml
        pages/table3.qml
        pages/table4.qml
        pages/table5.qml
        pages/table6.qml
    RESOURCES
    source/background.png
            source/doctor.png
            source/patient.png
            source/label.png
            source/doctor_login.png
            source/patient_login.png
            source/user.png
            source/lock.png
            source/consultation.jpeg
            source/shizijia.jpeg
            source/bg1.jpeg
            source/logo.jpeg
            source/cover1.jpg
            source/cover2.jpg
            source/cover3.jpeg
            source/cover4.jpeg
            source/cover5.jpg
            source/cover6.jpeg
            global/func.js

    OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/qt_test3
    QML_FILES button/Viewbutton.qml
    QML_FILES pages/In_Regeister.qml
    QML_FILES pages/Case.qml
    QML_FILES pages/Diagnose_inwindow.qml
    QML_FILES pages/ViewDoctorinfo_standby.qml
)


# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appqt_test3 PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appqt_test3
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appqt_test3
    PRIVATE Qt6::Quick
    fluentuiplugin
)

include(GNUInstallDirs)
install(TARGETS appqt_test3
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

add_subdirectory(FluentUI)






