DROP TABLE IF EXISTS project_article;
DROP TABLE IF EXISTS project_user;
DROP TABLE IF EXISTS project_user_article;

CREATE TABLE project_article (
  article_id      INT NOT NULL AUTO_INCREMENT,
  article_title   VARCHAR(100),
  article_content TEXT,
  PRIMARY KEY (article_id)
);
CREATE TABLE project_user (
  user_id         INT NOT NULL AUTO_INCREMENT,
  user_firstname  VARCHAR(50),
  user_lastname   VARCHAR(50),
  user_gender     VARCHAR(6),
  user_country    VARCHAR(2),
  user_dob        DATE,
  user_email      VARCHAR(100),
  user_desciption VARCHAR(200),
  user_username   VARCHAR(100),
  user_password   VARCHAR(100),
  PRIMARY KEY (user_id)
);
CREATE TABLE project_user_article (
  comment_id      INT NOT NULL AUTO_INCREMENT,
  user_id         INT,
  article_id      INT,
  article_comment TEXT,
  PRIMARY KEY (comment_id),
  FOREIGN KEY (user_id) REFERENCES project_user (user_id),
  FOREIGN KEY (article_id) REFERENCES project_article (article_id)
);

INSERT INTO project_article (article_content) VALUES ('testContent');

INSERT INTO project_user (user_firstname, user_lastname, user_country, user_gender,user_dob,
                          user_email,user_desciption, user_username, user_password) VALUES
  ('z', 'z', 'AU', 'male',DATE '2015-12-17', 'z@email.com','z', 'z', 'z');

INSERT INTO project_user_article VALUES (1, 1, 'HFHFKAJDKSJF;KAJFLASJFD');

SELECT *
FROM project_article;