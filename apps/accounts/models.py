from django.contrib.auth.models import User
from django.core.urlresolvers import reverse
from django.db import models
from django.shortcuts import redirect
from apps.teakwood.models import CommonInfo

# JQuery Themes http://jqueryui.com/themeroller/
THEMEROLLER = [
    ("base", "Base"),
    ("black-tie", "Black Tie"),
    ("blitzer", "Blitzer"),
    ("cupertino", "Cupertino"),
    ("dark-hive", "Dark Hive"),
    ("dot-luv", "Dot Luv"),
    ("eggplant", "Eggplant"),
    ("excite-bike", "Excite Bike"),
    ("flick", "Flick"),
    ("hot-sneaks", "Hot sneaks"),
    ("humanity", "Humanity"),
    ("le-frog", "Le Frog"),
    ("mint-choc", "Mint Choc"),
    ("overcast", "Overcast"),
    ("pepper-grinder", "Pepper Grinder"),
    ("redmond", "Redmond"),
    ("smoothness", "Smoothness"),
    ("south-street", "South Street"),
    ("start", "Start"),
    ("sunny", "Sunny"),
    ("swanky-purse", "Swanky Purse"),
    ("trontastic", "Trontastic"),
    ("ui-darkness", "UI Darkness"),
    ("ui-lightness", "UI Lightness"),
    ("vader", "Vader"),
]


class UserProfile(models.Model):
    user = models.ForeignKey(User, unique=True)
    first_name = models.CharField(max_length=32, null=True, blank=True)
    last_name = models.CharField(max_length=32, null=True, blank=True)
    affiliation = models.CharField(max_length=256, null=True, blank=True)
    description = models.TextField(null=True, blank=True)
    theme = models.CharField("Teakwood theme", max_length=32,
                             default='smoothness',
                             choices=THEMEROLLER, null=True, blank=True)
    public_profile = models.BooleanField("Visible to others", default=True)
    show_hints = models.BooleanField("Show hint button", default=False)

    def get_absolute_url(self):
        return redirect(reverse("profiles_profile_detail", args=[self.user.username]))

    # get_absolute_url = models.permalink(get_absolute_url)
    def get_fields(self):
        return [(field.verbose_name, field._get_val_from_obj(self))
                for field in self.__class__._meta.fields]

    def __unicode__(self):
        return self.user.username

User.profile = property(lambda u: UserProfile.objects.get_or_create(user=u)[0])