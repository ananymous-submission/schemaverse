SELECT `group`.id AS group_id, `group`.name AS group_name, `group`.domain_id AS group_domain_id, `group`.description AS group_description, `group`.extra AS group_extra 
FROM `group` INNER JOIN user_group_membership ON `group`.id = user_group_membership.group_id 
WHERE user_group_membership.user_id = 'ccbbd0bdf0104ea68a37483b13b14be2';

SELECT password.id AS password_id, password.local_user_id AS password_local_user_id, password.password AS password_password, local_user_1.id AS local_user_1_id 
FROM (SELECT user.id AS user_id 
FROM user 
WHERE user.id = 'ccbbd0bdf0104ea68a37483b13b14be2') AS anon_1 INNER JOIN local_user AS local_user_1 ON anon_1.user_id = local_user_1.user_id INNER JOIN password ON local_user_1.id = password.local_user_id ORDER BY local_user_1.id;

SELECT user.id AS user_id, user.enabled AS user_enabled, user.extra AS user_extra, user.default_project_id AS user_default_project_id 
FROM user 
WHERE user.id = 'ccbbd0bdf0104ea68a37483b13b14be2';

SELECT federated_user.id AS federated_user_id, federated_user.user_id AS federated_user_user_id, federated_user.idp_id AS federated_user_idp_id, federated_user.protocol_id AS federated_user_protocol_id, federated_user.unique_id AS federated_user_unique_id, federated_user.display_name AS federated_user_display_name, anon_1.user_id AS anon_1_user_id
FROM (SELECT user.id AS user_id
FROM user INNER JOIN local_user ON user.id = local_user.user_id
WHERE local_user.name = 'prime_helix.306sonic' AND local_user.domain_id = 'default') AS anon_1 INNER JOIN federated_user ON anon_1.user_id = federated_user.user_id ORDER BY anon_1.user_id;

SELECT local_user.id AS local_user_id, local_user.user_id AS local_user_user_id, local_user.domain_id AS local_user_domain_id, local_user.name AS local_user_name, anon_1.user_id AS anon_1_user_id
FROM (SELECT user.id AS user_id
FROM user
WHERE user.id = 'ccbbd0bdf0104ea68a37483b13b14be2') AS anon_1 INNER JOIN local_user ON anon_1.user_id = local_user.user_id ORDER BY anon_1.user_id;

SELECT federated_user.id AS federated_user_id, federated_user.user_id AS federated_user_user_id, federated_user.idp_id AS federated_user_idp_id, federated_user.protocol_id AS federated_user_protocol_id, federated_user.unique_id AS federated_user_unique_id, federated_user.display_name AS federated_user_display_name, anon_1.user_id AS anon_1_user_id FROM (SELECT user.id AS user_id FROM user WHERE user.id = '945fa0ad0137481cac5ef83a0b94b1b9') AS anon_1 INNER JOIN federated_user ON anon_1.user_id = federated_user.user_id ORDER BY anon_1.user_id;

SELECT local_user.id AS local_user_id, local_user.user_id AS local_user_user_id, local_user.domain_id AS local_user_domain_id, local_user.name AS local_user_name, anon_1.user_id AS anon_1_user_id FROM (SELECT user.id AS user_id FROM user INNER JOIN local_user ON user.id = local_user.user_id WHERE local_user.name = 'prime_helix.306sonic' AND local_user.domain_id = 'default') AS anon_1 INNER JOIN local_user ON anon_1.user_id = local_user.user_id ORDER BY anon_1.user_id;

SELECT password.id AS password_id, password.local_user_id AS password_local_user_id, password.password AS password_password, local_user_1.id AS local_user_1_id FROM (SELECT user.id AS user_id FROM user INNER JOIN local_user ON user.id = local_user.user_id WHERE local_user.name = 'prime_helix.306sonic' AND local_user.domain_id = 'default') AS anon_1 INNER JOIN local_user AS local_user_1 ON anon_1.user_id = local_user_1.user_id INNER JOIN password ON local_user_1.id = password.local_user_id ORDER BY local_user_1.id;

