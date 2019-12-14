# Set Windows-like (option ⌥ + tab ⇥) keyboard shortcut for switching app windows
/usr/libexec/PlistBuddy -c 'Delete :AppleSymbolicHotKeys:27 dict' ~/Library/Preferences/com.apple.symbolichotkeys.plist
/usr/libexec/PlistBuddy -c 'Add :AppleSymbolicHotKeys:27 dict' ~/Library/Preferences/com.apple.symbolichotkeys.plist
/usr/libexec/PlistBuddy -c 'Add :AppleSymbolicHotKeys:27:enabled bool 1' ~/Library/Preferences/com.apple.symbolichotkeys.plist
/usr/libexec/PlistBuddy -c 'Add :AppleSymbolicHotKeys:27:value dict' ~/Library/Preferences/com.apple.symbolichotkeys.plist
/usr/libexec/PlistBuddy -c 'Add :AppleSymbolicHotKeys:27:value:type string standard' ~/Library/Preferences/com.apple.symbolichotkeys.plist
/usr/libexec/PlistBuddy -c 'Add :AppleSymbolicHotKeys:27:value:parameters array' ~/Library/Preferences/com.apple.symbolichotkeys.plist
/usr/libexec/PlistBuddy -c 'Add :AppleSymbolicHotKeys:27:value:parameters:0 integer 65535' ~/Library/Preferences/com.apple.symbolichotkeys.plist
/usr/libexec/PlistBuddy -c 'Add :AppleSymbolicHotKeys:27:value:parameters:1 integer 48' ~/Library/Preferences/com.apple.symbolichotkeys.plist
/usr/libexec/PlistBuddy -c 'Add :AppleSymbolicHotKeys:27:value:parameters:2 integer 524288' ~/Library/Preferences/com.apple.symbolichotkeys.plist
