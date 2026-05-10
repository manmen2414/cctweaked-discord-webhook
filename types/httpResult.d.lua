--- @meta

---@class MessageResult
---@field url string
---@field successed boolean
---@field message table|nil UNIMPLEMENTED
---@field reason MessageFailureReason|nil
---@field errorResponse table|nil UNIMPLEMENTED

---@alias MessageFailureReason
---| "Could not connect"
---| "Bad Request" 400
---| "Wrong Token" 401
---| "Not Found" 403
---| "Too Many Requests" 429
