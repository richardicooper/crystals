#On MAC OS currently need to use the XCode provided gcc and a compatible 
#gfortran (e.g. v4.2.3). If you have other gcc installed, make sure you
#set CC=/usr/bin/gcc and CXX=/usr/bin/g++ before running cmake.

CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

ENABLE_LANGUAGE(Fortran)

if(CRY_LIB)
  ADD_DEFINITIONS(-DCRY_NOGUI)
  ADD_DEFINITIONS(-DCRY_LIB)
elseif (CRY_NOGUI)
  ADD_DEFINITIONS(-DCRY_NOGUI)
else()
  ADD_DEFINITIONS(-DCRY_GUI)
endif()





if(APPLE)
SET(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmakemodules/")
SET(APPS ${CMAKE_BINARY_DIR}/crystals.app)

  if(NOT CRY_NOGUI)
    SET(wxWidgets_CONFIG_EXECUTABLE /Users/richard.cooper/wxWidgets-3.0.1/b/wx-config)
  endif()

endif()

if(NOT CRY_NOGUI)
  FIND_PACKAGE(wxWidgets REQUIRED html adv core gl base stc)
  INCLUDE(${wxWidgets_USE_FILE})
endif()


SET(DIRS )

IF (NOT CMAKE_BUILD_TYPE)   # make sure that the default is a RELEASE

    SET (CMAKE_BUILD_TYPE RELEASE CACHE STRING
         "Choose the type of build, options are: None Debug Release."  FORCE)

ENDIF()

# FFLAGS depend on the compiler
GET_FILENAME_COMPONENT (Fortran_COMPILER_NAME ${CMAKE_Fortran_COMPILER} NAME)

IF (Fortran_COMPILER_NAME STREQUAL "gfortran")  # gfortran

    SET (CMAKE_Fortran_FLAGS_RELEASE "-funroll-all-loops -fno-f2c -O3 -fexceptions")
    SET (CMAKE_Fortran_FLAGS_DEBUG   "-fno-f2c -O0 -g -fexceptions")

ELSEIF (Fortran_COMPILER_NAME STREQUAL "ifort")  # ifort (untested)

    SET (CMAKE_Fortran_FLAGS_RELEASE "-f77rtl -O3")
    SET (CMAKE_Fortran_FLAGS_DEBUG   "-f77rtl -O0 -g")

ELSEIF (Fortran_COMPILER_NAME STREQUAL "g77")   # g77

    SET (CMAKE_Fortran_FLAGS_RELEASE "-funroll-all-loops -fno-f2c -O3")
    SET (CMAKE_Fortran_FLAGS_DEBUG   "-fno-f2c -O0 -g")

ELSE ()

    MESSAGE ("CMAKE_Fortran_COMPILER full path: " ${CMAKE_Fortran_COMPILER})
    MESSAGE ("Fortran compiler: " ${Fortran_COMPILER_NAME})
    MESSAGE ("No optimized Fortran compiler flags are known, we just try -O2...")
    SET (CMAKE_Fortran_FLAGS_RELEASE "-O2")
    SET (CMAKE_Fortran_FLAGS_DEBUG   "-O0 -g")

ENDIF ()



IF (APPLE)

  SET(CMAKE_OSX_ARCHITECTURES "x86_64" )
  SET(CMAKE_OSX_DEPLOYMENT_TARGET "10.8") 
  SET(CMAKE_OSX_SYSROOT "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.9.sdk")
#  SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
#  SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++")
#  SET(CMAKE_LINKER_EXE_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=c++")

ENDIF ()


PROJECT(Crystals)


# Testing related directives for test coverage
ENABLE_TESTING()
INCLUDE(CTest)

# Libraries
ADD_SUBDIRECTORY(script)
ADD_SUBDIRECTORY(sleef)
if(NOT CRY_NOGUI)
ADD_SUBDIRECTORY(gui)
endif()
ADD_SUBDIRECTORY(crystals)
ADD_SUBDIRECTORY(cameron)
ADD_SUBDIRECTORY(datafiles)
if(APPLE)
ADD_SUBDIRECTORY(bits)
ADD_SUBDIRECTORY(precomp)
endif()



# Executables

if (APPLE)

ADD_DEFINITIONS(-D__MAC__)

else()

ADD_DEFINITIONS(-D__MIN__)

endif()

ADD_DEFINITIONS(-D_GNUF77_)
#ADD_DEFINITIONS(-D__WXMAC__)
#ADD_DEFINITIONS(-D__WXOSX__)

# -I c:/wx/include

if (APPLE)

  SET(rcfiles "")

else()

  SET(rcfiles "rc.o")

ADD_CUSTOM_COMMAND( OUTPUT rc.o
                    COMMAND windres ${CMAKE_CURRENT_SOURCE_DIR}/gui/wx.rc -o rc.o -I${wxWidgets_ROOT_DIR}/include
                     DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/gui/wx.rc )
endif()

# Script file sources and targets

get_directory_property (dirdefs
                        DIRECTORY ${CMAKE_SOURCE_DIR}
                        COMPILE_DEFINITIONS)
foreach ( d ${dirdefs} )
    set (defline ${defline} -D${d} )
#    message ( STATUS “Defined: “  ${d} )
endforeach()

#message( STATUS “DirDefs: “ ${dirdefs} )
message( STATUS ${defline} )

#if(APPLE)
FILE (GLOB sscfiles RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" "${CMAKE_CURRENT_SOURCE_DIR}/script/*.ssc")
SET  (scpfiles)
FOREACH (_file ${sscfiles})
    STRING(REPLACE ".ssc" ".scp" file_scp ${_file})
    ADD_CUSTOM_COMMAND( OUTPUT ${file_scp} 
#                        COMMAND perl ${CMAKE_CURRENT_SOURCE_DIR}/editor/crysedit.pl $#{CMAKE_CURRENT_SOURCE_DIR}/${_file} ${file_scp} code=GIL incl=+ excl=- comm=\\%\\%
                        COMMAND perl ${CMAKE_CURRENT_SOURCE_DIR}/editor/filepp.pl -w -imacros ${CMAKE_CURRENT_SOURCE_DIR}/gui/crystalsinterface.h -o ${file_scp} ${defline} ${CMAKE_CURRENT_SOURCE_DIR}/${_file}
                        DEPENDS ${_file} )
    LIST(APPEND scpfiles ${file_scp})
ENDFOREACH()

# Data file sources and targets

FILE (GLOB sdafiles RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" "${CMAKE_CURRENT_SOURCE_DIR}/script/*.sda")
SET  (datfiles)
FOREACH (_file ${sdafiles})
    STRING(REPLACE ".sda" ".dat" file_dat ${_file})
    ADD_CUSTOM_COMMAND( OUTPUT ${file_dat} 
                        COMMAND perl ${CMAKE_CURRENT_SOURCE_DIR}/editor/crysedit.pl ${CMAKE_CURRENT_SOURCE_DIR}/${_file} ${file_dat} code=GIL incl=+ excl=- comm=\#
                        DEPENDS ${_file} )
    LIST(APPEND datfiles ${file_dat})
ENDFOREACH()

FILE (GLOB ssrfiles RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" "${CMAKE_CURRENT_SOURCE_DIR}/datafiles/*.ssr")
SET  (srtfiles)
FOREACH (_file ${ssrfiles})
    STRING(REPLACE ".ssr" ".srt" file_srt ${_file})
    ADD_CUSTOM_COMMAND( OUTPUT ${file_srt} 
#                        COMMAND perl ${CMAKE_CURRENT_SOURCE_DIR}/editor/crysedit.pl ${CMAKE_CURRENT_SOURCE_DIR}/datafiles/${_file} ${file_srt} code=GIL incl=+ excl=- comm=\#
                        COMMAND perl ${CMAKE_CURRENT_SOURCE_DIR}/editor/filepp.pl -w -imacros ${CMAKE_CURRENT_SOURCE_DIR}/gui/crystalsinterface.h -o ${file_srt} ${defline} ${CMAKE_CURRENT_SOURCE_DIR}/${_file}
                        DEPENDS ${_file} )
    LIST(APPEND srtfiles ${file_srt})
ENDFOREACH()
#endif()

if(APPLE)
SET_SOURCE_FILES_PROPERTIES( ${scpfiles} PROPERTIES MACOSX_PACKAGE_LOCATION Resources/script GENERATED 1  )
SET_SOURCE_FILES_PROPERTIES( ${datfiles} PROPERTIES MACOSX_PACKAGE_LOCATION Resources/script GENERATED 1  )
SET_SOURCE_FILES_PROPERTIES( ${srtfiles} PROPERTIES MACOSX_PACKAGE_LOCATION Resources GENERATED 1  )
endif()

#ADD_CUSTOM_TARGET ( sleef ALL DEPENDS sleef/sleefsp.o )
ADD_CUSTOM_TARGET ( startups ALL DEPENDS dscbuild ${srtfiles} )
ADD_CUSTOM_TARGET ( dscbuild ALL DEPENDS commands.dsc crystals )

SET_SOURCE_FILES_PROPERTIES( commands.dsc PROPERTIES MACOSX_PACKAGE_LOCATION Resources GENERATED 1  )

set( MACOSX_BUNDLE_ICON_FILE crystals.icns )

#ADD_CUSTOM_COMMAND ( OUTPUT commands.dsc COMMAND cp datafiles/commands.dsc . DEPENDS subdscbuild ${CMAKE_BINARY_DIR}/datafiles/commands.dsc )
ADD_CUSTOM_COMMAND ( OUTPUT commands.dsc COMMAND ${CMAKE_COMMAND} -E copy datafiles/commands.dsc . DEPENDS subdscbuild ${CMAKE_BINARY_DIR}/datafiles/commands.dsc )


IF(APPLE)
ADD_CUSTOM_TARGET ( osx_bundle_dirs
    COMMAND mkdir -p ${CMAKE_CURRENT_BINARY_DIR}/crystals.app/Contents/Resources
    COMMAND mkdir -p ${CMAKE_CURRENT_BINARY_DIR}/crystals.app/Contents/MacOS
    COMMAND cp ${CMAKE_SOURCE_DIR}/precomp/MAC/${MACOSX_BUNDLE_ICON_FILE}
    ${CMAKE_CURRENT_BINARY_DIR}/crystals.app/Contents/Resources/${MACOSX_BUNDLE_ICON_FILE} )
ENDIF()


if(NOT CRY_NOGUI)
  set (mainfile gui/gcrystals.cc)
else()
  set (mainfile crystals/main.F)
endif()


ADD_EXECUTABLE (crystals MACOSX_BUNDLE ${scpfiles} ${datfiles} ${srtfiles} ${mainfile} ${rcfiles})

if(CRY_NOGUI)
ADD_EXECUTABLE (testdrive MACOSX_BUNDLE crystals/testdrive.F)
endif()

# Use different Info.plist template.
set_target_properties(crystals PROPERTIES 
			       MACOSX_BUNDLE_INFO_PLIST 
			       ${CMAKE_CURRENT_SOURCE_DIR}/datafiles/MacOSXBundleInfo.plist.in)


if (NOT CRY_NOGUI)
  add_library(everything $<TARGET_OBJECTS:CrystalsUserInterface>
                         $<TARGET_OBJECTS:CrystalsFortran>)

  TARGET_LINK_LIBRARIES(crystals everything CrystalsSleef 
                                 CameronFortran ${wxWidgets_LIBRARIES})

else()

  TARGET_LINK_LIBRARIES(crystals CrystalsFortran CrystalsSleef CameronFortran)
  SET_TARGET_PROPERTIES(crystals PROPERTIES LINKER_LANGUAGE Fortran)
  TARGET_LINK_LIBRARIES(testdrive CrystalsFortran CrystalsSleef CameronFortran)
  SET_TARGET_PROPERTIES(testdrive PROPERTIES LINKER_LANGUAGE Fortran)

endif()

INSTALL(CODE "
      include(BundleUtilities)
      fixup_bundle(\"${APPS}\"  \"\"  \"${DIRS}\")
      " COMPONENT Runtime)



if(APPLE)
  set (CRYSTALS_BINARY_DESTINATION ${CMAKE_BINARY_DIR}/crystals.app/Contents/Resources)
else()
  set (CRYSTALS_BINARY_DESTINATION ${CMAKE_BINARY_DIR})
endif()

INSTALL(FILES ${CMAKE_BINARY_DIR}/commands.dsc DESTINATION 
	      ${CRYSTALS_BINARY_DESTINATION} )

INSTALL(TARGETS crystals
        BUNDLE DESTINATION .
       )

#INSTALL(PROGRAMS ${CMAKE_BINARY_DIR}/crystals.sh DESTINATION ${CRYSTALS_BINARY_DESTINATION} COMPONENT Runtime)

INSTALL(PROGRAMS ${CMAKE_BINARY_DIR}/bits/cif2cry/cif2cry DESTINATION ${CRYSTALS_BINARY_DESTINATION} COMPONENT Runtime)
INSTALL(PROGRAMS ${CMAKE_BINARY_DIR}/bits/shelxs/shelxs DESTINATION ${CRYSTALS_BINARY_DESTINATION} )
INSTALL(PROGRAMS ${CMAKE_BINARY_DIR}/bits/shelxs/sxtocry DESTINATION ${CRYSTALS_BINARY_DESTINATION} )
INSTALL(PROGRAMS ${CMAKE_BINARY_DIR}/bits/convplat/convplat DESTINATION ${CRYSTALS_BINARY_DESTINATION} )
INSTALL(PROGRAMS ${CMAKE_BINARY_DIR}/bits/delred/delred DESTINATION ${CRYSTALS_BINARY_DESTINATION} )
INSTALL(PROGRAMS ${CMAKE_BINARY_DIR}/bits/foxman/pcf2cry DESTINATION ${CRYSTALS_BINARY_DESTINATION} )
#INSTALL(PROGRAMS ${CMAKE_BINARY_DIR}/bits/sir92/sir92 DESTINATION ${CRYSTALS_BINARY_DESTINATION} )
INSTALL(PROGRAMS ${CMAKE_BINARY_DIR}/bits/csd2cry/csd2cry DESTINATION ${CRYSTALS_BINARY_DESTINATION} )
INSTALL(PROGRAMS ${CMAKE_BINARY_DIR}/bits/hklf5/hklf52cry DESTINATION ${CRYSTALS_BINARY_DESTINATION} )
INSTALL(PROGRAMS ${CMAKE_BINARY_DIR}/bits/Diffractometers/diffin DESTINATION ${CRYSTALS_BINARY_DESTINATION} )

FILE (COPY "${CMAKE_CURRENT_SOURCE_DIR}/precomp/all/script" DESTINATION ${CRYSTALS_BINARY_DESTINATION})
FILE (COPY "${CMAKE_CURRENT_SOURCE_DIR}/precomp/all/demo" DESTINATION ${CRYSTALS_BINARY_DESTINATION})
FILE (COPY "${CMAKE_CURRENT_SOURCE_DIR}/precomp/all/form.dat" DESTINATION ${CRYSTALS_BINARY_DESTINATION})

INSTALL (PROGRAMS "${CMAKE_CURRENT_SOURCE_DIR}/precomp/MAC/superflip" DESTINATION ${CRYSTALS_BINARY_DESTINATION})
INSTALL (PROGRAMS "${CMAKE_CURRENT_SOURCE_DIR}/precomp/MAC/EDMA" DESTINATION ${CRYSTALS_BINARY_DESTINATION})



set (CPACK_GENERATOR "DragNDrop")
set(CPACK_BINARY_DRAGNDROP ON)
set (CPACK_BUNDLE_NAME "Crystals")
#set (CPACK_BUNDLE_STARTUP_COMMAND "Contents/Resources/crystals.sh")
SET(CPACK_INSTALL_CMAKE_PROJECTS  "${CMAKE_BINARY_DIR};Crystals;ALL;/")
SET(CPACK_PACKAGE_VENDOR "Chem Cryst")
SET(CPACK_PACKAGE_VERSION "15.0.0")
SET(CPACK_PACKAGE_VERSION_MAJOR "15")
SET(CPACK_PACKAGE_VERSION_MINOR "0")
SET(CPACK_PACKAGE_VERSION_PATCH "0")
SET(CPACK_PACKAGE_EXECUTABLES "crystals")

INCLUDE (CPack)

