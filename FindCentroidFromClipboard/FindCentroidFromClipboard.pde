// //////////////////
// Clipboard class for Processing
// by seltar, modified by adamohern
// v 0115AO
// only works with programs. applets require signing

import java.awt.datatransfer.*;
import java.awt.Toolkit; 

ClipHelper cp = new ClipHelper();

void setup() { size(200,800); background(#FABABA); }
void draw() {}

// Press Any Key to Copy
void mousePressed() {
  double xSum = 0;
  double ySum = 0;
  String input = cp.pasteString();
  
  String[] nTup = split(input, ' ');
  if(nTup.length > 2) {
    for(int i=0;i<nTup.length;i++) {
      String[] ps = split(nTup[i], ',');
      xSum += float(ps[0]);
      ySum += float(ps[1]);
    }
    xSum = xSum / nTup.length;
    ySum = ySum / nTup.length;
    
    println(xSum + "," + ySum);
    
    cp.copyString(xSum + "," + ySum);
  } else {
    println("INVALID SOURCE");
    cp.copyString(" ");
  }
}


// CLIPHELPER OBJECT CLASS:

class ClipHelper {
  Clipboard clipboard;
  
  ClipHelper() {
    getClipboard();  
  }
  
  void getClipboard () {
    // this is our simple thread that grabs the clipboard
    Thread clipThread = new Thread() {
	public void run() {
	  clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
	}
    };
  
    // start the thread as a daemon thread and wait for it to die
    if (clipboard == null) {
	try {
	  clipThread.setDaemon(true);
	  clipThread.start();
	  clipThread.join();
	}  
	catch (Exception e) {}
    }
  }
  
  void copyString (String data) {
    copyTransferableObject(new StringSelection(data));
  }
  
  void copyTransferableObject (Transferable contents) {
    getClipboard();
    clipboard.setContents(contents, null);
  }
  
  String pasteString () {
    String data = null;
    try {
	data = (String)pasteObject(DataFlavor.stringFlavor);
    }  
    catch (Exception e) {
	System.err.println("Error getting String from clipboard: " + e);
    }
    return data;
  }
  
  Object pasteObject (DataFlavor flavor)  
  throws UnsupportedFlavorException, IOException
  {
    Object obj = null;
    getClipboard();
    
    Transferable content = clipboard.getContents(null);
    if (content != null)
    obj = content.getTransferData(flavor);
    
    return obj;
  }
}
