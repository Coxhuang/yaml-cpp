set(CATER_BASENAME "cater")

################################################################################
#
################################################################################
function(set_cater_base_prefix TARGET_PREFIX)
    set(CATER_BASENAME ${TARGET_PREFIX}_${CATER_BASENAME} PARENT_SCOPE)
    set(CATER_LIBRARY_BASENAME lib${TARGET_PREFIX}_${CATER_BASENAME} PARENT_SCOPE)
endfunction()

function(set_cater_executable_name TARGET_NAME COMPONENT_NAME)
    set(${TARGET_NAME} ${CATER_BASENAME}_${COMPONENT_NAME} PARENT_SCOPE)
endfunction()

function(set_cater_library_name TARGET_NAME COMPONENT_NAME)
    set(${TARGET_NAME} ${CATER_BASENAME}_${COMPONENT_NAME} PARENT_SCOPE)
endfunction()

################################################################################
#
################################################################################
function(_add_cater_library)
    set_cater_library_name(TARGET_NAME ${PROJECT_NAME})
    set(MY_ARGV ${ARGV})
    set(MY_ARGV0 ${TARGET_NAME})
    list(REMOVE_AT MY_ARGV 0)
    list(PREPEND MY_ARGV ${MY_ARGV0})

    add_library(${MY_ARGV})
    # set_target_properties(${MY_ARGV0} PROPERTIES
    #   PREFIX ""
    #   )
    set(${ARGV0} ${MY_ARGV0} PARENT_SCOPE)
endfunction()

################################################################################
#
################################################################################
function(_add_cater_utility)
    set_cater_executable_name(TARGET_NAME ${PROJECT_NAME})
    set(MY_ARGV ${ARGV})
    set(MY_ARGV0 ${TARGET_NAME})
    list(REMOVE_AT MY_ARGV 0)
    list(PREPEND MY_ARGV ${MY_ARGV0})

    add_executable(${MY_ARGV})
    set(${ARGV0} ${MY_ARGV0} PARENT_SCOPE)
endfunction()

################################################################################
# create a cater module target
################################################################################
function(add_cater_module)
    add_library(${ARGV})
    set_target_properties(${ARGV0} PROPERTIES
            PREFIX ""
            SUFFIX ".mod"
            )
endfunction()

################################################################################
# create a cater runner target
################################################################################
function(add_cater_runner)
    set(MY_ARGV ${ARGV})
    set(MY_ARGV0 ${ARGV0}_runner)
    list(REMOVE_AT MY_ARGV 0)
    list(PREPEND MY_ARGV ${MY_ARGV0})
    add_executable(${MY_ARGV})
    set_target_properties(${MY_ARGV0} PROPERTIES
            SUFFIX ".exe"
            )
    target_link_libraries(${MY_ARGV0}
            ${TRUNK_CATER_NODE}
            ${TRUNK_CATER_LOADER}
            ${TRUNK_CATER_MODULE}
            )
endfunction()

###############################################################################
# Extract version numbers from version string
################################################################################
function (version_numbers version major minor patch)
    if (version MATCHES "([0-9]+)(\\.[0-9]+)?(\\.[0-9]+)?(rc[1-9][0-9]*|[a-z]+)?")
        if (CMAKE_MATCH_1)
            set (_major ${CMAKE_MATCH_1})
        else ()
            set (_major 0)
        endif ()
        if (CMAKE_MATCH_2)
            set (_minor ${CMAKE_MATCH_2})
            string (REGEX REPLACE "^\\." "" _minor "${_minor}")
        else ()
            set (_minor 0)
        endif ()
        if (CMAKE_MATCH_3)
            set (_patch ${CMAKE_MATCH_3})
            string (REGEX REPLACE "^\\." "" _patch "${_patch}")
        else ()
            set (_patch 0)
        endif ()
    else ()
        set (_major 0)
        set (_minor 0)
        set (_patch 0)
    endif ()
    set ("${major}" "${_major}" PARENT_SCOPE)
    set ("${minor}" "${_minor}" PARENT_SCOPE)
    set ("${patch}" "${_patch}" PARENT_SCOPE)
endfunction ()
