{
   "Events" : [
      {
         "Action" : "down",
         "Button" : 104,
         "Delay" : "109",
         "Type" : 10
      },
      {
         "Action" : "up",
         "Button" : 104,
         "Delay" : "1",
         "Type" : 10
      }
   ],
   "Guid" : "2025_09_13_19_58_26_193",
   "MacroName" : "macro_1",
   "Version" : 64
}

v0103

i am looking to bind f13, f14 etc to a button, probably can only do it through a macro

For XBows Lite firmware **v0103**, use these button ID numbers in macro notation to send F13–F24 via the macro "press key" action:

- Button IDs (for assigning macros): **0 = LMB**, **1 = RMB**, **2 = MMB**, **3 = Button 4**, **4 = Button 5**, **5 = DPI toggle**, **6 = Macro/profile switch**

To send F13–F24 in a macro (v0103 macro keycodes), use these keycode values in the macro steps:

- **F13 = 0x68 (104 decimal)**  
- **F14 = 0x69 (105)**  
- **F15 = 0x6A (106)**  
- **F16 = 0x6B (107)**  
- **F17 = 0x6C (108)**  
- **F18 = 0x6D (109)**  
- **F19 = 0x6E (110)**  
- **F20 = 0x6F (111)**  
- **F21 = 0x70 (112)**  
- **F22 = 0x71 (113)**  
- **F23 = 0x72 (114)**  
- **F24 = 0x73 (115)**

Example macro sequence (pseudocode for v0103 macro format):
```
PRESS_KEY 0x68    // Press F13
DELAY 50
RELEASE_KEY 0x68  // Release F13
```

If you tell me the macro editor or exact file format you're using (JSON, hex, or the XBows GUI format), I can produce the exact lines to paste into your macro.