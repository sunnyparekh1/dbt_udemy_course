{% macro learn_variables() %}

    {% set your_name_jinja = "Sunny" %}
    {{ log("Hello Jinja User: " ~ your_name_jinja, info=True) }}
    {# {{ log("Hello DBT User: " ~ var('your_name_dbt', 'No User Provided') ~ "!", info=True) }} #Option1 of default variable values #}
    {{ log("Hello DBT User: " ~ var('your_name_dbt') ~ "!", info=True) }}

{% endmacro %}
