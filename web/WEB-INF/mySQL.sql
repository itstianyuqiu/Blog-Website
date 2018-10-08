DROP TABLE IF EXISTS project_user_article;
DROP TABLE IF EXISTS project_article;
DROP TABLE IF EXISTS project_user;

CREATE TABLE project_article (
  article_id      INT NOT NULL AUTO_INCREMENT,
  article_title VARCHAR(100),
  article_content TEXT,
  PRIMARY KEY (article_id)
);

CREATE TABLE project_user (
  user_id         INT         NOT NULL AUTO_INCREMENT,
  user_firstname  VARCHAR(50) NOT NULL,
  user_lastname   VARCHAR(50) NOT NULL,
  user_country    VARCHAR(2),
  user_dob        DATE,
  user_desciption VARCHAR(200),
  user_username   VARCHAR(100),
  user_password   VARCHAR(100),
  PRIMARY KEY (user_id)
);
CREATE TABLE project_user_article (
  user_id         INT,
  article_id      INT,
  article_comment TEXT,
  PRIMARY KEY (user_id, article_id),
  FOREIGN KEY (user_id) REFERENCES project_user (user_id),
  FOREIGN KEY (article_id) REFERENCES project_article (article_id)
);

INSERT INTO project_article (article_id, article_title, article_content) VALUES (1, 'testTitle', 'testContent');
INSERT INTO project_article (article_title, article_content) VALUES ('testTitle', 'testContent');

INSERT INTO project_user (user_firstname, user_lastname, user_country, user_dob,
                          user_desciption, user_username, user_password) VALUES
  ('aaaa', 'aaa', 'NZ', DATE '2015-12-17', 'AAAAAAAA', 'USER', 'PASSWORD');

INSERT INTO project_user_article VALUES (1, 1, 'HFHFKAJDKSJF;KAJFLASJFD');
INSERT INTO project_user_article VALUES (1, 2, 'HFHFKAJDKSJF;KAJFLASJFD');
INSERT INTO project_user_article VALUES (1, 3, 'HFHFKAJDKSJF;KAJFLASJFD');
INSERT INTO project_user_article VALUES (2, 2, 'HFHFKAJDKSJF;KAJFLASJFD');
INSERT INTO project_user_article VALUES (3, 3, 'HFHFKAJDKSJF;KAJFLASJFD');

SELECT * FROM project_article;

SELECT * FROM project_user;

DELETE FROM project_user_article WHERE article_id = 1;
DELETE FROM project_article WHERE article_id = 1;

INSERT INTO project_user_article (user_id, article_id) VALUES (1,2);

SELECT article_id FROM project_article ORDER BY article_id DESC LIMIT 1;

SELECT * FROM project_user_article;

SELECT article_comment FROM project_user_article WHERE user_id = 1 AND article_id = 3;