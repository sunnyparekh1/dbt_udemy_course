{% macro no_empty_strings(model) %}
    {% for col in adapter.get_columns_in_relation(model) -%}
        {# {{ log('Name:\t' + col.name + '\t->\tType:\t' + col.data_type, info=True) }} #}
        {%- if col.is_string() -%}
            {{ col.name }} IS NOT NULL AND {{ col.name }} <> '' AND
        {% endif %}
    {%- endfor -%}
    TRUE
{%- endmacro %}
