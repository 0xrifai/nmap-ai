# 🚀 NMAP-AI: AI-Powered Network Scanning & Automation

<div align="center">
  <img src="assets/nmap-ai.png" alt="NMAP-AI Logo" width="200" height="200">
</div>

![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)
![Python](https://img.shields.io/badge/python-3.8%2B-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)
![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20Windows%20%7C%20macOS-lightgrey.svg)

> **🤖 Revolutionizing network scanning with AI-powered automation, intelligent script generation, and advanced port scanning capabilities**

## 📋 Table of Contents

- [🌟 Features](#-features)
- [🚀 Installation](#-installation)
- [💻 Usage](#-usage)
- [🤖 AI Capabilities](#-ai-capabilities)
- [📱 GUI Mode](#-gui-mode)
- [⌨️ CLI Mode](#-cli-mode)
- [🛠️ Configuration](#-configuration)
- [🤝 Contributing](#-contributing)
- [💰 Support](#-support)
- [📄 License](#-license)

## 🌟 Features

### 🤖 AI-Powered Capabilities
- **Intelligent Script Generation**: AI creates custom Nmap scripts based on target analysis
- **Smart Port Scanning**: ML-optimized scanning strategies for maximum efficiency
- **Automated Vulnerability Detection**: AI-driven identification of potential security issues
- **Adaptive Scanning**: Dynamic adjustment of scan parameters based on target responses
- **Threat Intelligence Integration**: Real-time threat data incorporation

### 🖥️ User Interfaces
- **Modern GUI**: Cross-platform desktop application with real-time visualization
- **Advanced CLI**: Powerful command-line interface with scripting support
- **Web Dashboard**: Browser-based interface for remote management
- **API Access**: RESTful API for integration with other tools

### 🔧 Advanced Scanning Features
- **Multi-threaded Scanning**: Parallel execution for faster results
- **Custom Script Library**: Extensive collection of specialized Nmap scripts
- **Network Visualization**: Interactive network topology mapping
- **Report Generation**: Comprehensive reports in multiple formats (PDF, HTML, JSON, XML)
- **Scheduled Scanning**: Automated recurring scans with alerting

### 🛡️ Security & Privacy
- **Offline AI Models**: No data sent to external services
- **Encrypted Storage**: Secure storage of scan results and configurations
- **Audit Logging**: Complete logging of all activities
- **Role-based Access**: Multi-user support with permission controls

## 🚀 Installation

### Prerequisites
- Python 3.8+
- Nmap 7.0+
- Git
- 4GB RAM minimum (8GB recommended for AI features)

### Quick Installation

```bash
# Clone the repository
git clone https://github.com/yashab-cyber/nmap-ai.git
cd nmap-ai

# Install dependencies
pip install -r requirements.txt

# Install Nmap (if not already installed)
sudo apt-get install nmap  # Ubuntu/Debian
sudo yum install nmap      # CentOS/RHEL
brew install nmap          # macOS

# Initialize AI models
python -m nmap_ai.setup --init-ai

# Run the application
python -m nmap_ai
```

### Docker Installation

> **Note**: The Docker image is currently being set up on Docker Hub. Until it's available, you can build the image locally using the instructions below.

**Option 1: Pull from Docker Hub (Coming Soon)**
```bash
docker pull yashabalam/nmap-ai:latest
docker run -it --rm yashabalam/nmap-ai:latest
```

**Option 2: Build Locally (Current Recommended Method)**
```bash
# Clone the repository
git clone https://github.com/yashab-cyber/nmap-ai.git
cd nmap-ai

# Build and run using Docker Compose
docker-compose up nmap-ai

# Or build manually
./scripts/docker_build.sh build-prod
docker run -it --rm -p 8080:8080 yashabalam/nmap-ai:latest
```

**Option 3: Using Docker with Volume Mounts**
```bash
# For persistent data
docker run -it --rm \
  -p 8080:8080 \
  -v $(pwd)/data:/app/data \
  -v $(pwd)/results:/app/results \
  yashabalam/nmap-ai:latest
```

## 💻 Usage

### 🖥️ GUI Mode

```bash
# Launch GUI application
python -m nmap_ai --gui

# Or use the desktop shortcut after installation
nmap-ai-gui
```

### ⌨️ CLI Mode

```bash
# Basic AI-powered scan
nmap-ai --target 192.168.1.0/24 --ai-mode smart

# Generate custom script with AI
nmap-ai --generate-script --target example.com --vulnerability web

# Advanced port scan with ML optimization
nmap-ai --target 10.0.0.1 --ports all --ai-optimize --output report.json

# Batch scanning with AI analysis
nmap-ai --batch targets.txt --ai-analysis --format pdf
```

### 🌐 Web Dashboard

```bash
# Start web server
nmap-ai --web --port 8080

# Access dashboard at http://localhost:8080
```

## 🤖 AI Capabilities

### 🧠 Intelligent Script Generation

NMAP-AI can automatically generate custom Nmap scripts based on your requirements:

```python
from nmap_ai import AIScriptGenerator

generator = AIScriptGenerator()

# Generate script for web application testing
script = generator.create_script(
    target_type="web_server",
    vulnerabilities=["sql_injection", "xss", "directory_traversal"],
    stealth_level="high"
)

# Generate script for network device scanning
network_script = generator.create_script(
    target_type="network_device",
    device_types=["router", "switch", "firewall"],
    protocols=["snmp", "ssh", "telnet"]
)
```

### 🔍 Smart Scanning Algorithms

```python
from nmap_ai import SmartScanner

scanner = SmartScanner()

# AI-optimized port scanning
results = scanner.smart_scan(
    target="192.168.1.0/24",
    optimization_level="aggressive",
    ai_model="fast_scan_v2"
)

# Adaptive scanning with learning
adaptive_results = scanner.adaptive_scan(
    target="example.com",
    learn_from_previous=True,
    adjust_timing=True
)
```

## 📱 GUI Features

### Main Dashboard
- Real-time scan progress visualization
- Interactive network topology maps
- Live port status indicators
- Threat level heat maps

### AI Assistant Panel
- Natural language query interface
- Automated script suggestions
- Vulnerability explanation and remediation advice
- Scan optimization recommendations

### Report Generator
- Customizable report templates
- Executive summary generation
- Technical details with screenshots
- Export options (PDF, HTML, DOCX)

## ⌨️ CLI Advanced Usage

### Scripting and Automation

```bash
# Create scanning profiles
nmap-ai --create-profile web_scan --ports 80,443,8080,8443 --scripts http-*

# Use custom AI models
nmap-ai --ai-model custom_model.pkl --target 10.0.0.0/8

# Integration with other tools
nmap-ai --target-from-file ips.txt --output-format json | jq '.vulnerabilities'

# Scheduled scanning
nmap-ai --schedule "0 2 * * *" --profile daily_scan --notify email
```

### Advanced Configuration

```yaml
# config.yml
ai:
  models:
    script_generation: models/script_gen_v3.pkl
    vulnerability_detection: models/vuln_detect_v2.pkl
    port_prediction: models/port_pred_v1.pkl
  
scanning:
  default_timeout: 300
  max_parallel_hosts: 50
  retries: 3
  
output:
  default_format: json
  include_raw_nmap: true
  compress_results: true

notifications:
  email:
    enabled: true
    smtp_server: smtp.gmail.com
    port: 587
  webhook:
    enabled: false
    url: https://your-webhook-url.com
```

## 🛠️ Plugin System

NMAP-AI supports a flexible plugin architecture:

```python
# plugins/custom_scanner.py
from nmap_ai.plugins import BasePlugin

class CustomVulnScanner(BasePlugin):
    name = "Custom Vulnerability Scanner"
    version = "1.0.0"
    
    def scan(self, target, options):
        # Custom scanning logic
        return results
    
    def generate_script(self, requirements):
        # Custom script generation
        return script_code
```

## 🔧 API Reference

### REST API Endpoints

```python
# Start scan
POST /api/v1/scan
{
    "target": "192.168.1.0/24",
    "options": {
        "ai_mode": true,
        "stealth": "medium",
        "ports": "common"
    }
}

# Get scan results
GET /api/v1/scan/{scan_id}

# Generate AI script
POST /api/v1/ai/generate-script
{
    "target_type": "web_server",
    "requirements": ["vulnerability_scan", "service_detection"]
}

# List AI models
GET /api/v1/ai/models
```

## 🎯 Use Cases

### 🏢 Enterprise Security
- **Automated Asset Discovery**: AI-powered identification of network assets
- **Compliance Scanning**: Automated checks for security compliance
- **Threat Hunting**: Proactive identification of potential threats
- **Vulnerability Management**: Continuous vulnerability assessment

### 🎓 Education & Research
- **Security Training**: Interactive learning environment
- **Research Projects**: Advanced scanning capabilities for academic research
- **Penetration Testing**: Professional-grade testing tools
- **Network Analysis**: Deep network behavior analysis

### 🔒 Penetration Testing
- **Reconnaissance Automation**: AI-assisted information gathering
- **Custom Exploit Development**: Script generation for specific targets
- **Stealth Scanning**: Advanced evasion techniques
- **Report Generation**: Professional penetration testing reports

## 🚀 Roadmap

### Version 1.1 (Q3 2025)
- [ ] Enhanced AI models for better accuracy
- [ ] Mobile companion app (Android/iOS)
- [ ] Cloud-based scanning coordination
- [ ] Advanced machine learning analytics

### Version 1.2 (Q4 2025)
- [ ] Integration with major SIEM platforms
- [ ] Real-time threat intelligence feeds
- [ ] Advanced network visualization
- [ ] Multi-language support

### Version 2.0 (Q1 2026)
- [ ] Distributed scanning architecture
- [ ] Advanced AI-powered exploit generation
- [ ] Blockchain-based result verification
- [ ] Quantum-resistant scanning protocols

## 🤝 Contributing

We welcome contributions from the community! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

### Development Setup

```bash
# Clone repository
git clone https://github.com/yashab-cyber/nmap-ai.git
cd nmap-ai

# Create virtual environment
python -m venv venv
source venv/bin/activate  # Linux/macOS
venv\Scripts\activate     # Windows

# Install development dependencies
pip install -r requirements-dev.txt

# Install pre-commit hooks
pre-commit install

# Run tests
python -m pytest
```

## 💰 Support

If you find NMAP-AI useful, please consider supporting our development:

- 💰 [Donate via Cryptocurrency or PayPal](DONATE.md)
- ⭐ Star this repository on GitHub
- 📢 Share the project with others
- 🐛 Report bugs and suggest features
- 📝 Contribute to documentation

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- The Nmap Development Team for creating the amazing Nmap tool
- The open-source AI/ML community for inspiration and tools
- All contributors and supporters of the NMAP-AI project
- ZehraSec for providing development resources and support

## 📞 Contact

- **Email**: yashabalam707@gmail.com
- **GitHub**: [@yashab-cyber](https://github.com/yashab-cyber)
- **LinkedIn**: [Yashab Alam](https://www.linkedin.com/in/yashab-alam)
- **Company**: [ZehraSec](https://www.zehrasec.com)
- **WhatsApp**: [Business Channel](https://whatsapp.com/channel/0029Vaoa1GfKLaHlL0Kc8k1q)

---

**🚀 Made with ❤️ by Yashab Alam (Founder of ZehraSec) and the NMAP-AI team**

*Revolutionizing network security, one scan at a time.*
