const { app, BrowserWindow, ipcMain, powerSaveBlocker } = require("electron");
const fs = require("fs");
const express = require('express')
const Express = express()
const port = 3000

Express.get('/', (req, res) => {
  res.send(fs.readFileSync("./hostname", "utf8"))
})

Express.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})

const brightness = require('brightness');
 
brightness.get().then(level => {
    console.log(level);
    //=> 0.5
});
 
brightness.set(1).then(() => {
    console.log('Changed brightness to 80%');
});

const createWindow = () => {
  const win = new BrowserWindow({
    show: false,
    movable: false,
    resizable: false,
    frame: false,
    width: 3200,
    height: 1800,
    // simpleFullscreen: true,
    // fullscreen: true,
    // closable: false,
    // focusable: true,
    // alwaysOnTop: true,
    // skipTaskbar: true,
    // kiosk: true,
  });
  win.maximize();
  // win.webContents.openDevTools();
  win.loadFile("./template/index.html");
  win.focus();
};

ipcMain.on("open-file", (event) => {
  console.warn("test");
  event.reply("replay", "test");
});

const id = powerSaveBlocker.start('prevent-display-sleep')
console.log(powerSaveBlocker.isStarted(id))

app.whenReady().then(() => {
  createWindow();
});
