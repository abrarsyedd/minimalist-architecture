-- Create database
CREATE DATABASE IF NOT EXISTS minimalist_architecture_db;
USE minimalist_architecture_db;

-- Drop existing tables if they exist
DROP TABLE IF EXISTS contacts;
DROP TABLE IF EXISTS team;
DROP TABLE IF EXISTS services;
DROP TABLE IF EXISTS projects;

-- Projects table
CREATE TABLE projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    category VARCHAR(100),
    location VARCHAR(255),
    year INT,
    image_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Services table
CREATE TABLE services (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    icon VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Contact submissions table
CREATE TABLE contacts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(50),
    subject VARCHAR(255),
    message TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Team members table
CREATE TABLE team (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    position VARCHAR(255),
    bio TEXT,
    image_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample projects
INSERT INTO projects (title, description, category, location, year, image_url) VALUES
('Modern Residential Villa', 'A stunning contemporary villa featuring clean lines, large glass panels, and seamless indoor-outdoor integration. This luxury residence showcases sustainable design principles with energy-efficient systems and minimalist aesthetic.', 'Residential', 'Beverly Hills, CA', 2024, '/images/project1.jpg'),
('Green Office Complex', 'Award-winning sustainable office building with vertical gardens and natural ventilation. Features LEED Platinum certification and innovative green technology integration with minimalist modern design.', 'Commercial', 'San Francisco, CA', 2023, '/images/project2.jpg'),
('Urban Mixed-Use Development', 'A vibrant mixed-use development combining residential, commercial, and recreational spaces. Designed with minimalist architecture principles to foster community engagement and urban sustainability.', 'Mixed-Use', 'New York, NY', 2024, '/images/project3.jpg'),
('Luxury Mountain Resort', 'Exclusive mountain retreat with breathtaking views and organic architectural forms that blend with the natural landscape. Features minimalist luxury design and local materials with biophilic integration.', 'Hospitality', 'Aspen, CO', 2023, '/images/project4.jpg'),
('Contemporary Art Museum', 'Iconic cultural landmark featuring minimalist innovative structural design and flexible exhibition spaces. The building itself is a work of art that inspires creativity through clean geometric forms.', 'Cultural', 'Los Angeles, CA', 2022, '/images/project5.jpg'),
('Eco-Friendly Housing Complex', 'Sustainable residential complex with green roofs, rainwater harvesting, and community gardens. Designed with minimalist principles for modern urban living with minimal environmental impact.', 'Residential', 'Portland, OR', 2024, '/images/project6.jpg');

-- Insert sample services
INSERT INTO services (name, description, icon) VALUES
('Architectural Design', 'Complete architectural design services from concept to construction documentation. We create innovative, minimalist, and aesthetically pleasing spaces tailored to your vision.', 'design'),
('Interior Design', 'Comprehensive interior design solutions with minimalist principles. We focus on creating harmonious spaces that reflect your lifestyle and enhance functionality.', 'interior'),
('Urban Planning', 'Strategic urban planning and master planning services emphasizing minimalist sustainable design for residential, commercial, and mixed-use developments.', 'urban'),
('Sustainable Design', 'Green building and sustainable design consulting with minimalist approach. We integrate environmental and aesthetic considerations into every project.', 'sustainable'),
('Project Management', 'Full-service project management from conception to completion. Ensuring projects are delivered on time, within budget, and to the highest minimalist quality standards.', 'management'),
('3D Visualization', 'Photorealistic 3D renderings and virtual reality walkthroughs of minimalist designs. Helping clients visualize their projects before construction.', 'visualization');

-- Insert sample team members
INSERT INTO team (name, position, bio, image_url) VALUES
('Sarah Mitchell', 'Principal Architect', 'With over 20 years of experience, Sarah leads our minimalist design team with a focus on sustainable and innovative architecture. Licensed architect and LEED AP.', '/images/team1.jpg'),
('David Chen', 'Senior Designer', 'David specializes in minimalist residential and hospitality projects, bringing creativity and technical expertise to every design. Award-winning designer with international experience.', '/images/team2.jpg'),
('Emily Rodriguez', 'Urban Planner', 'Emily focuses on creating sustainable urban environments with minimalist design principles. Master in Urban Planning from MIT with focus on contemporary design.', '/images/team3.jpg'),
('Michael Thompson', 'Project Manager', 'Michael ensures seamless project execution from concept to completion. Over 15 years of experience managing complex minimalist architectural projects.', '/images/team4.jpg');

-- Verify data
SELECT 'Projects created:' as Status, COUNT(*) as Count FROM projects
UNION ALL
SELECT 'Services created:', COUNT(*) FROM services
UNION ALL
SELECT 'Team members created:', COUNT(*) FROM team;
