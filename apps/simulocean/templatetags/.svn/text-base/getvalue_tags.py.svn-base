from django import template

register = template.Library()

@register.simple_tag
def get_value(instance, field):
    return (instance.__class__._meta.fields[field]._get_val_from_obj(instance))
