From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC PATCH 08/15] backlight: pwm_bl: remove useless call to
 pwm_set_period
Date: Mon, 20 Jul 2015 12:01:05 +0200
Message-ID: <20150720100104.GV29614@ulmo>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-9-git-send-email-boris.brezillon@free-electrons.com>
 <20150720081559.GI29614@ulmo>
 <20150720102143.05949ca2@bbrezillon>
 <20150720083648.GK29614@ulmo>
 <20150720105003.29b5813a@bbrezillon>
 <20150720091003.GN29614@ulmo>
 <20150720115704.0c64d070@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D2rVImvqWGvKULsk"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:36828 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245AbbGTKBT (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jul 2015 06:01:19 -0400
Content-Disposition: inline
In-Reply-To: <20150720115704.0c64d070@bbrezillon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Doug Anderson <dianders@google.com>


--D2rVImvqWGvKULsk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2015 at 11:57:04AM +0200, Boris Brezillon wrote:
> On Mon, 20 Jul 2015 11:10:04 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Mon, Jul 20, 2015 at 10:50:03AM +0200, Boris Brezillon wrote:
> > > On Mon, 20 Jul 2015 10:36:50 +0200
> > > Thierry Reding <thierry.reding@gmail.com> wrote:
> > >=20
> > > > On Mon, Jul 20, 2015 at 10:21:43AM +0200, Boris Brezillon wrote:
> > > > > On Mon, 20 Jul 2015 10:16:00 +0200
> > > > > Thierry Reding <thierry.reding@gmail.com> wrote:
> > > > >=20
> > > > > > On Wed, Jul 01, 2015 at 10:21:54AM +0200, Boris Brezillon wrote:
> > > > > > > The PWM period will be set when calling pwm_config. Remove th=
is useless
> > > > > > > call to pwm_set_period, which might mess up with the initial =
PWM state
> > > > > > > once we have added proper support for PWM init state retrieva=
l.
> > > > > > >=20
> > > > > > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electron=
s.com>
> > > > > > > ---
> > > > > > >  drivers/video/backlight/pwm_bl.c | 4 +---
> > > > > > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > > > > >=20
> > > > > > > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video=
/backlight/pwm_bl.c
> > > > > > > index ae498c1..fe5597c 100644
> > > > > > > --- a/drivers/video/backlight/pwm_bl.c
> > > > > > > +++ b/drivers/video/backlight/pwm_bl.c
> > > > > > > @@ -295,10 +295,8 @@ static int pwm_backlight_probe(struct pl=
atform_device *pdev)
> > > > > > >  	 * via the PWM lookup table.
> > > > > > >  	 */
> > > > > > >  	pb->period =3D pwm_get_default_period(pb->pwm);
> > > > > > > -	if (!pb->period && (data->pwm_period_ns > 0)) {
> > > > > > > +	if (!pb->period && (data->pwm_period_ns > 0))
> > > > > > >  		pb->period =3D data->pwm_period_ns;
> > > > > > > -		pwm_set_period(pb->pwm, data->pwm_period_ns);
> > > > > > > -	}
> > > > > > > =20
> > > > > > >  	pb->lth_brightness =3D data->lth_brightness * (pb->period /=
 pb->scale);
> > > > > >=20
> > > > > > As far as I remember this line is there in order to pass in a p=
eriod if
> > > > > > the backlight driver is initialized from board setup files. In =
such a
> > > > > > case there won't be an period associated with the PWM channel i=
n the
> > > > > > first place.
> > > > > >=20
> > > > > > I think even with the introduction of a default period, we'd be=
 missing
> > > > > > out on the board setup case because there is no standard place =
where it
> > > > > > is being set, so it must come from the platform data.
> > > > >=20
> > > > > AFAICT, we don't need to explicitly set the period when probing t=
he
> > > > > backlight device, because it will be set next time we call
> > > > > pwm_config(), and since we're passing pb->period when calling
> > > > > pwm_config() everything should be fine.
> > > >=20
> > > > Calling pwm_set_period() is still good for consistency. Consider for
> > > > example what happens if after the driver were to call pwm_get_perio=
d().
> > > > It would return some more or less random value (likely 0 or whateve=
r it
> > > > had been set to by an earlier user).
> > >=20
> > > Yes, that's true in general, but in this specific driver
> > > pwm_get_period() is never called, and the driver only relies on the
> > > pb->period value.
> >=20
> > Perhaps that's something that should change. If the PWM core has all
> > this infrastructure there should be no need for the backlight driver to
> > keep it's own copy of that variable.
>=20
> Yes, probably. In any case, I don't think we want PWM users to be able
> to mess up with the current or default PWM state, that's why I was
> planning on making the pwm_set_default_xxx helpers private to PWM
> drivers and core infrastructure.
>=20
> Also note that if we keep this assignment it should at least be changed
> to a pwm_set_default_period() so that it does not override the current
> PWM state.

I think we should be able to live without the assignment. Perhaps when
replacing it, add a comment saying that this is for very legacy cases
only and that PWM lookup tables are the right way to fix this.

Thierry

--D2rVImvqWGvKULsk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVrMbgAAoJEN0jrNd/PrOhjjAP/0gTVNmlxd/yjMQxjxIro6o8
li6sl878OgUFC4F0tXOxq+oBwIN8clXa9lvCr4xtuiSW0WMOGBLKFNXTjTyYMYUw
AM7e7RhJfHhNVur/5jk/C8y5xIEAQwa5/a8eh2hMJlmJvaNYBnpNzYx709LGKt03
1v1jAR0YyDTDTtbKlaPYSPmqnuPi+y64qYSMxcZEYRkrMGRLKiaCqjjfVaWq3ES3
jcnUQB6MW/aPcEuLt6v2hLNie6AipSdLrm8D4VIvVWX0Rj9ZTXPYznDQnOxwQc0w
TeiVheHQTye1baviSk+epx3Uyi/6ZbSlH1kkO7lzYGL2/VomaBwYeLOVx/ZITVR9
aOyfMSTcsnml8NNS6H+S7hZ20FAFO/sncRo3Xad+5c3n72jsoqyjMdwz2fHezqFY
Cs5ugfMfdAX50WiIHmSJ8GAbSQjAV9e7OfKY37c/Sveep+NPH9tegpsEu8MWTmfh
NpGapzwlBaY9C139pjrDlBwnXj2gI3qTpCRIf1zhYHgAb5j6n+4qku4N99HHUWd8
ODJtAdPK6ahqllGGgGHWbJkSAsNT0l/v08/rOYrclvnMMiGK15qPYNz/CH32VHsr
n/qWgDTT8RNoQJAbZkrJkZ2qihVyjloDuCzL0YjW3yEBM7CLI2GUyTxhPrSrzGsG
HtKcDulDxwQv3UdHG2rY
=4wcV
-----END PGP SIGNATURE-----

--D2rVImvqWGvKULsk--
