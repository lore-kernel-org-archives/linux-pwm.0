From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 08/15] backlight: pwm_bl: remove useless call to
 pwm_set_period
Date: Mon, 20 Jul 2015 10:36:50 +0200
Message-ID: <20150720083648.GK29614@ulmo>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-9-git-send-email-boris.brezillon@free-electrons.com>
 <20150720081559.GI29614@ulmo>
 <20150720102143.05949ca2@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Tv3+oRj6D9L8lW+H"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150720102143.05949ca2@bbrezillon>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Doug Anderson <dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org


--Tv3+oRj6D9L8lW+H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2015 at 10:21:43AM +0200, Boris Brezillon wrote:
> On Mon, 20 Jul 2015 10:16:00 +0200
> Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>=20
> > On Wed, Jul 01, 2015 at 10:21:54AM +0200, Boris Brezillon wrote:
> > > The PWM period will be set when calling pwm_config. Remove this usele=
ss
> > > call to pwm_set_period, which might mess up with the initial PWM state
> > > once we have added proper support for PWM init state retrieval.
> > >=20
> > > Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > > ---
> > >  drivers/video/backlight/pwm_bl.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > >=20
> > > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlig=
ht/pwm_bl.c
> > > index ae498c1..fe5597c 100644
> > > --- a/drivers/video/backlight/pwm_bl.c
> > > +++ b/drivers/video/backlight/pwm_bl.c
> > > @@ -295,10 +295,8 @@ static int pwm_backlight_probe(struct platform_d=
evice *pdev)
> > >  	 * via the PWM lookup table.
> > >  	 */
> > >  	pb->period =3D pwm_get_default_period(pb->pwm);
> > > -	if (!pb->period && (data->pwm_period_ns > 0)) {
> > > +	if (!pb->period && (data->pwm_period_ns > 0))
> > >  		pb->period =3D data->pwm_period_ns;
> > > -		pwm_set_period(pb->pwm, data->pwm_period_ns);
> > > -	}
> > > =20
> > >  	pb->lth_brightness =3D data->lth_brightness * (pb->period / pb->sca=
le);
> >=20
> > As far as I remember this line is there in order to pass in a period if
> > the backlight driver is initialized from board setup files. In such a
> > case there won't be an period associated with the PWM channel in the
> > first place.
> >=20
> > I think even with the introduction of a default period, we'd be missing
> > out on the board setup case because there is no standard place where it
> > is being set, so it must come from the platform data.
>=20
> AFAICT, we don't need to explicitly set the period when probing the
> backlight device, because it will be set next time we call
> pwm_config(), and since we're passing pb->period when calling
> pwm_config() everything should be fine.

Calling pwm_set_period() is still good for consistency. Consider for
example what happens if after the driver were to call pwm_get_period().
It would return some more or less random value (likely 0 or whatever it
had been set to by an earlier user).

Technically I think the most proper equivalent here would be to set the
default state's period to data->pwm_period_ns, but I don't think that's
proper to do. Perhaps since this is only relevant to boards where the
backlight device is created from board setup code we don't have to care
so much about messing up the initial state because either the board
setup code has been carefully written to match what the bootloader set
up, or because they don't match at all, in which case we don't have to
worry anyway.

Of course the right thing to do would be to replace all initialization
of the data->pwm_period_ns by proper PWM lookup tables, but that's
proven difficult in the past since very few people still have access to
hardware where that code gets executed.

Thierry

--Tv3+oRj6D9L8lW+H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVrLMeAAoJEN0jrNd/PrOh8zEQAIfPfWv1yN2B5jgdI5C06iWq
85TtAFzdLYG22PTy98n5Zx7d7J+l0vE5BLj6BScx1e/91p0FCP/6kh5EOkvcCgh/
MmxKmMmsZMjnJF3DWdXm0mjsK68dJm/pUsmOioCs4lMmPJyQU1rUruFvy5FI+Uuj
l2hP0xfomGXQiq+b6BYcZOrFUHC4U5U2tjCMYkrjsj3B+QxvtizVshNvPX5RGy+G
96ly+Mh/RM2KWD3keKLJaQWhz/wAd2cAjQFLBIj9x6Rh4s3ph1+5j8CBUVgAFfIc
rGD8rTKoFQ3L5AntwrpekAq24Y1ZiDLFmKRBPudAeSEZ2xl7y3v6l9hLJaBYJloj
tk0BEz58tXnUaSpslXV5CInKHKNr0U3jZRlTLbtcOhCoSksfw6ksTOM6Acl2Dq7T
Buq4RbeINyVgxgdwt2vQE+cLQvmlsJoEGBbUR1ZKkfqqAORIVJKOt63Gk912Tan/
aX8GbACOIciTc/0TYc1E8zkDjPYJIcmdo2aWX7/vKT0MQ9n9Bsj5/g6Du3uKhUjv
wyNLG+f2M1r0zI7SVU+QPTqhGdRgkKeonM3RYlyY06bsGlz8DTCT52pBuW2uDYbO
N3YPdioanSsWALjbors+afukvJccKeEb0RvZFQPOYS0qHBanNMZaA35SnQoK/z0C
7j/A1WMzImphnnUt+JRq
=97Q5
-----END PGP SIGNATURE-----

--Tv3+oRj6D9L8lW+H--
