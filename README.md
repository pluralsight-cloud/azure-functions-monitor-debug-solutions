# Monitoring and Debugging Azure Functions

Created by [Clint Bonnett](https://app.pluralsight.com/profile/author/clint-bonnett)


## Table of Contents

1. [Module 1](#module-1)
    1. [Clip 3 - Demo: Logging Custom Telemetry for Azure Functions](#clip-3---demo-logging-custom-telemetry-for-azure-functions)
    2. [Clip 4 - Demo: Visualizing Telemetry on Azure Functions](#clip-4---demo-visualizing-telemetry-on-azure-functions)
    3. [Clip 5 - Demo: Proactive Monitoring with Alerts on Azure Functions](#clip-5---demo-proactive-monitoring-with-alerts-on-azure-functions)

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
	
 	1. Use the following command in a bash Azure Cloud Shell to deploy the function code. Wait 5-10 minutes for the deployment to finish.

	```
	RG=$(az group list --query "[0].name" -o tsv); \
	APP=$(az functionapp list --resource-group $RG --query "[0].name" -o tsv); \
	URL="https://github.com/pluralsight-cloud/azure-functions-monitor-debug-solutions/raw/refs/heads/main/1.3/customtelemetry.zip"; \
	az functionapp deploy --resource-group $RG --name $APP --src-url $URL --type zip
	```
 
	2. Head into the Function App and click on the **http function**.
	3. Click on **Test/Run** and paste in the following JSON block into the **body**, then click on **Run**.


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
   
 	1. Use the following command in a bash Azure Cloud Shell to deploy the function code. Wait 5-10 minutes for the deployment to finish.

	```
	RG=$(az group list --query "[0].name" -o tsv); \
	APP=$(az functionapp list --resource-group $RG --query "[0].name" -o tsv); \
	URL="https://github.com/pluralsight-cloud/azure-functions-monitor-debug-solutions/raw/refs/heads/main/1.3/customtelemetry.zip"; \
	az functionapp deploy --resource-group $RG --name $APP --src-url $URL --type zip
	```
 
	2. Head into the Function App and click on the **http function**.
	3. Click on **Test/Run** and paste in the following JSON block into the **body**, then click on **Run**.


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
