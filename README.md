# hl-model-api

**hl-model-api** is an experimental project for building and deploying simple AI models on a modest laptop. The repository is written in Python and aims to provide an easy-to-use API for interacting with machine learning models, such as text classifiers, with a focus on simplicity and quick iteration.

## Features

- **Text Classification**: Includes functionality for building and serving text classifier models.
- **API Access**: Exposes trained models via an API for easy integration with other tools and workflows.
- **Docker Support**: Comes with Docker Compose configuration for containerized deployment, including health checks and non-root user setup for improved security.
- **Testing**: Contains basic tests for model validation and API endpoints.
- **Continuous Integration**: Includes workflows for automated testing and publishing.
- **YAML Validation**: Ensures configuration integrity.

## Getting Started

1. **Clone the repository**
   ```bash
   git clone https://github.com/welshDog/hl-model-api.git
   cd hl-model-api
   ```

2. **Run with Docker Compose**
   ```bash
   docker-compose up --build
   ```

3. **Access the API**
   - Once running, the API will be available at `http://localhost:PORT` (replace `PORT` with your Docker configuration).

## Project Motivation

This project is a test of developing AI solutions on a consumer-grade laptop, emphasizing simplicity and accessibility for hobbyists and learners.

## Contributing

Pull requests and suggestions are welcome! Please open issues for bug reports or feature requests.

## License

*No license specified yet.*

---

_For more details, browse the source code and workflow files, or reach out via [GitHub Issues](https://github.com/welshDog/hl-model-api/issues)._