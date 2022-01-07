module("L_ExternalIP1", package.seeall)

local PV = "0.2" -- plugin version number
local COM_SID = "urn:nodecentral-net:serviceId:ExternalIP1"

function log(msg) 
	luup.log("ExtIP: " .. msg)
end

function refreshExternalIP(lul_device)
	local time = os.time()
	
	local status, ip = luup.inet.wget("https://api.ipify.org/?format=txt")
	local liveIP = ip: match "%d+%.%d+%.%d+%.%d+"
	log("External IP address check returned = " ..liveIP)
	
	local existingIP, lastUpdateTime1 = luup.variable_get(COM_SID,"Current External IP", lul_device)
	local previousIP, lastUpdateTime2 = luup.variable_get(COM_SID,"Previous External IP", lul_device)
	
	luup.variable_set(COM_SID, "Last Checked", time , lul_device)
	luup.variable_set(COM_SID, "Last Checked HR", time , lul_device)
	
	if liveIP ~= existingIP then
		log("External IP has changed from " ..existingIP .. " to " ..liveIP)
		luup.variable_set(COM_SID, "Previous External IP", existingIP, lul_device)
		luup.variable_set(COM_SID, "Current External IP", liveIP, lul_device)
		luup.variable_set(COM_SID, "Last Changed", time , lul_device)
		luup.variable_set(COM_SID, "Last Changed HR", time , lul_device)
	else 
		log("External IP Address has NOT changed")
	end
	
	luup.call_delay ("refreshExternalIP", 86400) -- Check if the IP address has changed ever 24hours

end

local function populateFixedVariables(lul_device)
	log("Setting up plugins variables for ... DevNo = " ..lul_device)
	luup.variable_set(COM_SID, "PluginStatus", "Plugin variables being set up 2/2", lul_device)
	
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
	refreshExternalIP(lul_device)
end

function ExternalIPStartUp(lul_device)
	log("Setting up plugin.... DevNo = " ..lul_device)
	luup.variable_set(COM_SID, "Icon", 0, lul_device)
	luup.variable_set(COM_SID, "PluginVersion", PV, lul_device)
	luup.variable_set(COM_SID, "Debug", true, lul_device)
	luup.variable_set(COM_SID, "PluginStatus", "Plugin being installed 1/2 ", lul_device)
	populateFixedVariables(lul_device)
end