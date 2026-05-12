-- Reconstruction SQL: Attach local databases and create views
-- that reconstruct the original tables.

ATTACH DATABASE 'local_1.sqlite' AS "local_1";
ATTACH DATABASE 'local_2.sqlite' AS "local_2";
ATTACH DATABASE 'local_3.sqlite' AS "local_3";
ATTACH DATABASE 'local_4.sqlite' AS "local_4";
ATTACH DATABASE 'local_5.sqlite' AS "local_5";

-- Reconstruct address from local_1.street_address
CREATE VIEW "address" AS
SELECT
    "local_1"."street_address"."location_id" AS "address_id",
    "local_1"."street_address"."house_number" AS "street_number",
    "local_1"."street_address"."street_label" AS "street_name",
    "local_1"."street_address"."locality_name" AS "city",
    "local_1"."street_address"."country_ref" AS "country_id"
FROM "local_1"."street_address";

-- Reconstruct address_status from local_2.addressStatusLookup
CREATE VIEW "address_status" AS
SELECT
    "local_2"."addressStatusLookup"."statusKey" AS "status_id",
    "local_2"."addressStatusLookup"."statusLabel" AS "address_status"
FROM "local_2"."addressStatusLookup";

-- Reconstruct author from local_3.auth_rec
CREATE VIEW "author" AS
SELECT
    "local_3"."auth_rec"."auth_id" AS "author_id",
    "local_3"."auth_rec"."auth_nm" AS "author_name"
FROM "local_3"."auth_rec";

-- Reconstruct book from row partitions (UNION (overlap))
CREATE VIEW "book" AS
SELECT "local_4"."BooksMax192Pages"."BookKey" AS "book_id", "local_4"."BooksMax192Pages"."BookTitle" AS "title", "local_4"."BooksMax192Pages"."Isbn13Code" AS "isbn13", "local_4"."BooksMax192Pages"."LanguageKey" AS "language_id", "local_4"."BooksMax192Pages"."PageCount" AS "num_pages", "local_4"."BooksMax192Pages"."ReleaseDate" AS "publication_date", "local_4"."BooksMax192Pages"."PublisherKey" AS "publisher_id" FROM "local_4"."BooksMax192Pages"
UNION
SELECT "local_4"."BooksOver416OrNullPages"."BookKey" AS "book_id", "local_4"."BooksOver416OrNullPages"."BookTitle" AS "title", "local_4"."BooksOver416OrNullPages"."Isbn13Code" AS "isbn13", "local_4"."BooksOver416OrNullPages"."LanguageKey" AS "language_id", "local_4"."BooksOver416OrNullPages"."PageCount" AS "num_pages", "local_4"."BooksOver416OrNullPages"."ReleaseDate" AS "publication_date", "local_4"."BooksOver416OrNullPages"."PublisherKey" AS "publisher_id" FROM "local_4"."BooksOver416OrNullPages"
UNION
SELECT "local_5"."booksPages193To299"."bookId" AS "book_id", "local_5"."booksPages193To299"."bookTitle" AS "title", "local_5"."booksPages193To299"."isbn13Code" AS "isbn13", "local_5"."booksPages193To299"."languageId" AS "language_id", "local_5"."booksPages193To299"."pageCount" AS "num_pages", "local_5"."booksPages193To299"."publicationDate" AS "publication_date", "local_5"."booksPages193To299"."publisherId" AS "publisher_id" FROM "local_5"."booksPages193To299"
UNION
SELECT "local_5"."booksPages300To416"."bookId" AS "book_id", "local_5"."booksPages300To416"."bookTitle" AS "title", "local_5"."booksPages300To416"."isbn13Code" AS "isbn13", "local_5"."booksPages300To416"."languageId" AS "language_id", "local_5"."booksPages300To416"."pageCount" AS "num_pages", "local_5"."booksPages300To416"."publicationDate" AS "publication_date", "local_5"."booksPages300To416"."publisherId" AS "publisher_id" FROM "local_5"."booksPages300To416";

-- Reconstruct book_author from local_3.bk_auth_map
CREATE VIEW "book_author" AS
SELECT
    "local_3"."bk_auth_map"."bk_id" AS "book_id",
    "local_3"."bk_auth_map"."auth_id" AS "author_id"
FROM "local_3"."bk_auth_map";

-- Reconstruct book_language from local_4.LanguageCatalog
CREATE VIEW "book_language" AS
SELECT
    "local_4"."LanguageCatalog"."LanguageKey" AS "language_id",
    "local_4"."LanguageCatalog"."LanguageIsoCode" AS "language_code",
    "local_4"."LanguageCatalog"."LanguageDisplayName" AS "language_name"
FROM "local_4"."LanguageCatalog";

-- Reconstruct country from local_1.nation
CREATE VIEW "country" AS
SELECT
    "local_1"."nation"."nation_id" AS "country_id",
    "local_1"."nation"."nation_name" AS "country_name"
FROM "local_1"."nation";

