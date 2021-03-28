/*
*   ***************                       Задание №1                    ***********************
*
*   Вот смотрю на базу данных VK и не могу понять к чему придраться. Как всё работает я понимаю, но чувствую себя
*   как эскимос, которому доходчиво объяснили как кататься на водных лыжах, а потом спросили - что можно поменять
*   в конструкции лыж, чтобы катание на них было ещё более комфортным? Хотя больше пяти литров размороженной воды
*   он в жизни не видел.
*
*   Вопрос: А если user удалил свой профиль, его id становится мёртвым или назначается другому пользователю?
*
*   Я в Вконтакте только зарегестрирован, но появляюсь там раз в два года, поэтому могу что-то не предусмотреть.
*
*
*
*/

/*
*   ***************                       Задание №2                    ***********************
*
*    Таблица user_posts (посты пользователя). У одного пользователя может быть много постов, у любого поста один
*    один пользователь. Отношение один ко многим. Для хранения понадобится id, автор поста, дата создания, заголовок
*    (или описание, которого может и не быть), тип поста (фото, видео, аудио, текст). Тип поста можно хранить в виде
*    ссылки на название типа в каталоге media_types (id типа медиафайла из таблицы media_types) В поле автор поста
*    делаем ссыдку на user_id из таблицы users. В загаловок я поставил 1000 символов, так как это может быть описание
*    фото или видео. Или может надо было отдельно заголовок и описание? Делаем индекс на автора постов.
*
*    Таблица - posts_like. Лайки на посты пользователей. Тут связь многие ко многим. Данные, которые нужны - id поста,
*    id пользователя, который лайкнул; Идентификатор не нужен, так как один пользователь может поставить только один
*    лайк. Чтобы уникально идентифицировать пару пост-лайк делаем PRIMARY KEY по двум колонкам. Чует моя опа, что
*    тут больше не надо столбцов - хватит два. Но я могу ошибаться.
*
*    Таблица "чёрный список". У пользователя может быть несколько людей в чс и каждый пользователь может быть в чс у
*    многих - связь многие ко многим. Понятно, что в таблице должны быть id юзера который.. и id юзера которого..
*    Третий столбец, в котором было бы, например, True или False, по моему абсолютно не нужен - человек либо в чс,
*    либо он человек. PRIMARY KEY по двум колонкам.
*
*
*/
USE vk;

CREATE TABLE user_posts (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  author_id BIGINT UNSIGNED NOT NULL,
  post_type INT UNSIGNED NOT NULL,
  post_heading VARCHAR(1000) DEFAULT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX posts_author_idx (author_id),
  CONSTRAINT fk_user_posts_author FOREIGN KEY (author_id) REFERENCES vk.users (id),
  CONSTRAINT fk_user_posts_type FOREIGN KEY (post_type) REFERENCES vk.media_types (id)
);


CREATE TABLE posts_like (
    post_like_id BIGINT UNSIGNED NOT NULL,
    user_like_id BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (post_like_id, user_like_id),
    CONSTRAINT fk_posts_like_post FOREIGN KEY (post_like_id) REFERENCES vk.user_posts (id),
    CONSTRAINT fk_posts_like_user FOREIGN KEY (user_like_id) REFERENCES vk.users (id)
);


CREATE TABLE blacklist (
    victim_user_id BIGINT UNSIGNED NOT NULL,
    guilty_user_id BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (victim_user_id, guilty_user_id),
    CONSTRAINT fk_blacklist_victim FOREIGN KEY (victim_user_id) REFERENCES vk.users (id),
    CONSTRAINT fk_blacklist_guilty FOREIGN KEY (guilty_user_id) REFERENCES vk.users (id)
);

