From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v8 5/5] pwm: core: Set enable state properly on failed
 call to enable
Date: Fri, 12 Jun 2015 11:49:38 +0200
Message-ID: <20150612094937.GE19400@ulmo.nvidia.com>
References: <1432670900-27687-1-git-send-email-jonathar@broadcom.com>
 <1432670900-27687-6-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UfEAyuTBtIjiZzX6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432670900-27687-6-git-send-email-jonathar@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Richardson <jonathar@broadcom.com>
Cc: Tim Kryger <tim.kryger@gmail.com>, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Arun Ramamurthy <arun.ramamurthy@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--UfEAyuTBtIjiZzX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2015 at 01:08:20PM -0700, Jonathan Richardson wrote:
> The pwm_enable function didn't clear the enabled bit if a call to a
> clients enable function returned an error. The result was that the state
> of the pwm core was wrong. Clearing the bit when enable returns an error
> ensures the state is properly set.
>=20
> Tested-by: Jonathan Richardson <jonathar@broadcom.com>
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Jonathan Richardson <jonathar@broadcom.com>
> ---
>  drivers/pwm/core.c |   16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 224645f..18f5ac4 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -477,10 +477,20 @@ EXPORT_SYMBOL_GPL(pwm_set_polarity);
>   */
>  int pwm_enable(struct pwm_device *pwm)
>  {
> -	if (pwm && !test_and_set_bit(PWMF_ENABLED, &pwm->flags))
> -		return pwm->chip->ops->enable(pwm->chip, pwm);
> +	int err;
> +
> +	if (!pwm)
> +		return -EINVAL;
> +
> +	if (!test_and_set_bit(PWMF_ENABLED, &pwm->flags)) {
> +		err =3D pwm->chip->ops->enable(pwm->chip, pwm);
> +		if (err) {
> +			clear_bit(PWMF_ENABLED, &pwm->flags);
> +			return err;
> +		}
> +	}

I think with this new pattern we're now actually going to need a lock to
make sure pwm->flags doesn't change between the test_and_set_bit() and
clear_bit() calls.

Thierry

--UfEAyuTBtIjiZzX6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVeqsxAAoJEN0jrNd/PrOhWcAP/2DHId38wrj8ggjRHYbvLaP/
WMY5XnPK9Aka4NwjpStFeMYmKx7vZGrKAZlaeAQKMq4r+yRqp8PmnMs8WsPd8SgI
Ft3LJMYfFNjp7t/xpWg7unmJ4L8mjWmoY7fLP1nejzADC8YMNYHetmyWPQzYyy+H
q6mIOqIuCIaq7oXvBlO+pbdJAmj/Zi6YL6xS5bFcsmQGBdz/tTpQ6gx8dfRASwQN
syIFQrgadjqUyb2zjpf0SFIy1XDhLudgZSl4MXyS1JBS0k+H0I3jPfgbVTep3Cdt
4A5be+EKneO4dPnI7SeUxEIaaXSQC8CgvTqzYDJhA4uZUeHD5qGBtBX9qZpad72r
HvYJOjBUJUZj//H5jUWd6ILKeVLBqZFSx44qhq3mO8zalz/l8h7MZmKtpY/wRmUy
E3p4IerxyJ/ODDUqEKjYx2GU5nZEZDVuUuNg1dnmlpsNpixNzejwPldAOrYqMdJV
Z+1UrFhJZuFfz3MahhF19VQnOvPMzHDNJZbY7cEYK80yjuS+s07eriujJP8i1hPd
hrR14/dQnA5JTjjfn/M/wUeSBKigGI7uAkNi64yobSKQcShumm16a9cts3uNI3xd
/PpSq9T1ZvLhCyJsWIY1ifoKk3NvVb/BNOIT6i9e86jrFeUSAkCm/m6z3ObeTq5H
12wFfLpB/6u7mUpk5Yr1
=TTmE
-----END PGP SIGNATURE-----

--UfEAyuTBtIjiZzX6--
