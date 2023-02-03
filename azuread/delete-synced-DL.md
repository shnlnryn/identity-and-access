# Removing or editing a sync'd DL or group may not be possible if old directly is no longer active or not syncing. To add members or edit, delete the DL #using legacy remove-msolgroup powershell then recreate the Dl if required.
#Don't forget to get all aliases first before deletion through Exchange shell.

remove-msolgroup -objectid 'getObjectID from AzureAD'
