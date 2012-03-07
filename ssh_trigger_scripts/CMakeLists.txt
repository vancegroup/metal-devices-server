configure_file(authorized_keys.in ${CMAKE_CURRENT_BINARY_DIR}/authorized_keys @ONLY)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/authorized_keys
	DESTINATION ${SSH_DIR})

install(PROGRAMS restart-all-servers restart-computer
	DESTINATION ${BIN_DIR})