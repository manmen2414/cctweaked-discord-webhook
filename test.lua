local webhook = require("cctweaked-discord-webhook")
local url = require("url");
local pretty = require "cc.pretty"

local instance = webhook.DiscordWebhook.new(url);

print("[1] Normal send test")
pretty.pretty_print(instance:send("[1] Normal send test", true))

sleep(0.5)

print("[2] Changed instance name and avater send test")
instance.username = "cctweaked-webhook2"
instance.avatarUrl = "https://gakuen.idolmaster-official.jp/assets/distribution/icon/icon_G.png";
pretty.pretty_print(instance:send("[2] Changed instance name and avater send test", true))

sleep(0.5)

print("[3] Changed message name and avater send test")
pretty.pretty_print(instance:send({
  content = "[3] Changed message name and avater send test",
  username = "cctweaked-webhook3",
  avaterUrl = "https://gakuen.idolmaster-official.jp/assets/distribution/icon/icon_I.png"
}, true))

sleep(0.5)

print("[4] Error: wrong URL")
local badInstance = webhook.DiscordWebhook.new("https");
pretty.pretty_print(badInstance:send({
  content = "[4] Error: wrong URL",
}, true))

sleep(0.5)

print("[5] Error: wrong Token")
badInstance.url = instance.url .. "hogehogefugafuga";
pretty.pretty_print(badInstance:send({
  content = "[5] Error: wrong URL",
}, true))

sleep(0.5)
