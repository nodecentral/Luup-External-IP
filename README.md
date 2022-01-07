# Luup-ExternalIP

# Scope

This is a Luup plugin to record your External IP

Luup (Lua-UPnP) is a software engine which incorporates Lua, a popular scripting language, and UPnP, the industry standard way to control devices. Luup is the basis of a number of home automation controllers e.g. Micasaverde Vera, Vera Home Control, OpenLuup.

# Compatibility

This plug-in has been tested on the Ezlo Vera Home Control system.

# Features

It supports the following functions:

* Creation a device in UI showing your external IP address
* Updates variables whenever your address changes so you have a record of your previous one.

Still to be added..

* Add a button to refresh IP on demand
* Add addiitonal variable to show other network related information
* other fixes/updates

# Imstallation / Usage

This installation assumes you are running the latest version of Vera software.

1. Upload the two icon .png files to the appropriate storage location on your controller. For Vera that's `/www/cmh/skins/default/icons`
3. Upload the .xml and .json file in the repository to the appropriate storage location on your controller. For Vera that's via Apps/Develop Apps/Luup files/
4. Create the decice instance via the appropriate route. For Vera that's Apps/Develop Apps/Create Device/ and putting "D_ExternalIP1.xml" into the Upnp Device Filename box. 
5. Reload luup to establish the device and then reload luup again (just to be sure) and you should be good to go.

# Limitations

While it has been tested, it has not been tested very much and may not support other related devices or those running different firmware.

# Buy me a coffee

If you choose to use/customise or just like this plug-in, feel free to say thanks with a coffee or two.. 
(God knows I drank enough working on this :-)) 

<a href="https://www.paypal.me/nodezero" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>

# Screenshots

Once installed, you should see the device listed with your ExternalIP

![3168B647-7CF9-4440-8E58-B5D9A2B63814](https://user-images.githubusercontent.com/4349292/148536263-f20b7416-9578-40cc-995c-447560da538e.jpeg)


# License

Copyright © 2021 Chris Parker (nodecentral)

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see http://www.gnu.org/licenses
