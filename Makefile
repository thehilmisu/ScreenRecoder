CXX = g++

CXXFLAGS = -std=c++17 -Wall -Wextra 
INCLUDES = -Iinclude -Ithirdparty/imgui -Ithirdparty/imgui/backends
LIBS = -lglfw -lGL -ldl -lavcodec -lavformat -lavutil -lswscale -lavdevice

SRC_DIR = src
SRCS = $(wildcard $(SRC_DIR)/*.cpp)
OBJS = $(SRCS:$(SRC_DIR)/%.cpp=build/%.o)

IMGUI_DIR = thirdparty/imgui
IMGUI_SRCS = \
			 $(IMGUI_DIR)/imgui.cpp \
			 $(IMGUI_DIR)/imgui_draw.cpp \
			 $(IMGUI_DIR)/imgui_tables.cpp \
			 $(IMGUI_DIR)/imgui_widgets.cpp 

IMGUI_OBJS = $(IMGUI_SRCS:$(IMGUI_DIR)/%.cpp=build/%.o)

IMGUI_BACKEND_SRCS = \
			 		$(IMGUI_DIR)/backends/imgui_impl_glfw.cpp \
			 		$(IMGUI_DIR)/backends/imgui_impl_opengl3.cpp \

IMGUI_BACKENDS_OBJS = $(IMGUI_BACKEND_SRCS:$(IMGUI_DIR)/backends/%.cpp=build/%.o)

TARGET = build/screen-recorder

all: $(TARGET)

$(TARGET): $(OBJS) $(IMGUI_OBJS) $(IMGUI_BACKENDS_OBJS) 
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LIBS)

build/%.o: $(SRC_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c $< -o $@

build/%.o: $(IMGUI_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c $< -o $@

build/%.o: $(IMGUI_DIR)/backends/%.cpp
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c $< -o $@

clean:
	rm -f $(OBJS) $(IMGUI_OBJS) $(IMGUI_BACKENDS_OBJS) $(TARGET)

.PHONY: all clean
