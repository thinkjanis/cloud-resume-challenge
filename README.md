# Cloud Resume Challenge  

This project is my implementation of the [Cloud Resume Challenge](https://cloudresumechallenge.dev/), showcasing my ability to design and deploy a cloud-native application using modern DevOps practices and AWS services.  

![Architecture Diagram](js_crc.png)

## Overview  

The project involves a personal résumé website hosted on AWS, with infrastructure as code (IaC) and a focus on cloud-native architecture.

## Features  

- **Infrastructure Provisioning:**  
  Utilised **Terraform** to provision and manage infrastructure as code.  
- **Static Website Hosting:**  
  - Hosted the résumé website on **AWS S3** for cost-effective and reliable static site hosting.  
  - Leveraged **CloudFront** as a Content Delivery Network (CDN) for enhanced website performance and security.
  - Configured **Route 53** and **Cloudflare** for DNS management.

## Tools and Technologies  

- **Infrastructure as Code:** Terraform
- **Frontend Hosting:** AWS S3, CloudFront
- **DNS Management:** Route 53, Cloudflare

## Infrastructure Components

- S3 Bucket for static website hosting
- CloudFront distribution for content delivery
- ACM Certificate for HTTPS
- Route 53 for AWS DNS management
- Integration with Cloudflare for domain management