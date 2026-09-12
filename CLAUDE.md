# Project Guide: Ultimate Agentic DevOps

## 1. Project Overview

This project is a high-performance, lightweight static marketing site consisting solely of standard HTML, CSS, and static assets (`index.html`, `privacy.html`, `terms.html`, `style.css`, `images/`).

## 2. Architecture & Infrastructure

- **Hosting:** Static website hosted on **AWS S3**.
- **Content Delivery:** Global distribution via **Amazon CloudFront** CDN with TLS enforcement.
- **Infrastructure as Code (IaC):** All cloud infrastructure must be provisioned and managed strictly using **Terraform**.
- **CI/CD:** Automated testing and deployment workflows using GitHub Actions.

## 3. Strict Coding Standards & Constraints

- **Strictly No JavaScript:** Under no circumstances should JavaScript, TypeScript, or frontend frameworks (such as React, Vue, or Angular) be introduced.
- **Pure CSS/HTML Only:** All UI interactions, styling, and visual transitions must rely entirely on modern HTML5 semantic elements and pure CSS.
- Keep HTML semantic and maintain clean, modular CSS without external UI frameworks (no Tailwind, Bootstrap).

## 4. Development & Workflow Commands

- Local preview: Serve using a simple static server (e.g., `python -m http.server 8000` or VS Code Live Server).
- Validation: Validate HTML and CSS syntax prior to committing.
- Terraform workflow:
  - Format check: `terraform fmt -check`
  - Validation: `terraform validate`
  - Plan: `terraform plan`

## 5. Testing & Verification Guidelines

- Verify mobile responsiveness across standard breakpoints (320px, 768px, 1024px+).
- Run accessibility checks for WCAG compliance on semantic color contrast and element tags.
- Confirm zero client-side scripts are injected into DOM output.
