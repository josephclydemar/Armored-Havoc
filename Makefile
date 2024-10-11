CXX = g++
CXXFLAGS = -Wall -Wextra -Werror -std=c++20
LDFLAGS = -I include

BUILD_MODE =
BIN_TARGET_EXT =
OBJ_TARGET_EXT = o
BIN_RUN = 

# directories
BIN_BUILD_DIR = build/bin
OBJ_BUILD_DIR = build/obj
RAYLIB_LIB_PATH = 

# source files
MAIN_CPP = src/main.cpp


ifeq ($(BUILD_MODE), DEBUG)
	CXXFLAGS += -g
else
	CXXFLAGS += -O3 -s
endif

ifeq ($(OS), Windows_NT)
	BIN_TARGET_EXT = exe
	RAYLIB_LIB_PATH = lib/external/raylib/windows
	LDFLAGS += -L $(RAYLIB_LIB_PATH) -lraylib
	BIN_RUN = PATH=$(RAYLIB_LIB_PATH)/. $(BIN_TARGET)
else
	BIN_TARGET_EXT = out
	RAYLIB_LIB_PATH = lib/external/raylib/linux
	LDFLAGS += -L $(RAYLIB_LIB_PATH) -lraylib
	BIN_RUN = LD_LIBRARY_PATH=$(RAYLIB_LIB_PATH)/. $(BIN_TARGET)
endif

# targets
BIN_TARGET = build/bin/main.$(BIN_TARGET_EXT)


# build rules
$(BIN_TARGET): $(MAIN_CPP)
	$(CXX) $(CXXFLAGS) $(LDFLAGS) $^ -o $@


all: $(BIN_TARGET)

run: $(BIN_TARGET)
	$(BIN_RUN)

clean:
	$(RM) $(BIN_BUILD_DIR)/*.$(BIN_TARGET_EXT)
	$(RM) $(OBJ_BUILD_DIR)/*.$(OBJ_TARGET_EXT)
