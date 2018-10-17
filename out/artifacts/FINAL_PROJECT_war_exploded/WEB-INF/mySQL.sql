DROP TABLE IF EXISTS project_comment_relationship;
DROP TABLE IF EXISTS project_article_comment;
DROP TABLE IF EXISTS project_article_images;
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
  user_avatar     VARCHAR(500),
  PRIMARY KEY (user_id)
);

CREATE TABLE project_article (
  article_id      INT NOT NULL AUTO_INCREMENT,
  article_title   VARCHAR(100),
  article_content TEXT,
  author_id  INT,
  article_visibility BOOLEAN,
  article_date DATE,
  FOREIGN KEY (author_id) REFERENCES project_user (user_id),
  PRIMARY KEY (article_id)
);


CREATE TABLE project_article_comment (
  comment_id      INT NOT NULL AUTO_INCREMENT,
  user_id         INT,
  article_id      INT,
  article_comment TEXT,
  comment_visibility BOOLEAN,
  on_article BOOLEAN,
  is_parent BOOLEAN,
  PRIMARY KEY (comment_id),
  FOREIGN KEY (user_id) REFERENCES project_user (user_id),
  FOREIGN KEY (article_id) REFERENCES project_article (article_id)
);

CREATE TABLE project_comment_relationship (
  parent_id        INT,
  child_id         INT,
  PRIMARY KEY (parent_id,child_id),
  FOREIGN KEY (parent_id) REFERENCES project_article_comment (comment_id),
  FOREIGN KEY (child_id) REFERENCES project_article_comment (comment_id)
);

CREATE TABLE project_article_images (
  image_id INT NOT NULL AUTO_INCREMENT,
  article_id INT,
  image_source TEXT,
  FOREIGN KEY (article_id) REFERENCES project_article (article_id),
  PRIMARY KEY (image_id)
);

INSERT INTO project_article (article_title, article_content, author_id, article_visibility,article_date) VALUES ('heading 2', 'content article 2', 1, TRUE, DATE '2018-03-17');

INSERT INTO project_user (user_firstname, user_lastname, user_country, user_dob,
                          user_desciption, user_username, user_password) VALUES
  ('b2', 'b2', 'NZ', DATE '2015-12-17', 'b', 'b', 'b');

INSERT INTO project_article_comment (user_id, article_id, article_comment, comment_visibility, on_article, is_parent) VALUES (1, 1, 'user 1, article 1', TRUE, TRUE, TRUE);
INSERT INTO project_article_comment (user_id, article_id, article_comment, comment_visibility, on_article, is_parent) VALUES (1, 1, 'user 1, article 2', TRUE, TRUE, FALSE);
INSERT INTO project_article_comment (user_id, article_id, article_comment, comment_visibility, on_article, is_parent) VALUES (1, 1, 'user 1, article 2a', TRUE, FALSE, FALSE);

INSERT INTO project_comment_relationship (parent_id, child_id) VALUES (1, 3);


SELECT *
FROM project_article;

SELECT *
FROM project_user;

SELECT article_id
FROM project_user_article
WHERE user_id = 1;
SELECT * FROM project_article_comment;

SELECT * FROM project_comment_relationship;

SELECT * FROM project_article_images;

SELECT comment_id, user_id, article_comment FROM project_article_comment WHERE article_id = 1;

SELECT comment_id, user_id, article_comment FROM project_article_comment WHERE article_id = ?;

SELECT * FROM project_article JOIN project_article_comment ON project_article.article_id = project_article_comment.article_id WHERE user_id = 1;

SELECT article_id FROM project_article ORDER BY article_id DESC ;

UPDATE project_article SET article_visibility = FALSE WHERE article_id = 8;

SELECT article_visibility FROM project_article WHERE article_id = 8;

SELECT * FROM project_article WHERE article_visibility = TRUE AND article_date <= CURDATE();

SELECT child_id FROM project_comment_relationship WHERE parent_id = 1;

SELECT *
FROM project_user_article;
SELECT * FROM project_article_comment WHERE comment_id = 3;

SELECT
  comment_id,
  user_id,
  article_comment
FROM project_user_article
WHERE article_id = 1;
UPDATE project_article_comment SET is_parent = TRUE WHERE comment_id = 2;

SELECT
  comment_id,
  user_id,
  article_comment
FROM project_user_article
WHERE article_id = ?;
SELECT * FROM project_article_comment WHERE article_id = 1;

SELECT *
FROM project_article
  JOIN project_user_article ON project_article.article_id = project_user_article.article_id
WHERE user_id = 1;
DELETE * FROM project_comment_relationship WHERE parent_id =

SELECT comment_id FROM project_article_comment WHERE is_parent = TRUE AND article_id = 1;

INSERT INTO project_article_images (article_id, image_source) VALUES (?, ?);