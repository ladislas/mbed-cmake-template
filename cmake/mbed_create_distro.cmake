# Patched version of the mbed function.
# (replaced "target_link_options(mbed-core INTERFACE" with "target_link_options(${target} PRIVATE")
# Can be removed once #14199 is merged
function(mbed_generate_options_for_linker_patched target definitions_file)
	set(_compile_definitions
		"$<TARGET_PROPERTY:${target},COMPILE_DEFINITIONS>"
		)

	# Remove macro definitions that contain spaces as the lack of escape sequences and quotation marks
	# in the macro when retrieved using generator expressions causes linker errors.
	# This includes string macros, array macros, and macros with operations.
	# TODO CMake: Add escape sequences and quotation marks where necessary instead of removing these macros.
	set(_compile_definitions
		"$<FILTER:${_compile_definitions},EXCLUDE, +>"
		)

	# Append -D to all macros as we pass these as response file to cxx compiler
	set(_compile_definitions
		"$<$<BOOL:${_compile_definitions}>:-D$<JOIN:${_compile_definitions}, -D>>"
		)
	file(GENERATE OUTPUT "${CMAKE_BINARY_DIR}/${target}.txt" CONTENT "${_compile_definitions}\n")
	set(${definitions_file} @${CMAKE_BINARY_DIR}/${target}.txt PARENT_SCOPE)
endfunction()

# Patched version of the mbed function.
# (replaced "target_link_options(mbed-core INTERFACE" with "target_link_options(${target} PRIVATE")
# Can be removed once #14199 is merged
function(mbed_set_mbed_target_linker_script_patched target)
	get_property(mbed_target_linker_script GLOBAL PROPERTY MBED_TARGET_LINKER_FILE)
	mbed_generate_options_for_linker_patched(${target} _linker_preprocess_definitions)
	if(MBED_TOOLCHAIN STREQUAL "GCC_ARM")
		set(CMAKE_PRE_BUILD_COMMAND
			COMMAND "arm-none-eabi-cpp" ${_linker_preprocess_definitions} -x assembler-with-cpp -E -Wp,-P
			${mbed_target_linker_script} -o ${CMAKE_BINARY_DIR}/${target}.link_script.ld

			WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
			BYPRODUCTS "${CMAKE_BINARY_DIR}/${target}.link_script.ld"
			)
		target_link_options(${target}
			PRIVATE
			"-T" "${CMAKE_BINARY_DIR}/${target}.link_script.ld"
			"-Wl,-Map=${CMAKE_BINARY_DIR}/${target}${CMAKE_EXECUTABLE_SUFFIX}.map"
			)
	elseif(MBED_TOOLCHAIN STREQUAL "ARM")
		set(CMAKE_PRE_BUILD_COMMAND COMMAND "")
		target_link_options(target
			PRIVATE
			"--scatter=${mbed_target_linker_script}"
			"--predefine=${_linker_preprocess_definitions}"
			"--map"
			)
	endif()
	add_custom_command(
		TARGET
		${target}
		PRE_LINK
		${CMAKE_PRE_BUILD_COMMAND}
		COMMENT
		"Link line:"
		VERBATIM
	)
endfunction()

# Append the value of PROPERTY from SOURCE to the value of PROPERTY on DESTINATION
function(copy_append_property PROPERTY SOURCE DESTINATION)
	get_property(PROP_IS_DEFINED TARGET ${SOURCE} PROPERTY ${PROPERTY} SET)
	if(PROP_IS_DEFINED)
		get_property(PROP_VALUE TARGET ${SOURCE} PROPERTY ${PROPERTY})
		#message("Copying ${PROPERTY} from ${SOURCE} -> ${DESTINATION}: ${PROP_VALUE} ")
		set_property(TARGET ${DESTINATION} APPEND PROPERTY ${PROPERTY} "${PROP_VALUE}")
	endif()
endfunction(copy_append_property)

# Create a "distribution" of Mbed OS containing the base Mbed and certain modules.
# This distribution only needs to be compiled once and can be referenced in an arbitrary amount of targets
function(mbed_create_distro NAME) # ARGN: modules...
	add_library(${NAME} OBJECT)
	mbed_configure_app_target(${NAME})

	# First link as private dependencies
	target_link_libraries(${NAME} PRIVATE ${ARGN})

	# Now copy include dirs, compile defs, and compile options (but NOT interface source files) over
	# to the distribution target so they will be passed into things that link to it.
	# To do this, we need to recursively traverse the tree of dependencies.
	set(REMAINING_MODULES ${ARGN})
	set(COMPLETED_MODULES ${ARGN})
	while(NOT "${REMAINING_MODULES}" STREQUAL "")

		list(GET REMAINING_MODULES 0 CURR_MODULE)

		#message("Processing ${CURR_MODULE}")

		copy_append_property(INTERFACE_COMPILE_DEFINITIONS ${CURR_MODULE} ${NAME})
		copy_append_property(INTERFACE_COMPILE_OPTIONS ${CURR_MODULE} ${NAME})
		copy_append_property(INTERFACE_INCLUDE_DIRECTORIES ${CURR_MODULE} ${NAME})
		copy_append_property(INTERFACE_LINK_OPTIONS ${CURR_MODULE} ${NAME})

		list(REMOVE_AT REMAINING_MODULES 0)
		list(APPEND COMPLETED_MODULES ${CURR_MODULE})

		# find sub-modules of this module
		get_property(SUBMODULES TARGET ${CURR_MODULE} PROPERTY INTERFACE_LINK_LIBRARIES)
		#message("Deps of ${CURR_MODULE}: ${SUBMODULES}")
		foreach(SUBMODULE ${SUBMODULES})
			if(NOT "${SUBMODULE}" MATCHES "::@") # remove CMake internal CMAKE_DIRECTORY_ID_SEP markers
				if(NOT ${SUBMODULE} IN_LIST COMPLETED_MODULES)
					list(APPEND REMAINING_MODULES ${SUBMODULE})
				endif()
			endif()
		endforeach()

		#message("REMAINING_MODULES: ${REMAINING_MODULES}")

	endwhile()

endfunction(mbed_create_distro)
