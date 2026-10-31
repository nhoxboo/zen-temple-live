Set WshShell = CreateObject("WScript.Shell")
WshShell.CurrentDirectory = "E:\hermes-workspace\zen-temple-live\live"
WshShell.Run "node server.mjs", 0, False
