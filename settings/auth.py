from django.contrib.auth.models import User
from openid.consumer.consumer import SUCCESS
#from django.core.mail import mail_admins
from email.utils import parseaddr

class GoogleBackend:
    def authenticate(self, openid_response):
        if openid_response is None:
            return None
        if openid_response.status != SUCCESS:
            return None

        google_email = openid_response.getSigned('http://openid.net/srv/ax/1.0',  'value.email')
        # google_firstname = openid_response.getSigned('http://openid.net/srv/ax/1.0', 'value.firstname')
        # google_lastname = openid_response.getSigned('http://openid.net/srv/ax/1.0', 'value.lastname')
        try:
            #user = User.objects.get(username=google_email)
            # Make sure that the e-mail is unique.
            user = User.objects.get(email=google_email)
        except User.DoesNotExist:
            username = google_email.split('@')[0]
            user = User.objects.create_user(username, google_email, 'password')
            # user.first_name = google_firstname
            # user.last_name = google_lastname
            user.save()
            user = User.objects.get(username=username)
            return user

        return user

    def get_user(self, user_id):

        try:
            return User.objects.get(pk=user_id)
        except User.DoesNotExist:
            return None