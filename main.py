import tkinter as tk
import keyboard
import threading

def __init__(self):
    self.root = tk.Tk()
    self.root.attributes("-fullscreen", True)
    self.root.config(bg="black")
    self.root.overrideredirect(True)
    self.root.geometry("1920x1080+0+0")
    self.overlay_visible = False

    self.hotkey_thread = threading.Thread(target=self.listen_for_hotkey)
    self.hotkey_thread.daemon = True
    self.hotkey_thread.start()

def toggle_overlay(self):
    if self.overlay_visible:
        self.root.withdraw()
        self.overlay_visible = False
    else:
        self.root.deiconify()
        self.overlay_visible = True

def listen_for_hotkey(self):
    keyboard.add_hotkey('ctrl+shift+b', self.toggle_overlay)

def run(self):
    self.root.mainloop()
