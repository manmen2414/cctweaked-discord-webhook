local DiscordWebhook = {};
---@param url string The url of this webhook
function DiscordWebhook.new(url)
  ---@class DiscordWebhook
  local instance = {
    --- The url of this webhook.
    url = url,
    --- Custom name of webhook instance.
    username = nil,
    --- Custom avater of webhook instance.
    avatarUrl = nil,
    --- Send message to webhook.
    send = require("cctweaked-discord-webhook.webhook.send")
  };
  ---@param newURL string
  function instance.setURL(self, newURL)
    self.url = newURL;
    return self;
  end

  return instance;
end

return DiscordWebhook
