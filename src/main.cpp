// This is the entry point for your OpenFrameworks application.


#include "ofMain.h"
#include "ofApp.h"

int main() {
    ofSetupOpenGL(1024,768,OF_WINDOW);    // Set window size
    ofRunApp(new ofApp());
}