---@param settings MessageSendSettings
---@param self DiscordWebhook
return function(self, settings)
  local payload = {
    url = self.url,
    content = "__CCTWEAKED_DISCORD_WEBHOOK_CONTENT__",
    username = self.username,
    avatar_url = self.avatarUrl,
  };
  local queryPrefix = "?"
  if not settings.noEscapeBackslash then
    payload.content = settings.content
  end
  if settings.username then
    payload.username = settings.username;
  end
  if settings.avaterUrl then
    payload.avatar_url = settings.avaterUrl;
  end
  if settings.threadName then
    payload.thread_name = settings.threadName;
  end
  if settings.appliedTags then
    payload.applied_tags = settings.appliedTags;
  end
  if settings.threadId then
    payload.url = payload.url .. queryPrefix .. "thread_id=" .. settings.threadId;
    queryPrefix = "&";
  end
  if settings.getSentMessage then
    payload.url = payload.url .. queryPrefix .. "wait=true";
    queryPrefix = "&";
  end
  return payload;
end
