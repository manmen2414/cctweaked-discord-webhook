local webhook = require("cctweaked-discord-webhook")
local url = require("url");
local pretty = require "cc.pretty"

local textWebhook = webhook.DiscordWebhook.new(url.text);
local forumWebhook = webhook.DiscordWebhook.new(url.forum);

print("[1] Normal send test");
pretty.pretty_print(textWebhook:send("[1] Normal send test", true));

sleep(0.5);

print("[2] Changed instance name and avater send test");
textWebhook.username = "cctweaked-webhook2"
textWebhook.avatarUrl = "https://gakuen.idolmaster-official.jp/assets/distribution/icon/icon_G.png";
pretty.pretty_print(textWebhook:send("[2] Changed instance name and avater send test", true));

sleep(0.5);

print("[3] Changed message name and avater send test");
pretty.pretty_print(textWebhook:send({
  content = "[3] Changed message name and avater send test",
  username = "cctweaked-webhook3",
  avaterUrl = "https://gakuen.idolmaster-official.jp/assets/distribution/icon/icon_I.png"
}, true));

textWebhook.username = nil;
textWebhook.avatarUrl = nil;

sleep(0.5)

print("[4] Error: wrong URL");
local badWebhook = webhook.DiscordWebhook.new("https");
pretty.pretty_print(badWebhook:send({
  content = "[4] Error: wrong URL",
}, true));

sleep(0.5);

print("[5] Error: wrong Token");
badWebhook.url = textWebhook.url .. "hogehogefugafuga";
pretty.pretty_print(badWebhook:send({
  content = "[5] Error: wrong URL",
}, true));

sleep(0.5);

print("[6] Add thread");
pretty.pretty_print(forumWebhook:send({
  content = "[6] Add thread",
  threadName = "[6] " .. tostring(os.date()),
}, true));

sleep(0.5);

local tags = { "1502996181960097822" };
print("[7] Add thread with tags");
pretty.pretty_print(forumWebhook:send({
  content = "[7] Add thread with tags",
  threadName = "[7] " .. tostring(os.date()),
  appliedTags = tags
}, true));

sleep(0.5);

local threadId = "1502996102734020729";
print("[8] Send to thread");
pretty.pretty_print(forumWebhook:send({
  content = "[8] Send to thread",
  threadId = threadId
}, true));

print("[9] Disable Backslash escape");
pretty.pretty_print(textWebhook:send({
  content =
  "[9] \\u30d0\\u30c3\\u30af\\u30b9\\u30e9\\u30c3\\u30b7\\u30e5\\u30a8\\u30b9\\u30b1\\u30fc\\u30d7\\u306e\\u7121\\u52b9\\u5316",
  noEscapeBackslash = true
}, true));
