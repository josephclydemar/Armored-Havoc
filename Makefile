CXX = g++
CXXFLAGS = -Wall -Wextra -Werror -std=c++2a
INCLUDES = -I include
LDFLAGS =

BUILD_MODE =
BIN_TARGET_EXT =
OBJ_TARGET_EXT = o
BIN_RUN =

# directories
BIN_BUILD_DIR = build/bin
OBJ_BUILD_DIR = build/obj
RAYLIB_LIB_PATH =


ifeq ($(BUILD_MODE), DEBUG)
	CXXFLAGS += -g
else
	CXXFLAGS += -O3
endif

ifeq ($(OS), Windows_NT)
	BIN_TARGET_EXT = exe
	RAYLIB_LIB_PATH = lib/external/raylib/windows
	LDFLAGS += -L $(RAYLIB_LIB_PATH) -lraylib
	BIN_RUN = PATH=$(RAYLIB_LIB_PATH) $(BIN_TARGET)
else
	BIN_TARGET_EXT = out
	RAYLIB_LIB_PATH = lib/external/raylib/linux
	LDFLAGS += -L $(RAYLIB_LIB_PATH) -lraylib
	BIN_RUN = LD_LIBRARY_PATH=$(RAYLIB_LIB_PATH) $(BIN_TARGET)
endif

# header files

# source files
MAIN_CPP = src/main.cpp


# executable target
BIN_TARGET = $(BIN_BUILD_DIR)/armored-havoc.$(BIN_TARGET_EXT)

# relocatable targets
OBJ_MAIN_TARGET = $(OBJ_BUILD_DIR)/main.$(OBJ_TARGET_EXT)

# build rules
all: $(BIN_TARGET)

run: $(BIN_TARGET)
	$(BIN_RUN)

clean:
	$(RM) $(BIN_BUILD_DIR)/*.$(BIN_TARGET_EXT)
	$(RM) $(OBJ_BUILD_DIR)/*.$(OBJ_TARGET_EXT)


$(BIN_TARGET): $(OBJ_MAIN_TARGET)
	$(CXX) $(CXXFLAGS) $^ $(LDFLAGS) -o $@

$(OBJ_MAIN_TARGET): $(MAIN_CPP)
	$(CXX) $(CXXFLAGS) -c $(INCLUDES) $^ -o $@


