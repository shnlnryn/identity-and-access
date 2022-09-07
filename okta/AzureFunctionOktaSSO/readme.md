###Manual Deployment of Azure Functions
Use the following step-by-step instructions to deploy the Okta SSO connector manually with Azure Functions.

1. Create a Function App

From the Azure Portal, navigate to Function App, and select + Add.
In the Basics tab, ensure Runtime stack is set to Powershell Core.
In the Hosting tab, ensure the Consumption (Serverless) plan type is selected.
Make other preferrable configuration changes, if needed, then click Create.

2. Import Function App Code

In the newly created Function App, select Functions on the left pane and click + Add.

Select Timer Trigger.

Enter a unique Function Name and change the default cron schedule to every 10 minutes, then click Create.

Click on Code + Test on the left pane.

Copy the Function App Code and paste into the Function App run.ps1 editor.

Click Save.

3. Configure the Function App

In the Function App, select the Function App Name and select Configuration.

In the Application settings tab, select + New application setting.

Add each of the following five (5) application settings individually, with their respective string values (case-sensitive):

 apiToken
 workspaceID
 workspaceKey
 uri
 logAnalyticsUri (optional)
Use the following schema for the uri value: https://<OktaDomain>/api/v1/logs?since= Replace <OktaDomain> with your domain. 
 
 Click here for further details on how to identify your Okta domain namespace. There is no need to add a time value to the URI, the Function App will dynamically append the inital start time of logs to UTC 0:00 for the current UTC date as time value to the URI in the proper format.
 
Note: If using Azure Key Vault secrets for any of the values above, use the@Microsoft.KeyVault(SecretUri={Security Identifier})schema in place of the string values. Refer to Key Vault references documentation for further details.
 
Use logAnalyticsUri to override the log analytics API endpoint for dedicated cloud. For example, for public cloud, leave the value empty; for Azure GovUS cloud environment, specify the value in the following format: https://
 
Once all application settings have been entered, click Save.
