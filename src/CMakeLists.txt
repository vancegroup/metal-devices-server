
include(ExternalProject)

ExternalProject_Add(wiiuse
	SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/wiiuse"
	CMAKE_ARGS
		"-DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>"
		-DCMAKE_BUILD_TYPE:STRING=RelWithDebInfo
)
if(WIN32)
	set(WIIUSE_LIB_NAME lib/wiiuse.lib)
	set(WIIUSE_RUNTIME_LIB_NAME bin/wiiuse.dll)
else()
	set(WIIUSE_LIB_NAME lib/libwiiuse.so)
	set(WIIUSE_RUNTIME_LIB_NAME lib/libwiiuse.so)
endif()
ExternalProject_Get_Property(wiiuse INSTALL_DIR)
set(WIIUSE_ROOT_DIR ${INSTALL_DIR})
install(FILES "${WIIUSE_ROOT_DIR}/${WIIUSE_RUNTIME_LIB_NAME}"
	DESTINATION ${LIB_DIR})


ExternalProject_Add(vrpn
	SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/vrpn"
	CMAKE_ARGS
		-DCMAKE_BUILD_TYPE:STRING=RelWithDebInfo
		"-DWIIUSE_ROOT_DIR:PATH=${WIIUSE_ROOT_DIR}"
		"-DWIIUSE_LIBRARY:PATH=${WIIUSE_ROOT_DIR}/${WIIUSE_LIB_NAME}"
		"-DWIIUSE_RUNTIME_LIBRARY:PATH=${WIIUSE_ROOT_DIR}/${WIIUSE_RUNTIME_LIB_NAME}"
		-DVRPN_USE_WIIUSE:BOOL=ON
		-DVRPN_GPL_SERVER:BOOL=ON
		-DBUILD_TESTING:BOOL=OFF
		-DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
	DEPENDS wiiuse
)

ExternalProject_Get_Property(vrpn INSTALL_DIR)
set(VRPN_ROOT_DIR ${INSTALL_DIR})

install(PROGRAMS
	"${VRPN_ROOT_DIR}/bin/vrpn_server"
	DESTINATION ${BIN_DIR})

