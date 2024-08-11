cmake_minimum_required(VERSION 3.15)
project(OpenFrameworksProjectTemplate)

# Options for build types
set(CMAKE_BUILD_TYPE Release)

# Set OpenFrameworks path
set(OF_ROOT /path/to/openFrameworks)

# Add platform-specific settings
if(WIN32)
    add_definitions(-DWIN32)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /MP")
elseif(APPLE)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++")
endif()

# Include OpenFrameworks and addons
include_directories(${OF_ROOT}/libs/openFrameworks)
include_directories(${OF_ROOT}/addons/ofxGui/src)

# Add the source files
file(GLOB SRC_FILES src/*.cpp src/*.h)

# Create executable
add_executable(${PROJECT_NAME} ${SRC_FILES})

# Link OpenFrameworks libraries
target_link_libraries(${PROJECT_NAME} ${OF_ROOT}/libs/libopenFrameworks.a)

# Add external libraries if necessary
find_package(Boost REQUIRED)
include_directories(${Boost_INCLUDE_DIRS})
target_link_libraries(${PROJECT_NAME} ${Boost_LIBRARIES})