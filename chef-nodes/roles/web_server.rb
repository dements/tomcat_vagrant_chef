name 'web_server'
description "A role for configuring web servers"
run_list 'recipe[web]'
#env_run_lists "testing" => ["recipe[web::config_test]"]'
