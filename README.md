# Atlassian SDK docker image

This Atlassian SDK version contains yarn to build WRMPlugin-based plugins.

To build and to publish:

```
docker build -t mesilat/atlassian-sdk .
docker login -u mesilat -p <password>
docker push mesilat/atlassian-sdk
```
