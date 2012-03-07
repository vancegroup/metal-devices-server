cmake_minimum_required(VERSION 2.8.3)
project(metal-devices-server)

# These are relative to CMAKE_INSTALL_PREFIX

set(BIN_DIR bin)
set(LIB_DIR lib)
set(CFG_DIR etc)
set(SSH_DIR ssh)
set(UPSTART_DIR upstart)

# These must be absolute paths
set(TRIGGER_SCRIPT_DIR "${CMAKE_INSTALL_PREFIX}/${BIN_DIR}")
set(VRPN_HOME "${CMAKE_INSTALL_PREFIX}")
set(VRPN_CFG_DIR "${CMAKE_INSTALL_PREFIX}/${CFG_DIR}")

add_subdirectory(src)
add_subdirectory(ssh_trigger_scripts)
add_subdirectory(vrpn_configs)
add_subdirectory(upstart_scripts)
add_subdirectory(beep_scripts)
