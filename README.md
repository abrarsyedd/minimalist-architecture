# Minimalist Architecture - Premium Design Studio

A dynamic 2-tier web application for Minimalist Architecture, built with Node.js, Express, MySQL, and EJS templating.

## 🏢 About Minimalist Architecture

Minimalist Architecture is a premium design studio specializing in contemporary, sustainable, and aesthetically remarkable spaces. We create innovative architectural solutions that combine form, function, and environmental responsibility.

## ✨ Features

- Dynamic content management system
- Professional project portfolio showcase
- Contact form with database storage
- Fully responsive design
- MySQL database integration
- Modern minimalist aesthetic

## 📋 Prerequisites

- Node.js (v14 or higher)
- MySQL (v5.7 or higher)
- npm or yarn

## 🚀 Installation & Setup

### 1. Extract and Install

```bash
unzip minimalist-architecture-website.zip
cd minimalist-architecture-website
npm install
```

### 2. Configure Database

Update `.env` file with your MySQL credentials:
```
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=minimalist_architecture_db
```

### 3. Initialize Database

```bash
mysql -u root -p < database/schema.sql
```

Enter your MySQL password when prompted.

### 4. Start the Server

```bash
npm start
```

The application will start on `http://localhost:3000`

## 📂 Project Structure

```
minimalist-architecture-website/
├── server.js                 # Main Express application
├── routes/                   # Route handlers
│   ├── home.js
│   ├── about.js
│   ├── projects.js
│   ├── services.js
│   └── contact.js
├── views/                    # EJS templates
│   ├── partials/
│   │   ├── header.ejs
│   │   └── footer.ejs
│   ├── home.ejs
│   ├── about.ejs
│   ├── projects.ejs
│   ├── services.ejs
│   ├── contact.ejs
│   ├── project-detail.ejs
│   └── 404.ejs
├── config/
│   └── database.js           # MySQL connection
├── database/
│   └── schema.sql            # Database schema & sample data
├── public/
│   ├── css/
│   │   └── style.css         # Complete styling
│   ├── js/
│   │   └── main.js           # Interactive features
│   └── images/               # All project images
├── .env                      # Environment configuration
├── .gitignore
└── package.json
```

## 🌐 Website Pages

| Page | Route | Description |
|------|-------|-------------|
| Home | `/` | Hero, featured projects, services preview |
| About | `/about` | Company story, mission, team, awards |
| Projects | `/projects` | Portfolio with category filters |
| Services | `/services` | Service offerings & process workflow |
| Contact | `/contact` | Contact form & business information |

## 🎨 Technology Stack

- **Backend**: Node.js with Express.js
- **Database**: MySQL with promise-based queries
- **Frontend**: EJS templating engine
- **Styling**: Custom CSS3 with responsive design
- **Interactive**: Vanilla JavaScript

## 💾 Database Features

- 6 architectural projects with details
- 6 professional services
- 4 team members
- Contact form submissions storage
- Pre-populated sample data

## 🔒 Security Notes

- Update `.env` with secure credentials
- Use environment variables for sensitive data
- Never commit `.env` to version control

## 📱 Responsive Design

- Mobile-first approach
- Tablet optimization
- Desktop experience
- Touch-friendly interface

## 🤝 Contact & Support

- Email: info@minimalist-architecture.com
- Phone: +1 (555) 123-4567
- Location: 123 Design Street, Architecture City, AC 12345

## 📄 License

MIT License - Feel free to use this project as a template

---

**Built with ❤️ by Minimalist Architecture Studio**
