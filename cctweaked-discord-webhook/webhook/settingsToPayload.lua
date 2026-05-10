---@param settings MessageSendSettings
---@param self DiscordWebhook
return function(self, settings)
  local payload = {
    content = settings.content,
    username = self.username,
    avatar_url = self.avatarUrl,
  };
  if settings.username then
    payload.username = settings.username
  end
  if settings.avaterUrl then
    payload.avatar_url = settings.avaterUrl
  end
  return payload;
end
