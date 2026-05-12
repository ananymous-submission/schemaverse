CREATE TABLE access_log(
    session  varchar(255)
  , user_id  varchar(255)
  , action   varchar(255)
  , stamp    varchar(255)
);

CREATE TABLE action_log(
    session  varchar(255)
  , user_id  varchar(255)
  , action   varchar(255)
  , category varchar(255)
  , products varchar(255)
  , amount   integer
  , stamp    varchar(255)
);

CREATE TABLE action_log_with_ip(
    session  varchar(255)
  , user_id  varchar(255)
  , action   varchar(255)
  , ip       varchar(255)
  , stamp    varchar(255)
);

CREATE TABLE action_log_with_noise(
    stamp       varchar(255)
  , session     varchar(255)
  , action      varchar(255)
  , products    varchar(255)
  , url         text
  , ip          varchar(255)
  , user_agent  text
);

CREATE TABLE activity_log(
    stamp        varchar(255)
  , session      varchar(255)
  , action       varchar(255)
  , option       varchar(255)
  , path         varchar(255)
  , search_type  varchar(255)
);

CREATE TABLE app1_mst_users (
    user_id varchar(255)
  , name    varchar(255)
  , email   varchar(255)
);

CREATE TABLE app2_mst_users (
    user_id varchar(255)
  , name    varchar(255)
  , phone   varchar(255)
);

CREATE TABLE dup_action_log(
    stamp     varchar(255)
  , session   varchar(255)
  , user_id   varchar(255)
  , action    varchar(255)
  , products  varchar(255)
);

CREATE TABLE form_error_log(
    stamp       varchar(255)
  , session     varchar(255)
  , form        varchar(255)
  , field       varchar(255)
  , error_type  varchar(255)
  , value       varchar(255)
);

CREATE TABLE form_log(
    stamp    varchar(255)
  , session  varchar(255)
  , action   varchar(255)
  , path     varchar(255)
  , status   varchar(255)
);

CREATE TABLE invalid_action_log(
    stamp     varchar(255)
  , session   varchar(255)
  , user_id   varchar(255)
  , action    varchar(255)
  , category  varchar(255)
  , products  varchar(255)
  , amount    integer
);

CREATE TABLE mst_categories(
    id     integer
  , name   varchar(255)
  , stamp  varchar(255)
);

CREATE TABLE mst_products_20161201(
    product_id  varchar(255)
  , name        varchar(255)
  , price       integer
  , updated_at  varchar(255)
);

CREATE TABLE mst_products_20170101(
    product_id  varchar(255)
  , name        varchar(255)
  , price       integer
  , updated_at  varchar(255)
);

CREATE TABLE mst_users(
    user_id         varchar(255)
  , sex             varchar(255)
  , birth_date      varchar(255)
  , register_date   varchar(255)
  , register_device varchar(255)
  , withdraw_date   varchar(255)
);

CREATE TABLE mst_users_with_card_number (
    user_id     varchar(255)
  , card_number varchar(255)
);

CREATE TABLE product_sales (
    category_name varchar(255)
  , product_id    varchar(255)
  , sales         integer
);

CREATE TABLE purchase_log (
    purchase_id integer
  , user_id     varchar(255)
  , amount      integer
  , stamp       varchar(255)
);

CREATE TABLE read_log(
    stamp        varchar(255)
  , session      varchar(255)
  , action       varchar(255)
  , url          varchar(255)
);