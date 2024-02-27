# Repositories and Product

Before configuring any repositories or products the sync timeout should be increased.

### Increase Sync Timeout

Increasing the sync timeout will prevent large packages from causing the repo sync to fail.

Administer > settings > Content > Sync Connection Timeout > 600 Seconds

## Add Product

Products are simply groups of repositories.

### Create Product

Create a new product with the name "Rocky 9"

### Add Repositories

Navigate to the added product and add the following repositories.

1. [Rocky 9](repos/rocky9.md)
2. [Rocky 9 AppStream](repos/rocky9-appstream.md)
2. [Rocky 9 Extras (required for epel)](repos/rocky9-appstream.md)


## Lifecycle Management

At first lifecycle management in Foreman may seem overly complicated. This chart concisely explains how lifecycle paths, life cycle environments, content views and repositores interact.

![lifecycle chart](img/foreman-lifecycle-dark-trans.png)

### Add Lifecycle Environments

Lifecycle environments are key to managing pinned versions of packages in Foreman. Lifecycle environments are assigned to content views.

1. Content > Lifecycle > Lifecycle Environments
2. Create Environment Path named `R9_Dev`
3. Add New Environment named `R9_Test` with the parent of `R9_Dev`
4. Add New Environment named `R9_Prod` with the parent of `R9_Test`

### Add Content Views

Content views are **snapshots** of sets of repositories.

1. Content > Lifecycle > Content Views
2. Click **Create content view**
3. Name the Content View `Rocky 9`
4. Add the Rocky 9 repositories that were added above.

