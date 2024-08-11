# OpenFrameworks Project Makefile

# Set project name (used for the output binary)
PROJECT_NAME = openFrameworksProjectTemplate

# Set path to your OpenFrameworks installation
OF_ROOT = /path/to/openFrameworks

# Compiler settings
CXX = g++
CXXFLAGS = -std=c++17 -Wall -Wno-unused-function -Wno-unused-parameter
LDFLAGS = -L$(OF_ROOT)/libs -Wl,-rpath=$(OF_ROOT)/libs

# Source files
SRC_DIR = src
SRC_FILES = $(wildcard $(SRC_DIR)/*.cpp)
OBJ_FILES = $(SRC_FILES:.cpp=.o)

# Include paths
INCLUDES = -I$(OF_ROOT)/libs/openFrameworks -I$(OF_ROOT)/addons
INCLUDES += -I$(OF_ROOT)/libs -I$(OF_ROOT)/addons/ofxGui/src

# Libraries to link against
LIBS = -lopenFrameworks -lGL -lGLU -lglut -lpthread

# Addons
ADDONS = $(shell cat addons.make)
ADDON_INCLUDES = $(foreach addon,$(ADDONS),$(OF_ROOT)/addons/$(addon)/src)

# Final binary output
BIN_DIR = bin
BIN_NAME = $(PROJECT_NAME)

# Platform-specific settings
PLATFORM_OS := $(shell uname)
ifeq ($(PLATFORM_OS), Darwin)
    LDFLAGS += -framework OpenGL -framework GLUT
else
    LIBS += -lX11 -lXrandr -lXi -lXxf86vm
endif

# Rules
all: $(BIN_DIR)/$(BIN_NAME)

$(BIN_DIR)/$(BIN_NAME): $(OBJ_FILES)
	@mkdir -p $(BIN_DIR)
	$(CXX) $(OBJ_FILES) -o $@ $(LDFLAGS) $(LIBS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) $(INCLUDES) $(ADDON_INCLUDES) -c $< -o $@

clean:
	rm -f $(SRC_DIR)/*.o
	rm -f $(BIN_DIR)/$(BIN_NAME)

.PHONY: clean


TEST_SRC = $(wildcard tests/*.cpp)
TEST_OBJ = $(TEST_SRC:.cpp=.o)

test: $(TEST_OBJ)
    $(CXX) $(TEST_OBJ) -o $(BIN_DIR)/testRunner $(LDFLAGS) $(LIBS)
    $(BIN_DIR)/testRunner


format:
    clang-format -i src/*.cpp src/*.h