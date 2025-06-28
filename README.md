# VM_Service
📊 Overview
This Power BI dashboard provides a comprehensive view of virtual machine (VM) resource usage and associated service costs for multiple customers. It integrates data from three key areas— customer lifecycle, virtual machine configurations, and cloud services to help stakeholders monitor usage, billing, and customer engagement over time.
🧾 Data Sources
Excel File: cloud_powerbi_dataset.xlsx

The dataset includes three sheets:

-> Customers- Contains customer ID, name, subscription start and expiry dates, billing cycle, and active months.

-> VMs- Lists VM configurations per customer, including RAM, storage, OS, CPU cores, and associated costs.

-> Services- Captures quantities and rates for additional services like WAF, firewall, DNS, and email.

📈 Key Metrics Tracked
-> Total Monthly Cost per Customer
(Sum of all VM and Service costs)

-> Average Revenue per Customer
(Useful for tracking profitability and engagement)

-> VM Usage Distribution

By Operating System (Ubuntu, CentOS, Linux)

By CPU, RAM, and Storage

-> Service Utilization

Total cost by service type (Firewall, DNS, Mail, WAF)

Quantity and rate comparison

-> Expiry & Billing Monitoring

-> Days/months left before subscription expiry

-> Color-coded gauge to indicate urgency (Red if < 6 months left)

🧩 Dashboard Features

-> Interactive Filters:

Filter by Customer ID, VM OS, Billing Cycle

-> Drill-Down Views:

Analyze service breakdown for individual customers

-> Visualizations:

Bar charts, KPI cards, gauge visuals, and tables

-> Conditional Formatting:

Alerts for approaching expiry dates using colored indicators

🎯 Business Questions Answered
-> Which customers are contributing the most revenue?

-> What is the average cost of maintaining VMs by OS type?

-> Which services are most utilized and by whom?

-> How many customers are nearing subscription expiry?

-> Is the current VM resource allocation aligned with expected usage patterns?
