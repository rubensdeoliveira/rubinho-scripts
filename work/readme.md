# 🏢 Work Environment

Company-specific development tools and configurations.

## 🚀 Quick Start

### 1. Configure Environment Variables

```bash
cp .env.example .env
nano .env
```

Fill in your company-specific values.

### 2. Run Installation

#### Linux
```bash
cd linux/scripts
bash 00-install-all.sh
```

#### macOS
```bash
cd macos/scripts
bash 00-install-all.sh
```

## 📦 Additional Tools

Beyond the personal environment, this includes:

### Development Frameworks
- **.NET SDK 8** - For C# development
- **Java 11 (OpenJDK)** - For Java projects

### Cloud & Infrastructure
- **AWS CLI** - Command-line interface
- **AWS VPN Client** - Secure network access
- **AWS SSO** - Single sign-on configuration

### Authentication
- **GitHub Token** - For private repositories

## 🔐 Environment Variables

The `.env` file keeps company-specific information separate:

### Optional
- `GITHUB_TOKEN` - For private repos
- `AWS_SSO_START_URL` - AWS SSO config
- Multiple AWS accounts support

See `.env.example` for complete list.

## 🤝 Sharing with Team

1. Share the repository (without `.env`)
2. Each person copies `.env.example` to `.env`
3. Each person fills in their values
4. Document company values in a secure location

## 📚 Documentation

See [main README](../readme.md) for complete documentation.
