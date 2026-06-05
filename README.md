# NE-terraform-lab

## Overview

This Terraform project sets up a complete cloud infrastructure on Google Cloud Platform (GCP). It creates a network with servers, storage, and databases spread across different regions worldwide to ensure reliable and fast access to resources.

Think of this as building a complete data center in the cloud: you have a main network (like highways connecting cities), servers (like computers), file storage (like filing cabinets), and databases (like organized filing systems).

---

## Architecture Components

### Network Structure (VPC)
- **Main Network (`my_vpc`)**: Acts as a private, isolated network that connects all servers and resources together
- **Three Subnets** (sub-networks): Divide the main network into three smaller sections, each in different regions:
  - `my-subnet` in us-central1 (USA)
  - `my-subnet2` in europe-west1 (Belgium/Netherlands)
  - `my-subnet3` in europe-west6 (Switzerland)

### Firewall Rules
- `allow_http_https`: Controls traffic entering the network, allowing web traffic (HTTP on port 80 and HTTPS on port 443) from anywhere while protecting against unwanted access

### Servers (Virtual Machines)
- **terraform-vm**: Ubuntu server in USA (us-central1)
- **terraform-vm2**: Debian server in Europe-West1
- **terraform-vm3**: Ubuntu server in Europe-West6

### Storage (Cloud Storage Buckets)
- **nexedge-bucket-prisca123**: File storage in USA
- **nexedge-bucket-prisca456**: File storage in Europe-West1
- **nexedge-bucket-prisca789**: File storage in Europe-West6

### Databases
- **mysql-db**: MySQL database (USA) - for structured data management
- **mysql-db2**: MySQL database (Europe-West1) - replica for European region
- **pgsql-db**: PostgreSQL database (Europe-West6) - alternative database type for Switzerland region

---

## File Documentation

### `main.tf` - Configuration Setup
**Purpose**: Sets up the connection to Google Cloud Platform

This file tells Terraform which cloud provider to use (Google Cloud) and authenticates using your project credentials. Think of it as the login credentials and initial setup for your cloud account.

**Key Details**:
- Specifies Google Cloud Provider version (5.0+)
- Loads authentication credentials from the JSON file (`ne-project-494917-346c3ad07dbe.json`)
- Sets the target project ID (`ne-project-494917`)

---

### `vpc.tf` - Network and Firewall Configuration
**Purpose**: Creates the private network and security rules that connect all resources

This file builds the foundation of your cloud infrastructure. Just like a company needs an internal network to connect all its offices and a security system to control who enters, this file creates your cloud network and firewall rules.

**Components Created**:

1. **VPC Network** (`my_vpc`)
   - Creates a private, isolated network
   - `auto_create_subnetworks = false` means you manually control which sub-networks exist

2. **Three Subnets** (Internal Network Sections)
   - **my-subnet** (10.0.1.0/24): USA region, contains servers and resources
   - **my-subnet2** (10.0.2.0/24): Europe-West1 region, contains servers and resources
   - **my-subnet3** (10.0.3.0/24): Europe-West6 region, contains servers and resources
   - All use IPv4 only (no IPv6) - this means they use the classic internet address system only, not the newer IPv6 format.

3. **Firewall Rule** (`allow_http_https`)
   - Allows web traffic (HTTP port 80 and HTTPS port 443)
   - Applies to ALL servers in the network
   - Accepts traffic from anywhere (0.0.0.0/0 = entire internet)
   - Direction: INGRESS (incoming traffic only)

---

### `vm.tf` - Virtual Servers
**Purpose**: Creates the actual servers (computers) that run applications

This file deploys three virtual machines (servers) across different regions. Each server is independent but can communicate through the shared network.

**Servers Created**:

1. **terraform-vm** (Ubuntu Server - USA)
   - Location: us-central1-a (USA)
   - Operating System: Ubuntu 22.04 LTS (stable Linux)
   - Size: e2-micro (small, cost-effective)
   - Network: Connected to my-subnet
   - Access: Public IP assigned for internet access

2. **terraform-vm2** (Debian Server - Europe-West1)
   - Location: europe-west1-b (Belgium/Netherlands area)
   - Operating System: Debian 11 (lightweight Linux)
   - Size: e2-micro
   - Network: Connected to my-subnet2
   - Access: Public IP for internet access

3. **terraform-vm3** (Ubuntu Server - Europe-West6)
   - Location: europe-west6-a (Switzerland)
   - Operating System: Ubuntu 22.04 LTS
   - Size: e2-micro
   - Network: Connected to my-subnet3
   - Access: Public IP for internet access

