-- WARNING:  This file gets overwritten by the 'flexprompt configure' wizard!
--
-- If you want to make changes, consider copying the file to
-- 'flexprompt_config.lua' and editing that file instead.

flexprompt.settings.left_prompt = "{histlabel}{cwd:type=rootsmart:shorten=70}{git:nountracked}{npm:smartname:color=1;38;5;208}{nodejs:color=green}"
flexprompt.settings.lean_separators = "space"
flexprompt.settings.use_home_tilde = true

flexprompt.settings.symbols.npm_module = "📦"
flexprompt.settings.symbols.git_module = ""

local _, _, ret = os.execute("net session 1>nul 2>nul")
local isAdmin = ret == 0

flexprompt.settings.symbols.prompt = isAdmin and "⚡" or "λ"
