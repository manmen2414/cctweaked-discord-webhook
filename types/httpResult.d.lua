--- @meta

---@class MessageResult
---@field url string
---@field successed boolean
---@field message WebhookMessage|nil
---@field reason MessageFailureReason|nil
---@field errorResponse table|nil

---@alias MessageFailureReason
---| "Could not connect"
---| "Bad Request" 400
---| "Wrong Token" 401
---| "Not Found" 403
---| "Too Many Requests" 429
