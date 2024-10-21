# Docker Setup for PHP Development

This repository provides a Docker configuration to replace development environments such as XAMPP, Laragon, etc. It uses containers to serve PHP applications, MySQL databases and phpMyAdmin.

## Getting Started

* [Environment Configuration](#environment-configuration)
* [Environment Structure](#environment-structure)
* [Notes](#notes)

### Environment Configuration

Create a `.env` file in the root of your project with the following content before running the container (If you use a framework:).

```env
PROJECT_NAME=your_project_name
RUN_COMMAND=command_to_start_the_local_development_server
```

1. Access your application at [http://localhost](http://localhost).
2. Access phpMyAdmin at [http://localhost:8080](http://localhost:8080).

### Environment Structure

* `src/`: Contains the folder for your PHP applications.
* `.env.example`: Contains the environment variables that can be used in the container's .env file.

### Notes

* If you do not use a framework, manually access the application directory where the `index.php` is located from `http://localhost`.
