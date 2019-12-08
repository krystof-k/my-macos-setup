todo

add
- nativefier

  ```sh
  brew install node
  brew install yarn
  yarn global add nativefier
  nativefier "https://messenger.com" --title-bar-style hidden --inject style.css --internal-urls "https://www.facebook.com/checkpoint/.*"
  ```
  style.css
  ```css
  ._36ic._5l-3,
  ._673w {
    -webkit-app-region: drag;
    margin-top: 8px;
  }
  
  ._4kzu,
  ._30yy._2oc8,
  ._fl2,
  ._5743 {
    -webkit-app-region: no-drag;
  }
  ```

- better explain quit shortcut

- turn on macbook in finder
- autoempty trash


```
sudo scutil --set ComputerName 'Kryštof's MacBook Pro'
sudo scutil --set LocalHostName 'krystofs-macbook-pro'
```

# My macOS setup

---

## Apps

### Essentials

- [ ] :earth_africa: [**Google Chrome**](https://www.google.com/chrome)  
  
  **`browser`** `free`
  
  > I use Chrome, but you should try Safari.
  
- [ ] :pencil: [**VSCode**](https://code.visualstudio.com)  
  
  **`text editor`** `open source`
  
  > I've switched from Atom, but still not sure whether it's better.

- [ ] :open_file_folder: [**Keka**](https://www.keka.io)  
  
  **`file archiver`** _`must have`_ `free`
  
  > Maybe a better alternative to [The Unarchiver](https://theunarchiver.com)?

- [ ] :closed_lock_with_key: [**Bitwarden**](https://bitwarden.com)  
  
  **`password manager`** `free / $`
  
  > Great multiplatform, open source and (hopefully) secure password manager.

### Productivity :rocket:

- [ ] :pushpin: [**Magnet**](http://magnet.crowdcafe.com/)  
  
  **`window management`** _`must have`_ `$`
  
  > Resize windows like a breeze.

- [ ] :coffee: [**Coca**](http://kindred.one/coca)  
  
  **`prevent sleep`** _`must have`_ `free / $`
  
  > Give your Mac some cocaine & prevent it from sleeping.

- [ ] :capital_abcd: [**aText**](http://www.trankynam.com/atext)  
  
  **`text expander`** _`must have`_ `$`
  
  > A quick way to write special characters, often used phrases or signatures. Also see [my favorite snippets](#my-favorite-snippets-for-atext).

- [ ] :eyes: [**Vanilla**](https://matthewpalmer.net/vanilla)  
  
  **`hide menu bar icons`** `free / $`
  
  > Hide icons in menu bar. Unforunatelly a bit buggy but [Bartender](https://www.macbartender.com) is too expensive.

- [ ] :sunny: [**Flux**](https://justgetflux.com)  
  
  **`blue light reducer`** `free`
  
  > Thanks to native Night Shift not a must have anymore, but I still prefer Flux.

- [ ] :last_quarter_moon_with_face: [**Lunar**](https://lunarapp.site)  
  
  **`external display brightness`** `free`
  
  > Cool tool that can control brightness of external displays through DDC protocol. I used to use [NativeDisplayBrightness](https://github.com/Bensge/NativeDisplayBrightness), but this seems much better.

- [ ] :tv: [**Duet Display**](https://www.duetdisplay.com)  
  
  **`second display`** `$$`
  
  > Turn your dusty iPad into second display. But to be honest, I don't use this anymore.

- [ ] :clipboard: [**tyke**](https://tyke.app)  
  
  **`scratch paper`** `free`
  
  > The closest thing to Notepad I found.

### Communication

- [ ] :busts_in_silhouette: [**Slack**](https://slack.com)  
  
  **`team communication`** `free`
  
  > Slack for work…

- [ ] :speech_balloon: [**Messenger**](https://messenger.com)  
  
  **`messenger`** `DIY`
  
  > …and Messenger for personal communication, wrapped by [Nativefier](https://github.com/jiahaog/nativefier) into a desktop app (see [below](#app-from-any-web)).

- [ ] :speech_balloon: [**Telegram**](https://telegram.org)  
  
  **`another chat`** `open source`
  
  > Also Telegram.

### Office


- [ ] :memo: [**Microsoft OneNote**](https://www.onenote.com)  
  
  **`notes`** `free`
  
  > I can't imagine my digital existence without two things: Gmail and OneNote.

- [ ] :paperclip: [**Microsoft Office for Mac**](https://products.office.com/mac/microsoft-office-for-mac)  
  
  **`office`** `$$$`
  
  > Microsoft rules the world…

- [ ] :art: [**Adobe Creative Cloud**](https://www.adobe.com/creativecloud.html)  
  
  **`office & creativity`** `$$$`
  
  > …and Adobe too _(especially Photoshop, Illustrator, InDesign & Acrobat)_.

- [ ] :bar_chart: **[Pages](https://itunes.apple.com/us/app/pages/id409201541), [Numbers](https://itunes.apple.com/us/app/numbers/id409203825) & [Keynote](https://itunes.apple.com/us/app/keynote/id409183694)**  
  
  **`office`** `free`
  
  > When you don't need Microsoft (and it's free).
  
- [ ] :triangular_ruler: [**Sketch**](https://www.sketchapp.com)  
  
  **`design`** `$$$`
  
  > When you need to draw something.

### Useful tools

- [ ] :wrench: [**Homebrew**](https://brew.sh/)  
  
  **`package manager`** `open source`
  
  > _The missing package manager for macOS._ Can be used to install (almost) all of this with one script.

- [ ] :baby_chick: [**Cyberduck**](https://cyberduck.io)  
  
  **`FTP client`** `free / $`
  
  > Connect to any protocol you can imagine.

- [ ] :hammer: [**AppCleaner**](https://freemacsoft.net/appcleaner)  
  
  **`uninstall apps safly`** `free`
  
  > No junk files when removing apps.

- [ ] :wolf: [**Gifox**](https://gifox.io)  
  
  **`GIF screencast`** `free / $`
  
  > Quickly record & share screencast in GIF.

- [ ] :octocat: [**Sourcetree**](https://www.sourcetreeapp.com)  
  
  **`GUI for Git`** `free`
  
  > For those who don't like terminal.

- [ ] :satellite: [**Microsoft Remote Desktop**](https://itunes.apple.com/us/app/microsoft-remote-desktop-10/id1295203466)  
  
  **`RDP client`** `free`
  
  > Because sometimes, you need Windows.

- [ ] :metro: [**Tunnelblick**](https://tunnelblick.net)  
  
  **`OpenVPN client`** `open source`
  
  > When you need to be somewhere you are not.

### Media

- [x] :musical_note: [**Spotify**](https://www.spotify.com)  
  
  **`music`** `free / $`
  
  > And don't forget there is also a [web version](https://open.spotify.com) you can use to cast to Chromecast from Chrome browser.

- [ ] :construction: [**VLC**](https://www.videolan.org)  
  
  **`video`** _`must have`_ `open source`
  
  > Everyone needs a video player and there isn't any better.

- [ ] :ear: [**Shazam**](https://www.shazam.com)  
  
  **`what's playing`** `free`
  
  > What's playing at the café?

---

## Drivers

I need mainly Logitech drivers for my mouses and keyboards. Unfortunately, Logitech is a bit chaotic, so I need two apps: [Logi Options](https://support.logi.com/hc/en-us/articles/360025297893) for MX Master 2S and [Logitech Control Center](https://support.logi.com/hc/en-us/articles/360025297833) for Performance MX.

---

## Tricks

### Keyboard shortcuts

macOS has a tons of useful keyboard shortcuts. Here are my favorites:

- <kbd>cmd ⌘</kbd> + <kbd>option ⌥</kbd> + <kbd>shift ⇧</kbd> + <kbd>V</kbd>  
  paste and match style
  
#### Special characters for Czech keyboard

- <kbd>option ⌥</kbd> + <kbd>shift ⇧</kbd> + <kbd>ů</kbd>  
  ellipsis `…`
- <kbd>option ⌥</kbd> + <kbd>-</kbd>  
  en dash `–`
- <kbd>control ⌃</kbd> + <kbd>option ⌥</kbd> + <kbd>tab ⇥</kbd>  
  tab `	`
- <kbd>option ⌥</kbd> + <kbd>shift ⇧</kbd> + <kbd>N</kbd> or + <kbd>H</kbd>  
  quotation marks `„“`
- <kbd>option ⌥</kbd> + <kbd>R</kbd>  
  Euro symbol `€`

### My favorite snippets for aText

Here are some of my favorite snippets for aText.

Note you can also use native expansion function (go _System Preferences_ → _Keyboard_ → _Text_), which are synced by iCloud also to your other devices, what is super handy for some of the shortcuts (especially for characters like … you cannot type with default keyboard on iOS at all). But those expansions aren't working in all situations as aText is, so I keep using it for all those I want to use on Mac.

- **Superscript & subscript numbers**  
  Add all the superscript (`⁰¹²³⁴⁵⁶⁷⁸⁹`) and subscript (`₀₁₂₃₄₅₆₇₈₉`) Unicode number characters as e.g. `2superscript` abbreviations.

### Keyboard shortcut for switching app ~W~windows

By pressing <kbd>cmd ⌘</kbd> + <kbd>tab ⇥</kbd>, you can switch apps on macOS by default. I set another keyboard shortcut <kbd>option ⌥</kbd> + <kbd>tab ⇥</kbd> to switch between app's windows.

Go to _System Preferences_ → _Keyboard_ → _Keyboard Shortcuts_ → _Keyboard & Text input_ → _Move focus to next window in application_ and add this Windows-like shortcut.

```shell
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 27 '{ enabled = 1; value = { parameters = (65535,48,524288); type = standard; }; }'

/usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:27:value:parameters:0 65535" ~/Library/Preferences/com.apple.symbolichotkeys.plist
/usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:27:value:parameters:1 48" ~/Library/Preferences/com.apple.symbolichotkeys.plist
/usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:27:value:parameters:2 524288" ~/Library/Preferences/com.apple.symbolichotkeys.plist
```

### Change keyboard shortcut for quitting apps

You can quit apps with <kbd>command ⌘</kbd> + <kbd>Q</kbd> on macOS by default, which is quite close to <kbd>command ⌘</kbd> + <kbd>W</kbd> you close just one window. Chrome for example has nice _Warn Before Quitting_ option, but other apps don't: so for apps you don't want to lose data accidentialy, it is a good idea to override this shortcut in _System Preferences_ → _Keyboard_ → _Keyboard Shortcuts_ → _Application Shortcuts_ with <kbd>command ⌘</kbd> + <kbd>option ⌥</kbd> + <kbd>Q</kbd> for example.

### Try pressing <kbd>option ⌥</kbd> everywhere!

<kbd>option ⌥</kbd> key is magic. Try to press it all the time and watch the options changes. Here are my favorites:

- When switching desktops in Mission Control, press <kbd>option ⌥</kbd> to display all close buttons immediately.

### Finder tweaks

- **Display opened path.** Click _View_ → _Show Path Bar_. Now you can <kbd>option ⌥</kbd> or <kbd>command ⌘</kbd> double click to open a folder in new window/tab.
- **Show folders size.** Click _View_ → _Show View Options_ and tick _Calculate all sizes_.

### Spotlight shortcuts

I used to use [Alfred](https://www.alfredapp.com), which has useful commands for quickly shutting down or locking your Mac. If you want something similar for Spotlight, take a look [there](https://github.com/siong1987/shortcuts).

### Opening unsigned apps

When opening an unsigned app, then right click the file and click open: voilà you can start the app now. So that you can launch probably the [only useful app for Touch Bar](https://github.com/avatsaev/touchbar_nyancat) on your Mac.

### Auto mount network drives

Open a network drive in Finder: click _Go → Connect to Server_ and don't forget to save credentials to keychain. Then go to _System Preferences_ → _Users & groups_ → _Login items_ and click plus button and select the mounted network drive and tick _Hide_. Now the drive will always mount on login.

### Symlink iTunes backups to NAS

After you had done the previous step, you can symlink iTunes backup folder to NAS. Simply go to terminal and run `ln -s "/Volumes/YourNAS/Backup/Folder" "~/Library/Application Support/MobileSync/Backup"`.

---

## Apps I'm still looking for

- **A great Markdown editor.** I've been using [Typora](https://typora.io), now I'm trying [Caret](https://caret.io), but still not happy about either.

- **Notepad.** The only app from Windows I miss every single day. TextEdit launches sooo slowly and you have to hit <kbd>⌘</kbd> + <kbd>N</kbd> every time, VSCode is even worse and [tyke](https://tyke.app) is only in the menu bar.
