CREATE TABLE "users" (
  "id" uuid PRIMARY KEY,
  "name" varchar,
  "email" varchar UNIQUE NOT NULL,
  "password" varchar,
  "age" int
);

CREATE TABLE "courses" (
  "id" uuid PRIMARY KEY,
  "title" varchar UNIQUE NOT NULL,
  "description" varchar NOT NULL,
  "level_id" uuid,
  "teacher_id" uuid
);

CREATE TABLE "levels" (
  "id" uuid PRIMARY KEY,
  "level" varchar NOT NULL
);

CREATE TABLE "teachers" (
  "id" uuid PRIMARY KEY,
  "name" varchar UNIQUE NOT NULL,
  "email" varchar UNIQUE NOT NULL
);

CREATE TABLE "users_courses" (
  "id" uuid PRIMARY KEY,
  "user_id" uuid NOT NULL,
  "course_id" uuid NOT NULL
);

CREATE TABLE "course_videos" (
  "id" uuid PRIMARY KEY,
  "course_id" uuid NOT NULL,
  "title" varchar NOT NULL,
  "url" varchar UNIQUE NOT NULL
);

CREATE TABLE "categories" (
  "id" uuid PRIMARY KEY,
  "name" varchar UNIQUE NOT NULL
);

CREATE TABLE "courses_categories" (
  "id" uuid PRIMARY KEY,
  "course_id" uuid NOT NULL,
  "category_id" uuid NOT NULL
);

ALTER TABLE "course_videos" ADD FOREIGN KEY ("course_id") REFERENCES "courses" ("id");

ALTER TABLE "users_courses" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "users_courses" ADD FOREIGN KEY ("course_id") REFERENCES "courses" ("id");

ALTER TABLE "courses_categories" ADD FOREIGN KEY ("course_id") REFERENCES "courses" ("id");

ALTER TABLE "courses_categories" ADD FOREIGN KEY ("category_id") REFERENCES "categories" ("id");

ALTER TABLE "courses" ADD FOREIGN KEY ("teacher_id") REFERENCES "teachers" ("id");

ALTER TABLE "courses" ADD FOREIGN KEY ("level_id") REFERENCES "levels" ("id");


-- insert data to users
INSERT INTO users ( id, name, email, password, age) 
VALUES (
  gen_random_uuid(),
  'Andres Camacho',
  'anca@yahoo.com',
  '123456',
  '45'
);

INSERT INTO users ( id, name, email, password, age ) 
VALUES (
  gen_random_uuid(),
  'Sara Perez',
  'sarita23@yahoo.com',
  '7894sd',
  '26'
);

--insert data to categories
INSERT INTO categories ( id, name) 
VALUES (
  gen_random_uuid(),
  'entretenimiento'  
);

INSERT INTO categories ( id, name)
VALUES (
  gen_random_uuid(),
  'musica'  
);

INSERT INTO categories ( id, name) 
VALUES (
  gen_random_uuid(),
  'pintura'  
);

-- insert data teachers

INSERT INTO teachers( id, name, email) 
VALUES (
  gen_random_uuid(),
  'Luis Cano',
  'luis@gmail.com'
);

INSERT INTO teachers( id, name, email)
VALUES (
  gen_random_uuid(),
  'Ana Bello',
  'ana@gmail.com'
);

-- insert data levels

INSERT INTO levels( id, level) 
VALUES (
  gen_random_uuid(),
  'principiante'
);

INSERT INTO levels( id, level ) 
VALUES (
  gen_random_uuid(),
  'intermedio'
);

INSERT INTO levels( id, level) 
VALUES (
  gen_random_uuid(),
  'avanzado'
);

--insert data courses

INSERT INTO courses ( id, title, description, level_id, teacher_id )
VALUES (
  gen_random_uuid(),
  'GUITARRA CLASICA 1',
  'aprende a tocar guitarra desde cero',
  (SELECT id FROM levels WHERE levels.level = 'principiante'),
  (SELECT id FROM teachers WHERE teachers.email = 'luis@gmail.com')
);

INSERT INTO courses ( id, title, description, level_id, teacher_id )
VALUES (
  gen_random_uuid(),
  'PINTURA AL OLEO 2',
  'aprende a pintar al oleo, nivel 2',
  (SELECT id FROM levels WHERE levels.level = 'intermedio'),
  (SELECT id FROM teachers WHERE teachers.email = 'ana@gmail.com')
);

--insert data course_videos

INSERT INTO course_videos ( id, course_id, title, url)
VALUES (
  gen_random_uuid(),
  (SELECT id FROM courses WHERE title LIKE '%GUITARRA%'),
  'partes de la guitarra 1',
  'www.youtube.com/q;lkj23ff'
);

INSERT INTO course_videos ( id, course_id, title, url)
VALUES (
  gen_random_uuid(),
  (SELECT id FROM courses WHERE title LIKE '%PINTURA%'),
  'introduccion al estilo paisajista',
  'www.youtube.com/q;lkj23324gfff'
);

-- insert data courses_categories

INSERT INTO courses_categories ( id, course_id, category_id )
VALUES (
  gen_random_uuid(),
  (SELECT id FROM courses WHERE title LIKE '%GUITARRA%'),
  (SELECT id FROM categories WHERE "name" LIKE '%musica%')
);

INSERT INTO courses_categories ( id, course_id, category_id )
VALUES (
  gen_random_uuid(),
  (SELECT id FROM courses WHERE title LIKE '%GUITARRA%'),
  (SELECT id FROM categories WHERE "name" LIKE '%entretenimiento%')
);

INSERT INTO courses_categories ( id, course_id, category_id )
VALUES (
  gen_random_uuid(),
  (SELECT id FROM courses WHERE title LIKE '%PINTURA%'),
  (SELECT id FROM categories WHERE "name" LIKE '%pintura%')
);

INSERT INTO courses_categories ( id, course_id, category_id )
VALUES (
  gen_random_uuid(),
  (SELECT id FROM courses WHERE title LIKE '%PINTURA%'),
  (SELECT id FROM categories WHERE "name" LIKE '%entretenimiento%')
);

--insert data users_courses

INSERT INTO users_courses ( id, user_id, course_id )
VALUES (
  gen_random_uuid(),
  (SELECT id FROM users WHERE email = 'anca@yahoo.com'),
  (SELECT id FROM courses WHERE title LIKE '%GUITARRA%')
);

INSERT INTO users_courses ( id, user_id, course_id )
VALUES (
  gen_random_uuid(),
  (SELECT id FROM users WHERE email = 'sarita23@yahoo.com'),
  (SELECT id FROM courses WHERE title LIKE '%OLEO%')
);
