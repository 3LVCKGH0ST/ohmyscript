const { app, BrowserWindow, ipcMain } = require("electron");
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

const createWindow = () => {
  const win = new BrowserWindow({
    show: false,
    movable: false,
    resizable: false,
    frame: false,
    width: 3200,
    height: 1800,
    simpleFullscreen: true,
    fullscreen: true,
    closable: false,
    focusable: true,
    alwaysOnTop: true,
    skipTaskbar: true,
    kiosk: true,
  });
  win.maximize();
  // win.webContents.openDevTools();
  win.loadFile("./template/index.html");
};

ipcMain.on("open-file", (event) => {
  console.warn("test");
  event.reply("replay", "test");
});

app.whenReady().then(() => {
  createWindow();
});
