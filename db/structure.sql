CREATE TABLE "authentications" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer NOT NULL, "provider" varchar(255) NOT NULL, "uid" varchar(255) NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "token" varchar(255), "token_secret" varchar(255));
CREATE TABLE "events" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "description" text, "starts_at" datetime, "duration" integer, "slots" integer DEFAULT 1 NOT NULL, "bench_count" integer DEFAULT 0 NOT NULL, "user_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "title" varchar(255), "deleted_at" datetime, "platform_id" integer);
CREATE TABLE "participants" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "event_id" integer, "user_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "platform_accounts" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "platform_id" integer, "username" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "platforms" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "username" varchar(255) NOT NULL, "email" varchar(255), "crypted_password" varchar(255), "salt" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "slug" varchar(255), "time_zone" varchar(255), "avatar_url" varchar(255), "keep_notified" boolean);
CREATE INDEX "index_events_on_platform_id" ON "events" ("platform_id");
CREATE INDEX "index_platform_accounts_on_platform_id" ON "platform_accounts" ("platform_id");
CREATE UNIQUE INDEX "index_platform_accounts_on_platform_id_and_user_id" ON "platform_accounts" ("platform_id", "user_id");
CREATE INDEX "index_platform_accounts_on_user_id" ON "platform_accounts" ("user_id");
CREATE UNIQUE INDEX "index_users_on_slug" ON "users" ("slug");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20121123181944');

INSERT INTO schema_migrations (version) VALUES ('20121123183111');

INSERT INTO schema_migrations (version) VALUES ('20121124174128');

INSERT INTO schema_migrations (version) VALUES ('20121124183327');

INSERT INTO schema_migrations (version) VALUES ('20121126160237');

INSERT INTO schema_migrations (version) VALUES ('20130201220238');

INSERT INTO schema_migrations (version) VALUES ('20130206210215');

INSERT INTO schema_migrations (version) VALUES ('20130212184523');

INSERT INTO schema_migrations (version) VALUES ('20130213205316');

INSERT INTO schema_migrations (version) VALUES ('20130213212011');

INSERT INTO schema_migrations (version) VALUES ('20130214180633');

INSERT INTO schema_migrations (version) VALUES ('20130214181752');

INSERT INTO schema_migrations (version) VALUES ('20130214182408');

INSERT INTO schema_migrations (version) VALUES ('20130215030548');

INSERT INTO schema_migrations (version) VALUES ('20130215031444');

INSERT INTO schema_migrations (version) VALUES ('20130215153724');

INSERT INTO schema_migrations (version) VALUES ('20130218170157');

INSERT INTO schema_migrations (version) VALUES ('20130219183118');