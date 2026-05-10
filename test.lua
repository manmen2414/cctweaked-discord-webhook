local args = { ... };

local webhook = require("cctweaked-discord-webhook")
local url = require("url");
local pretty = require "cc.pretty"

local textWebhook = webhook.DiscordWebhook.new(url.text);
local forumWebhook = webhook.DiscordWebhook.new(url.forum);
local badWebhook = webhook.DiscordWebhook.new("https");

local messageObject = nil;

local function test10()
  print("[10] Wait message object");

  local result = textWebhook:send({
    content = "[10] Wait message object",
    getSentMessage = true
  }, true);

  pretty.pretty_print(result);

  messageObject = result.message;
end

local tests = {

  function()
    print("[1] Normal send test");
    pretty.pretty_print(textWebhook:send("[1] Normal send test", true));
  end,
  function()
    print("[2] Changed instance name and avater send test");

    textWebhook.username = "cctweaked-webhook2"
    textWebhook.avatarUrl = "https://gakuen.idolmaster-official.jp/assets/distribution/icon/icon_G.png";

    pretty.pretty_print(textWebhook:send("[2] Changed instance name and avater send test", true));

    textWebhook.username = nil;
    textWebhook.avatarUrl = nil;
  end,
  function()
    print("[3] Changed message name and avater send test");

    textWebhook.username = "cctweaked-webhook2"
    textWebhook.avatarUrl = "https://gakuen.idolmaster-official.jp/assets/distribution/icon/icon_G.png";

    pretty.pretty_print(textWebhook:send({
      content = "[3] Changed message name and avater send test",
      username = "cctweaked-webhook3",
      avaterUrl = "https://gakuen.idolmaster-official.jp/assets/distribution/icon/icon_I.png"
    }, true));

    textWebhook.username = nil;
    textWebhook.avatarUrl = nil;
  end,
  function()
    print("[4] Error: wrong URL");

    pretty.pretty_print(badWebhook:send({
      content = "[4] Error: wrong URL",
    }, true));
  end,
  function()
    print("[5] Error: wrong Token");

    badWebhook.url = textWebhook.url .. "hogehogefugafuga";
    pretty.pretty_print(badWebhook:send({
      content = "[5] Error: wrong URL",
    }, true));
  end,
  function()
    print("[6] Add thread");

    pretty.pretty_print(forumWebhook:send({
      content = "[6] Add thread",
      threadName = "[6] " .. tostring(os.date()),
    }, true));
  end,
  function()
    print("[7] Add thread with tags");

    local tags = { "1502996181960097822" };

    pretty.pretty_print(forumWebhook:send({
      content = "[7] Add thread with tags",
      threadName = "[7] " .. tostring(os.date()),
      appliedTags = tags
    }, true));
  end,
  function()
    local threadId = "1502996102734020729";

    print("[8] Send to thread");
    pretty.pretty_print(forumWebhook:send({
      content = "[8] Send to thread",
      threadId = threadId
    }, true));
  end,
  function()
    print("[9] Disable Backslash escape");

    pretty.pretty_print(textWebhook:send({
      content =
      "[9] \\u30d0\\u30c3\\u30af\\u30b9\\u30e9\\u30c3\\u30b7\\u30e5\\u30a8\\u30b9\\u30b1\\u30fc\\u30d7\\u306e\\u7121\\u52b9\\u5316",
      noEscapeBackslash = true
    }, true));
  end,
  test10,
  function()
    print("[11] Edit message");

    if not messageObject then
      test10(); sleep(1);
    end
    if not messageObject then
      error("cannot edit message because test10 wasn't successed.")
    end

    pretty.pretty_print(
      textWebhook:edit(
        messageObject.id, {
          content =
          "[11] Edit message",
        }, true
      )
    );
  end,
  function()
    print("[12] Delete message");

    if not messageObject then
      test10(); sleep(1);
    end
    if not messageObject then
      error("cannot edit message because test10 wasn't successed.")
    end

    pretty.pretty_print(
      textWebhook:deleteMessage(messageObject.id, true)
    );
  end,
}

if #args == 0 then
  for index, test in ipairs(tests) do
    test();
  end
end

for index, testId in ipairs(args) do
  tests[tonumber(testId)]();
end
