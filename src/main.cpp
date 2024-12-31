#include "gui.h"
#include <memory>

int main() {
    
    std::unique_ptr<GUI> Gui = std::make_unique<GUI>();

    if(!Gui->InitGUI()){
        return -1;
    }

    Gui->renderGUI();
    Gui->CleanUp();
    
    return 0;
}
