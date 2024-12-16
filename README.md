# Cloud Resume Challenge  

This project is my implementation of the [Cloud Resume Challenge](https://cloudresumechallenge.dev/), showcasing my ability to design and deploy a cloud-native application using modern DevOps practices and AWS services.  

## Overview  

The project involves a personal résumé website hosted on AWS, with infrastructure as code (IaC), backend functionality, and a focus on CI/CD pipelines for automation.  

## Features  

- **Infrastructure Provisioning:**  
  Utilised **Terraform** to provision and manage infrastructure as code.  
- **Static Website Hosting:**  
  - Hosted the résumé website on **AWS S3** for cost-effective and reliable static site hosting.  
  - Leveraged **CloudFront** as a Content Delivery Network (CDN) for enhanced website performance and security.  
  - Configured **Route 53** and **Cloudflare** for DNS management.  
- **View Counter:**  
  - Created a serverless view counter to track website visits.  
  - Implemented **AWS DynamoDB** for data storage.  
  - Built the backend functionality using **AWS Lambda** and **Python**.  
- **CI/CD Pipelines:**  
  - Currently working on implementing CI/CD pipelines to automate deployments and ensure consistency across environments.  

## Tools and Technologies  

- **Infrastructure as Code:** Terraform  
- **Frontend Hosting:** AWS S3, CloudFront  
- **DNS Management:** Route 53, Cloudflare  
- **Backend Services:** AWS Lambda (Python), DynamoDB  
- **CI/CD:** In progress  

## Next Steps  

- Finalise the CI/CD pipeline to automate deployment processes.