**Why Multiple Regions?**: Distributing servers across regions provides faster access to users in different parts of the world and ensures service continues if one region has problems.

---

### `bucket.tf` - Cloud Storage
**Purpose**: Creates storage containers for files and data

Cloud Storage buckets are like giant digital filing cabinets. They store any type of file (images, documents, backups, logs) in a secure, durable way. Multiple buckets across regions ensure data stays close to where it's needed.

**Storage Buckets Created**:

1. **nexedge-bucket-prisca123** (USA)
   - Location: US-CENTRAL1
   - Storage Class: STANDARD (frequently accessed files, higher cost but fastest)
   - Security: Uniform access control enabled (consistent permissions across all files)
   - Use Case: Store files needed by USA servers

2. **nexedge-bucket-prisca456** (Europe)
   - Location: EUROPE-WEST1
   - Storage Class: STANDARD
   - Security: Uniform access control enabled
   - Use Case: Store files needed by Europe-West1 servers

3. **nexedge-bucket-prisca789** (Switzerland)
   - Location: EUROPE-WEST6
   - Storage Class: STANDARD
   - Security: Uniform access control enabled
   - Use Case: Store files needed by Europe-West6 servers

---

### `db-instance.tf` - Database Servers
**Purpose**: Creates databases that organize and manage structured information

Databases are sophisticated filing systems that organize data efficiently. Unlike buckets that store raw files, databases can search, filter, and organize information quickly. This project uses two types of databases:

**Databases Created**:

1. **mysql-db** (USA MySQL)
   - Database Type: MySQL 8.0 (popular for web applications)
   - Location: us-central1
   - Size: db-f1-micro (small, cost-effective)
   - Use Case: Store application data (user accounts, orders, settings)

2. **mysql-db2** (Europe MySQL)
   - Database Type: MySQL 8.0
   - Location: europe-west1
   - Size: db-f1-micro
   - Use Case: European region data storage, reduces latency for European users

3. **pgsql-db** (Switzerland PostgreSQL)
   - Database Type: PostgreSQL 15 (advanced database for complex data)
   - Location: europe-west6
   - Size: db-f1-micro
   - Use Case: For more complex data relationships and advanced features

**Deletion Protection**: For this lab, set `deletion_protection = false` on the database instances so `terraform destroy` can delete them during cleanup. If `deletion_protection = true`, Google Cloud blocks deletion and `terraform destroy` will fail until protection is disabled first.

---

## How It All Works Together

1. **Main.tf** connects you to Google Cloud
2. **VPC.tf** creates the network foundation and security
3. **VM.tf** launches actual servers on that network
4. **Bucket.tf** creates storage for files
5. **DB-instance.tf** sets up databases for structured data

All resources are connected through the VPC network and distributed across three regions:
- **USA (us-central1)**: Primary region with all resource types
- **Europe-West1**: Secondary region with servers, storage, and database
- **Europe-West6**: Tertiary region with servers, storage, and database

This architecture provides:
- **Redundancy**: If one region fails, others continue operating
- **Low Latency**: Users access resources in nearby regions for faster speeds
- **Scalability**: Easy to add more resources as needs grow
- **Security**: Private network with controlled firewall rules

---

## Getting Started

### Prerequisites
- Terraform installed (version matching ~> 5.0 of Google Cloud provider)
- Google Cloud Platform account
- Service account credentials JSON file (`ne-project-494917-346c3ad07dbe.json`)
- gcloud CLI (optional, for manual verification)

### Deployment Steps

```bash
# Initialize Terraform (downloads necessary plugins)
terraform init

# Review what will be created
terraform plan

# Create all resources
terraform apply

# Verify completion
terraform show
```

### Cleanup

```bash
# Destroy all resources (if no longer needed)
terraform destroy
```

---

## Security Considerations

- **Firewall**: Currently allows all web traffic (0.0.0.0/0). In production, restrict to specific IP addresses
- **Deletion Protection**: Disabled on Cloud SQL instances for this lab so cleanup with `terraform destroy` works. In production, consider enabling it to prevent accidental deletion, but note that `terraform destroy` cannot remove protected instances until protection is disabled.
- **Credentials**: Keep the JSON credentials file secure, never commit to public repositories
- **Regions**: Data is stored in specific regions per GDPR and data residency requirements

---

## Monitoring and Maintenance

- Use Google Cloud Console to monitor resource usage and costs
- Set up alerts for unusual activity
- Regular backups recommended for database data
- Periodically review and optimize resource sizes as workload changes