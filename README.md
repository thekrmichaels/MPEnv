# MPEnv

This repository provides a Docker configuration to replace development environments such as XAMPP, Laragon, etc. It uses containers to serve PHP applications, MySQL databases, phpMyAdmin and a SMTP Server (smtp4dev).

## Getting Started

### Environment Configuration

Use **Dev Containers**: Select "Dev Containers: Reopen in Container" from the command palette.

1. Access your application at [http://localhost](http://localhost).
2. Access phpMyAdmin at [http://localhost:8080](http://localhost:8080).
3. Access smtp4dev at [http://localhost:5000](http://localhost:5000).

### Environment Structure

* `src/`: Contains the folder for your PHP applications.

## Notes

* smtp4dev documentation: [https://github.com/rnwood/smtp4dev/wiki/Getting-Started](https://github.com/rnwood/smtp4dev/wiki/Getting-Started).
