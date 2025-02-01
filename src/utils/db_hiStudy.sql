-- Creating roles table
CREATE TABLE roles (
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(30) NOT NULL UNIQUE
);


-- Creating users table
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    role_id INTEGER NOT NULL,
    fname VARCHAR(25) NOT NULL,
    lname VARCHAR(25) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    hashed_pwd VARCHAR(255) NOT NULL,
    age INTEGER,
    dob DATE NOT NULL,
    avatar_url TEXT,
    facebook_app_id VARCHAR(255),
    google_app_id VARCHAR(255),
    refresh_token VARCHAR(255),
    media_urls JSONB,
    FOREIGN KEY (role_id) REFERENCES roles (role_id)
);

-- Creating codes table
CREATE TABLE codes (
    code_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    verify_code VARCHAR(8) NOT NULL,
    verify_type VARCHAR(255) NOT NULL,
    expired TIMESTAMP NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (user_id)
);

-- Creating memberships table
CREATE TABLE memberships (
    tier_id SERIAL PRIMARY KEY,
    tier_name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255)
);

-- Creating students table
CREATE TABLE students (
    student_id INTEGER PRIMARY KEY,
    tier_id INTEGER NOT NULL,
    major VARCHAR(50),
    edu_level VARCHAR(50),
    headline VARCHAR(50),
    FOREIGN KEY (student_id) REFERENCES users (user_id),
    FOREIGN KEY (tier_id) REFERENCES memberships (tier_id)
);

-- Creating admins table
CREATE TABLE admins (
    admin_id INTEGER PRIMARY KEY,
    priority VARCHAR(20) NOT NULL,
    FOREIGN KEY (admin_id) REFERENCES users (user_id)
);

-- Creating instructors table
CREATE TABLE instructors (
    instructor_id INTEGER PRIMARY KEY,
    bio VARCHAR(255),
    job VARCHAR(255),
    verified BOOLEAN NOT NULL,
    FOREIGN KEY (instructor_id) REFERENCES users (user_id)
);

-- Creating courses table
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    thumbnail_url TEXT,
    trailer_url TEXT,
    url TEXT,
    price FLOAT,
    date_created DATE NOT NULL,
    date_updated DATE
);

-- Creating modules table
CREATE TABLE modules (
    module_id SERIAL PRIMARY KEY,
    course_id INTEGER NOT NULL,
    module_name VARCHAR(100),
    FOREIGN KEY (course_id) REFERENCES courses (course_id)
);

-- Creating lessons table
CREATE TABLE lessons (
    lesson_id SERIAL PRIMARY KEY,
    module_id INTEGER NOT NULL,
    lesson_name VARCHAR(100),
    video_url VARCHAR(100),
    duration FLOAT,
    FOREIGN KEY (module_id) REFERENCES modules (module_id)
);

-- Creating categories table
CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(30) NOT NULL UNIQUE
);

-- Creating resources table
CREATE TABLE resources (
    resource_id SERIAL PRIMARY KEY,
    lesson_id INTEGER NOT NULL,
    resource_name VARCHAR(100),
    resource_url VARCHAR(255),
    FOREIGN KEY (lesson_id) REFERENCES lessons (lesson_id)
);

-- Creating voucher_types table
CREATE TABLE voucher_types (
    type_id SERIAL PRIMARY KEY,
    type_name VARCHAR(30) NOT NULL UNIQUE
);

-- Creating vouchers table
CREATE TABLE vouchers (
    voucher_id SERIAL PRIMARY KEY,
    voucher_code VARCHAR(12),
    discount_value FLOAT NOT NULL,
    expired TIMESTAMP,
    type_id INTEGER NOT NULL,
    FOREIGN KEY (type_id) REFERENCES categories (category_id) 
);

-- Creating enrollments table
CREATE TABLE enrollments (
    uuid SERIAL PRIMARY KEY,
    course_id INTEGER NOT NULL,
    student_id INTEGER NOT NULL,
    date_enrolled DATE NOT NULL,
    completion_status BOOLEAN NOT NULL,
    FOREIGN KEY (course_id) REFERENCES courses (course_id),
    FOREIGN KEY (student_id) REFERENCES students (st_id)
);

-- Creating likes table
CREATE TABLE likes (
    uuid SERIAL PRIMARY KEY,
    course_id INTEGER NOT NULL,
    student_id INTEGER NOT NULL,
    date_liked DATE NOT NULL,
    like_status BOOLEAN NOT NULL,
    FOREIGN KEY (course_id) REFERENCES courses (course_id),
    FOREIGN KEY (student_id) REFERENCES users (user_id)
);

-- Creating reviews table
CREATE TABLE reviews (
    uuid SERIAL PRIMARY KEY,
    course_id INTEGER NOT NULL,
    student_id INTEGER NOT NULL,
    date_reviewed DATE NOT NULL,
    rating INTEGER NOT NULL,
    content VARCHAR(255),
    FOREIGN KEY (course_id) REFERENCES courses (course_id),
    FOREIGN KEY (student_id) REFERENCES users (user_id)
);

-- Creating courses_instructors table
CREATE TABLE courses_instructors (
    course_id INTEGER NOT NULL,
    instructor_id INTEGER NOT NULL,
    joined_date DATE NOT NULL,
    PRIMARY KEY (course_id, instructor_id),
    FOREIGN KEY (course_id) REFERENCES courses (course_id),
    FOREIGN KEY (instructor_id) REFERENCES users (user_id)
);

-- Creating chats table
CREATE TABLE chats (
    chat_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    room_id INTEGER NOT NULL,
    date_created TIMESTAMP NOT NULL,
    content VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES users (user_id)
);