-- Reconstruct cust_order from local_1.customer_order
CREATE VIEW "cust_order" AS
SELECT
    "local_1"."customer_order"."purchase_id" AS "order_id",
    "local_1"."customer_order"."placed_at" AS "order_date",
    "local_1"."customer_order"."client_ref" AS "customer_id",
    "local_1"."customer_order"."delivery_option_ref" AS "shipping_method_id",
    "local_1"."customer_order"."destination_address_ref" AS "dest_address_id"
FROM "local_1"."customer_order";

-- Reconstruct customer from local_1.client_profile
CREATE VIEW "customer" AS
SELECT
    "local_1"."client_profile"."client_id" AS "customer_id",
    "local_1"."client_profile"."given_name" AS "first_name",
    "local_1"."client_profile"."family_name" AS "last_name",
    "local_1"."client_profile"."contact_email" AS "email"
FROM "local_1"."client_profile";

-- Reconstruct customer_address from row partitions (UNION (overlap))
CREATE VIEW "customer_address" AS
SELECT "local_1"."client_address_status_greater_than_one"."client_id" AS "customer_id", "local_1"."client_address_status_greater_than_one"."address_ref" AS "address_id", "local_1"."client_address_status_greater_than_one"."link_status_id" AS "status_id" FROM "local_1"."client_address_status_greater_than_one"
UNION
SELECT "local_2"."customerAddressStatusUpToOne"."customerIdRef" AS "customer_id", "local_2"."customerAddressStatusUpToOne"."addressIdRef" AS "address_id", "local_2"."customerAddressStatusUpToOne"."statusKeyRef" AS "status_id" FROM "local_2"."customerAddressStatusUpToOne";

-- Reconstruct order_history from local_1.order_event_log
CREATE VIEW "order_history" AS
SELECT
    "local_1"."order_event_log"."event_id" AS "history_id",
    "local_1"."order_event_log"."purchase_ref" AS "order_id",
    "local_1"."order_event_log"."status_ref" AS "status_id",
    "local_1"."order_event_log"."status_timestamp" AS "status_date"
FROM "local_1"."order_event_log";

-- Reconstruct order_line from row partitions (UNION (overlap))
CREATE VIEW "order_line" AS
SELECT "local_4"."OrderLinesPriceRange4Point86To9Point95"."LineKey" AS "line_id", "local_4"."OrderLinesPriceRange4Point86To9Point95"."OrderKey" AS "order_id", "local_4"."OrderLinesPriceRange4Point86To9Point95"."BookKey" AS "book_id", "local_4"."OrderLinesPriceRange4Point86To9Point95"."UnitPrice" AS "price" FROM "local_4"."OrderLinesPriceRange4Point86To9Point95"
UNION
SELECT "local_4"."OrderLinesPriceRange9Point95To15Point05"."LineKey" AS "line_id", "local_4"."OrderLinesPriceRange9Point95To15Point05"."OrderKey" AS "order_id", "local_4"."OrderLinesPriceRange9Point95To15Point05"."BookKey" AS "book_id", "local_4"."OrderLinesPriceRange9Point95To15Point05"."UnitPrice" AS "price" FROM "local_4"."OrderLinesPriceRange9Point95To15Point05"
UNION
SELECT "local_5"."orderLinesPriceAtMost4Point86"."lineId" AS "line_id", "local_5"."orderLinesPriceAtMost4Point86"."orderId" AS "order_id", "local_5"."orderLinesPriceAtMost4Point86"."bookId" AS "book_id", "local_5"."orderLinesPriceAtMost4Point86"."linePrice" AS "price" FROM "local_5"."orderLinesPriceAtMost4Point86"
UNION
SELECT "local_5"."orderLinesPriceAbove15Point05OrNull"."lineId" AS "line_id", "local_5"."orderLinesPriceAbove15Point05OrNull"."orderId" AS "order_id", "local_5"."orderLinesPriceAbove15Point05OrNull"."bookId" AS "book_id", "local_5"."orderLinesPriceAbove15Point05OrNull"."linePrice" AS "price" FROM "local_5"."orderLinesPriceAbove15Point05OrNull";

-- Reconstruct order_status from local_1.order_status_lookup
CREATE VIEW "order_status" AS
SELECT
    "local_1"."order_status_lookup"."status_code_id" AS "status_id",
    "local_1"."order_status_lookup"."status_label" AS "status_value"
FROM "local_1"."order_status_lookup";

-- Reconstruct publisher from local_5.publisherDirectory
CREATE VIEW "publisher" AS
SELECT
    "local_5"."publisherDirectory"."publisherId" AS "publisher_id",
    "local_5"."publisherDirectory"."publisherName" AS "publisher_name"
FROM "local_5"."publisherDirectory";

-- Reconstruct shipping_method from local_1.delivery_option
CREATE VIEW "shipping_method" AS
SELECT
    "local_1"."delivery_option"."option_id" AS "method_id",
    "local_1"."delivery_option"."option_label" AS "method_name",
    "local_1"."delivery_option"."price" AS "cost"
FROM "local_1"."delivery_option";
