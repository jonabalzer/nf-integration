QT       += core gui opengl

QMAKE_CXXFLAGS += -std=c++0x -O3

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = integrator
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp \
    vecn.cpp \
    cam.cpp \
    trafo.cpp \
    linalg.cpp \
    nfield.cpp \
    darray.cpp \
    types.cpp \
    trimesh.cpp \
    viewer.cpp

HEADERS  += mainwindow.h \
    vecn.h \
    cam.h \
    trafo.h \
    linalg.h \
    nfield.h \
    darray.h \
    types.h \
    trimesh.h \
    viewer.h

FORMS    += mainwindow.ui


unix:!symbian|win32 {

    # find OpenEXR
    packagesExist(OpenEXR) {

        CONFIG += link_pkgconfig
        PKGCONFIG += OpenEXR
        DEFINES += HAVE_EXR

    }
    else {
        warning("Could not resolve dependence on OpenEXR...")
    }


    # find OpenMesh library
    OM = $$system(find /usr -name libOpenMeshCore* 2>/dev/null)
    isEmpty(OM) {
        warning("Could not resolve dependency on OpenMesh.")
    } else {

        OM = $$first(OM)
        OMLIBPATH = $$dirname(OM)
        DEFINES += HAVE_OM

        LIBS += -L$$OMLIBPATH \
                -lOpenMeshCore \
                -lOpenMeshTools

        # add this so the binary knows the location of OM in non-standard path
        QMAKE_LFLAGS += -Wl,-rpath=$$OMLIBPATH

    }


    LIBS += -lcholmod

}