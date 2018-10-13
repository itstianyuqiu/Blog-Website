DROP TABLE IF EXISTS project_user_article;
DROP TABLE IF EXISTS project_article;
DROP TABLE IF EXISTS project_user;



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

CREATE TABLE project_article (
  article_id      INT NOT NULL AUTO_INCREMENT,
  article_title   VARCHAR(100),
  article_content TEXT,
  author_id  INT,
  FOREIGN KEY (author_id) REFERENCES project_user (user_id),
  PRIMARY KEY (article_id)
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

INSERT INTO project_article (article_title, article_content, author_id) VALUES ('heading 1', 'content artticle 1', 2);

INSERT INTO project_user (user_firstname, user_lastname, user_country, user_dob,
                          user_desciption, user_username, user_password) VALUES
  ('b', 'b', 'NZ', DATE '2015-12-17', 'b', 'b', 'b');

INSERT INTO project_user_article (user_id, article_id, article_comment) VALUES (1, 1, 'user 1, article 1');
INSERT INTO project_user_article (user_id, article_id, article_comment) VALUES (3, 1, 'user 3, article 1');
INSERT INTO project_user_article (user_id, article_id, article_comment) VALUES (2, 1, 'user 2, article 1');


SELECT * FROM project_article;

SELECT * FROM project_user;

SELECT article_id FROM project_user_article WHERE user_id = 1;

SELECT * FROM project_user_article;

SELECT comment_id, user_id, article_comment FROM project_user_article WHERE article_id = 1;

SELECT comment_id, user_id, article_comment FROM project_user_article WHERE article_id = ?;

SELECT * FROM project_article JOIN project_user_article ON project_article.article_id = project_user_article.article_id WHERE user_id = 1;

SELECT article_id FROM project_article ORDER BY article_id DESC ;