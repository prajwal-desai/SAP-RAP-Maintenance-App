# Smart Equipment Maintenance Tracker - SAP S/4HANA

## Screenshots

<img width="1892" height="907" alt="Screenshot1" src="https://github.com/user-attachments/assets/9b5c56ba-9788-4b0d-983d-924529e81609" />
<img width="1906" height="902" alt="Screenshot2" src="https://github.com/user-attachments/assets/ed4a5d64-5858-4a0f-b079-c00719687171" />


## Overview
This repository contains the end-to-end implementation of an enterprise-grade SAP Fiori application built using the ABAP RESTful Application Programming Model (RAP). The project demonstrates advanced SAP S/4HANA development principles, specifically focusing on a Parent-Child (Header-Item) Composition Tree, Draft Handling, and Entity Manipulation Language (EML).

Built in alignment with SAP's Clean Core strategy and ABAP Cloud guidelines, this application manages Maintenance Requests and their associated Spare Parts, featuring real-time data roll-ups and stateful interactions via OData V4.

## Technical Stack & Competencies
* **Architecture:** SAP ABAP RESTful Application Programming Model (RAP) - Managed Scenario
* **Backend:** ABAP Cloud, Entity Manipulation Language (EML), Object-Oriented ABAP
* **Data Modeling:** Core Data Services (CDS) View Entities, Composition/Association Routing
* **Frontend:** SAP Fiori Elements (List Report & Object Page), Metadata Extensions (UI Annotations)
* **Protocol:** OData V4 UI Binding

## Key Features & Engineering Highlights
* **Deep Composition Modeling:** Architected a robust Parent (Maintenance Request) to Child (Spare Parts) hierarchy, ensuring referential integrity and synchronized draft states across multiple database nodes.
* **Advanced Draft Handling:** Implemented Strict Mode (2) draft capabilities, allowing users to persist unsaved data across browser sessions with fully supported Edit, Resume, Prepare, Activate, and Discard actions.
* **Dynamic EML Calculations:** Engineered optimized backend determinations utilizing EML (`READ ENTITIES ... BY \_Association`). The system recalculates and rolls up total maintenance costs dynamically when child items are created, modified, or deleted, while preventing infinite loops and ensuring memory efficiency through adjacency deletion.
* **Metadata-Driven UI:** Decoupled the frontend rendering from the backend logic by utilizing Metadata Extensions (MDE). Designed a seamless Fiori Object Page with an embedded line-item table facet.
* **Database Mapping:** Ensured strict alignment between ABAP Dictionary snake_case persistence and CDS CamelCase structures using explicit BDEF mapping definitions.

## Repository Structure (RAP Layering)
The application follows the standard SAP RAP layered architecture:

1. **Database Persistence Layer**
   * `ZRAP_MREQ_H` (Header Table) & `ZRAP_DMREQ_H` (Draft)
   * `ZRAP_MREQ_I` (Item Table) & `ZRAP_DMREQ_I` (Draft)
2. **Data Model Layer (CDS Interface Views)**
   * `ZI_MAINTREQ_H` (Root View Entity)
   * `ZI_MAINTREQ_I` (Child View Entity)
3. **Business Logic Layer (Behavior)**
   * `ZBP_I_MAINTREQ_H` (Behavior Definition - Strict Mode)
   * `LHC_REQUEST` & `LHC_PART` (Behavior Implementation Classes - EML)
4. **Consumption Layer (Projection Views)**
   * `ZC_MAINTREQ_H` & `ZC_MAINTREQ_I` (Projection Views)
   * Projection Behavior Definitions
5. **UI & Service Layer**
   * `ZC_MAINTREQ_H` & `ZC_MAINTREQ_I` (Metadata Extensions)
   * `ZUI_MAINTREQ_V4` (Service Definition)
   * `ZUI_MAINTREQ_BINDING` (OData V4 Service Binding)

## Business Scenario Flow
1. A Maintenance Engineer opens the application to log a new equipment repair.
2. The engineer creates a Maintenance Request Header (e.g., "Diesel Generator Repair"). The RAP framework immediately generates a stateless draft record.
3. Within the Fiori Object Page, the engineer navigates to the Spare Parts facet and adds required components (e.g., "Air Filter", Quantity: 2, Price: 50.00).
4. The backend EML logic instantaneously intercepts the draft modification, navigates the composition tree, and updates the Parent Header's Total Cost field to 100.00.
5. The engineer saves the request, seamlessly transitioning the data from temporary draft tables to the active persistence layer.
