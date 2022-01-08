module("L_ExternalIP1", package.seeall)

local PV = "0.3" -- plugin version number
local COM_SID = "urn:nodecentral-net:serviceId:ExternalIP1"

function log(msg) 
	luup.log("ExtIP: " .. msg)
end

function refreshExternalIP(lul_device)
	log("Refreshing Address for #" ..lul_device)
	
	local deviceID = tonumber(lul_device)
	local time = os.time()
	local HRtime = os.date( "%d/%m @ %H:%M" , time )
	local PollPeriod = luup.variable_get(COM_SID, "Poll Period", deviceID)
	log("PollPeriod = " .. PollPeriod)
	
	local status, ip = luup.inet.wget("https://api.ipify.org/?format=txt")
	local liveIP = ip: match "%d+%.%d+%.%d+%.%d+"
	log("Address check returned = " ..liveIP)
	
	local existingIP = luup.variable_get(COM_SID,"Current External IP", deviceID)
	log("Existing IP = " .. existingIP)
	
	local previousIP = luup.variable_get(COM_SID,"Previous External IP", deviceID)
	log("previousIP = " .. previousIP)
	
	luup.variable_set(COM_SID, "Last Checked", time , deviceID)
	luup.variable_set(COM_SID, "Last Checked HR", HRtime , deviceID)
	
	if liveIP ~= existingIP then
		log("Address has changed from " .. existingIP .. " to " ..liveIP)
		luup.variable_set(COM_SID, "Previous External IP", existingIP, deviceID)
		luup.variable_set(COM_SID, "Current External IP", liveIP, deviceID)
		luup.variable_set(COM_SID, "Last Changed", time , deviceID)
		luup.variable_set(COM_SID, "Last Changed HR", HRtime , deviceID)
		log("External IP Address has been updated")
	else 
		log("External IP Address has NOT changed")
	end
	
	luup.call_delay ("NC_RefreshMyExtIP", PollPeriod, deviceID) -- period to check if IP address has changed
end


local function populateFixedVariables(lul_device)
	log("Setting up fixed variables for ... DevNo = " ..lul_device)
	luup.variable_set(COM_SID, "PluginStatus", "Plugin variables being set up 2/3", lul_device)
	
	local CurrExternalIP = luup.variable_get(COM_SID, "Current External IP", lul_device)
		if (CurrExternalIP == nil) then luup.variable_set(COM_SID, "Current External IP", "0.0.0.0" , lul_device) end
	
	local PrevExternalIP = luup.variable_get(COM_SID, "Previous External IP", lul_device)
		if (PrevExternalIP == nil) then luup.variable_set(COM_SID, "Previous External IP", "0.0.0.0" , lul_device) end
	
	local LastChanged = luup.variable_get(COM_SID, "Last Changed", lul_device)
		if (LastChanged == nil) then luup.variable_set(COM_SID, "Last Changed", 0 , lul_device) end
		
	local LastChangedHR = luup.variable_get(COM_SID, "Last Changed HR", lul_device)
		if (LastChangedHR == nil) then luup.variable_set(COM_SID, "Last Changed HR", "Date" , lul_device) end
	
	local LastChecked = luup.variable_get(COM_SID, "Last Checked", lul_device)
		if (LastChecked == nil) then luup.variable_set(COM_SID, "Last Checked", 0 , lul_device) end
	
	local LastCheckedHR = luup.variable_get(COM_SID, "Last Checked HR", lul_device)
		if (LastCheckedHR == nil) then luup.variable_set(COM_SID, "Last Checked HR", "Date" , lul_device) end
		
	local PollPeriod = luup.variable_get(COM_SID, "Poll Period", lul_device)
		if (PollPeriod == nil) then luup.variable_set(COM_SID, "Poll Period", 86400 , lul_device) end
	
	luup.variable_set(COM_SID, "PluginStatus", "Plugin variables are set up 3/3"
	
		refreshExternalIP(lul_device)
		
end

function ExternalIPStartUp(lul_device)
	log("Setting up plugin.... DevNo = " ..lul_device)
	luup.variable_set(COM_SID, "Icon", 0, lul_device)
	luup.variable_set(COM_SID, "PluginVersion", PV, lul_device)
	luup.variable_set(COM_SID, "Debug", true, lul_device)
	luup.variable_set(COM_SID, "PluginStatus", "Plugin being installed 1/3 ", lul_device)
	populateFixedVariables(lul_device)
end