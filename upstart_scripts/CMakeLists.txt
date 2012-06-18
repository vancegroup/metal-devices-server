
foreach(upstartfile vrpn.conf)
	configure_file(${upstartfile}.in ${CMAKE_CURRENT_BINARY_DIR}/${upstartfile} @ONLY)
	install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${upstartfile}
		DESTINATION ${UPSTART_DIR})
endforeach()
