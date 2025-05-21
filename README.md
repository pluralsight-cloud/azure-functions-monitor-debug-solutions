# Monitoring and Debugging Azure Functions

Created by [Clint Bonnett](https://app.pluralsight.com/profile/author/clint-bonnett)


## Table of Contents

1. [Module 1](#module-1)
    1. [Clip 3 - Demo: Logging Custom Telemetry for Azure Functions](#clip-3---demo-logging-custom-telemetry-for-azure-functions)
    2. [Clip 4 - Demo: Visualizing Telemetry on Azure Functions](#clip-4---demo-visualizing-telemetry-on-azure-functions)
    3. [Clip 5 - Demo: Proactive Monitoring with Alerts on Azure Functions](#clip-5---demo-proactive-monitoring-with-alerts-on-azure-functions)
2. [Module 2](#module-2)
    1. [Clip 1 - Demo: Debugging Locally with Azure Functions Core Tools](#clip-1---demo-debugging-locally-with-azure-functions-core-tools)
    2. [Clip 2 - Demo: Debugging Azure Functions with VSCode](#clip-2---demo-debugging-azure-functions-with-vscode)
    3. [Clip 3 - Demo: Live Debugging Azure Functions in the Azure Portal](#clip-3---demo-live-debugging-azure-functions-in-the-azure-portal)
    4. [Clip 4 - Demo: Snapshot Debugging Azure Functions](#clip-4---demo-snapshot-debugging-azure-functions)
    5. [Clip 6 - Demo: Log Correlation with Azure Functions](#clip-6---demo-log-correlation-with-azure-functions)
  
---

## Module 1

### Clip 3 - Demo: Logging Custom Telemetry for Azure Functions

#### Follow-along steps (Cloud Playground Sandbox)
1. Start an [Azure Sandbox](https://app.pluralsight.com/hands-on/playground/cloud-sandboxes).
2. In an InPrivate or Incognito window log in to the Azure Sandbox using the provided credentials.
3. Open this repository in the same window.
4. Click the **Deploy to Azure** button. Make sure the link opens in the Sandbox browser tab.

   [![Deploy To Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fpluralsight-cloud%2Fazure-functions-monitor-debug-solutions%2Frefs%2Fheads%2Fmain%2F1.3%2Fcustomtelemetry.json)

5. Deploy the template.
6. Follow along with the demo.

7. Use the following command in a bash Azure Cloud Shell to deploy the function code.

```
RG=$(az group list --query "[0].name" -o tsv); \
APP=$(az functionapp list --resource-group $RG --query "[0].name" -o tsv); \
URL="https://github.com/pluralsight-cloud/azure-functions-monitor-debug-solutions/raw/refs/heads/main/1.3/customtelemetry.zip"; \
az functionapp deploy --resource-group $RG --name $APP --src-url $URL --type zip
```

8. Copy this JSON block to test the function.
```json
{
    "orderId":   "A123",
    "customerId":"C001",
    "items": [
       {"sku":"LAPTOP-17", "qty":1, "price":1299},
       {"sku":"MOUSE-BLK", "qty":2, "price":25}
    ]
}
```

---

### Clip 4 - Demo: Visualizing Telemetry on Azure Functions

#### Follow-along steps (Cloud Playground Sandbox)
1. Start an [Azure Sandbox](https://app.pluralsight.com/hands-on/playground/cloud-sandboxes).
2. In an InPrivate or Incognito window log in to the Azure Sandbox using the provided credentials.
3. Open this repository in the same window.
4. Click the **Deploy to Azure** button. Make sure the link opens in the Sandbox browser tab.

   [![Deploy To Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fpluralsight-cloud%2Fazure-functions-monitor-debug-solutions%2Frefs%2Fheads%2Fmain%2F1.3%2Fcustomtelemetry.json)

5. Deploy the template.
6. If you’re starting fresh and haven’t followed along with Clip 3, complete the following steps now.
	
 	1. Use the following command in a bash Azure Cloud Shell to deploy the function code. Wait 10 minutes for the deployment to finish. If you receive any errors, wait 5 minutes and run the command again.

	```
	RG=$(az group list --query "[0].name" -o tsv); \
	APP=$(az functionapp list --resource-group $RG --query "[0].name" -o tsv); \
	URL="https://github.com/pluralsight-cloud/azure-functions-monitor-debug-solutions/raw/refs/heads/main/1.3/customtelemetry.zip"; \
	az functionapp deploy --resource-group $RG --name $APP --src-url $URL --type zip
	```
 
	2. Head into the Function App and click on the **http function**.
	3. Click on **Test/Run** and paste in the following JSON block into the **body**, then click on **Run**. Wait 5 minutes for application insights to receive the logs.


	```json
	{
	    "orderId":   "A123",
	    "customerId":"C001",
	    "items": [
	       {"sku":"LAPTOP-17", "qty":1, "price":1299},
	       {"sku":"MOUSE-BLK", "qty":2, "price":25}
	    ]
	}
	``` 
 10. Follow along with the demo.

---

### Clip 5 - Demo: Proactive Monitoring with Alerts on Azure Functions

#### Follow-along steps (Cloud Playground Sandbox)
1. Start an [Azure Sandbox](https://app.pluralsight.com/hands-on/playground/cloud-sandboxes).
2. In an InPrivate or Incognito window log in to the Azure Sandbox using the provided credentials.
3. Open this repository in the same window.
4. Click the **Deploy to Azure** button. Make sure the link opens in the Sandbox browser tab.

   [![Deploy To Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fpluralsight-cloud%2Fazure-functions-monitor-debug-solutions%2Frefs%2Fheads%2Fmain%2F1.3%2Fcustomtelemetry.json)

5. Deploy the template.
6. If you’re starting fresh and haven’t followed along with Clip 4, complete the following steps now.
   
 	1. Use the following command in a bash Azure Cloud Shell to deploy the function code. Wait 10 minutes for the deployment to finish. If you receive any errors, wait 5 minutes and run the command again.

	```
	RG=$(az group list --query "[0].name" -o tsv); \
	APP=$(az functionapp list --resource-group $RG --query "[0].name" -o tsv); \
	URL="https://github.com/pluralsight-cloud/azure-functions-monitor-debug-solutions/raw/refs/heads/main/1.3/customtelemetry.zip"; \
	az functionapp deploy --resource-group $RG --name $APP --src-url $URL --type zip
	```
 
	2. Head into the Function App and click on the **http function**.
	3. Click on **Test/Run** and paste in the following JSON block into the **body**, then click on **Run**. Wait 5 minutes for application insights to receive the logs.


	```json
	{
	    "orderId":   "A123",
	    "customerId":"C001",
	    "items": [
	       {"sku":"LAPTOP-17", "qty":1, "price":1299},
	       {"sku":"MOUSE-BLK", "qty":2, "price":25}
	    ]
	}
	``` 
 
9. Follow along with the demo.
10. Copy this JSON block to test the 400 errors alert.

```json
{
    "orderId":   "A123",
    "customerId":"C001",
    "items": [
    ]
}
```

9. Copy this JSON block to test the order price alert.

```json
{
    "orderId":   "A123",
    "customerId":"C001",
    "items": [
       {"sku":"LAPTOP-MAC", "qty":1, "price":1800},
       {"sku":"MOUSE-FANCY", "qty":2, "price":250}
    ]
}
```



## Module 2

### Clip 1 - Demo: Debugging Locally with Azure Functions Core Tools

#### Follow-along steps (Local Environment)

1. Install the requirements for this demo:
	- [Python 3.12](https://www.python.org/downloads/release/python-3120/)
	- [Azure Function Core Tools](https://github.com/Azure/azure-functions-core-tools/blob/v4.x/README.md)

2. Download the function app code [CoreToolsDemo.zip (3 KB)](https://github.com/pluralsight-cloud/azure-functions-monitor-debug-solutions/raw/refs/heads/main/2.1/CoreToolsDemo.zip) and unzip to a folder of your choice.
3. Open a PowerShell window or a terminal and navigate to the folder containing the code and run the following command to install the required packages.
	
	`pip install -r requirements.txt`
	
4. Follow along with the demo.

---

### Clip 2 - Demo: Debugging Azure Functions with VSCode 

#### Follow-along steps (Local Environment)

1. Install the requirements for this demo:
	- [Python 3.12](https://www.python.org/downloads/release/python-3120/)
	- [Azure Function Core Tools](https://github.com/Azure/azure-functions-core-tools/blob/v4.x/README.md)
	- [Visual Studio Code (VSCode)](https://code.visualstudio.com/download)

2. Download the function app code [VSCodeDemo.zip (3 KB)](https://github.com/pluralsight-cloud/azure-functions-monitor-debug-solutions/raw/refs/heads/main/2.2/VSCodeDemo.zip) and unzip to a folder of your choice.
3. Open a PowerShell window or a terminal and navigate to the folder containing the code and run the following command to install the required packages.
	
	`pip install -r requirements.txt`
	
4. Follow along with the demo.

---

### Clip 3 - Demo: Live Debugging Azure Functions in the Azure Portal

#### Follow-along steps (Cloud Playground Sandbox)

1. Start an [Azure Sandbox](https://app.pluralsight.com/hands-on/playground/cloud-sandboxes).
2. In an InPrivate or Incognito window log in to the Azure Sandbox using the provided credentials.
3. Open this repository in the same window.
4. Click the **Deploy to Azure** button. Make sure the link opens in the Sandbox browser tab.

   [![Deploy To Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fgithub.com%2Fpluralsight-cloud%2Fazure-functions-monitor-debug-solutions%2Fraw%2Frefs%2Fheads%2Fmain%2F2.3%2Flivedebug.json)

5. Deploy the template and wait 5 minutes for the function app to provision.
6. Use the following command in a bash Azure Cloud Shell to deploy the function code. Wait 10 minutes for the deployment to finish. If you receive any errors, wait 5 minutes and run the command again.

	```
	RG=$(az group list --query "[0].name" -o tsv); \
	APP=$(az functionapp list --resource-group $RG --query "[0].name" -o tsv); \
	URL="https://github.com/pluralsight-cloud/azure-functions-monitor-debug-solutions/raw/refs/heads/main/2.3/LiveDebug.zip"; \
	az functionapp deploy --resource-group $RG --name $APP --src-url $URL --type zip
	```

7. Follow along with the demo.
8. Copy this JSON block to send an order to the function.

```json
{"orderId": "2421147", "item": "Laptop"}
```
---

### Clip 4 - Demo: Snapshot Debugging Azure Functions

1. If you'd like to open the snapshot with Visual Studio Enterprise, you can download it here: [debugsnapshot.diagsession (146 MB)](https://github.com/pluralsight-cloud/azure-functions-monitor-debug-solutions/raw/refs/heads/main/2.4/debugsnapshot.diagsession)

---

### Clip 6 - Demo: Log Correlation with Azure Functions

#### Follow-along steps (Cloud Playground Sandbox)

1. Start an [Azure Sandbox](https://app.pluralsight.com/hands-on/playground/cloud-sandboxes).
2. In an InPrivate or Incognito window log in to the Azure Sandbox using the provided credentials.
3. Open this repository in the same window.
4. Click the **Deploy to Azure** button. Make sure the link opens in the Sandbox browser tab.

   [![Deploy To Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fgithub.com%2Fpluralsight-cloud%2Fazure-functions-monitor-debug-solutions%2Fraw%2Frefs%2Fheads%2Fmain%2F2.6%2Flogcorrelation.json)

5. Deploy the template and wait 10 minutes for the function apps to provision.
6. Use the following command in a bash Azure Cloud Shell to deploy the function code. Wait 10 minutes for the deployment to finish. If you receive any errors, wait 5 minutes and run the command again.

```
RG=$(az group list -o tsv --query "[0].name"); \
HTTP_APP=$(az functionapp list -g $RG -o tsv --query "[?starts_with(name,'httpfunc')].name|[0]"); \
QUEUE_APP=$(az functionapp list -g $RG -o tsv --query "[?starts_with(name,'queuefunc')].name|[0]"); \
HTTP_URL="https://github.com/pluralsight-cloud/azure-functions-monitor-debug-solutions/raw/refs/heads/main/2.6/httpfunction.zip"; QUEUE_URL="https://github.com/pluralsight-cloud/azure-functions-monitor-debug-solutions/raw/refs/heads/main/2.6/queuefunction.zip"; \
az functionapp deploy -g $RG -n $HTTP_APP --src-url $HTTP_URL --type zip && \
az functionapp deploy -g $RG -n $QUEUE_APP --src-url $QUEUE_URL --type zip

```

7. Follow along with the demo.
8. Copy this JSON block to send the order to the HTTP function.

```json
{"orderId": "24147", "item": "Laptop"}
```
