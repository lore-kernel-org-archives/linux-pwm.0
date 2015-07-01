From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [RFC PATCH 14/15] regulator: pwm: implement ->enable(),
 ->disable() and ->is_enabled methods
Date: Wed, 1 Jul 2015 14:19:12 +0200
Message-ID: <20150701141912.52f995a5@bbrezillon>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
	<3495901.qMzLCVWCDl@diego>
	<20150701140531.2041b05c@bbrezillon>
	<3530235.H11CYEfk28@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3530235.H11CYEfk28@diego>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Doug Anderson <dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Wed, 01 Jul 2015 14:08:18 +0200
Heiko St=C3=BCbner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org> wrote:

> Am Mittwoch, 1. Juli 2015, 14:05:31 schrieb Boris Brezillon:
> > Hi Heiko,
> >=20
> > On Wed, 01 Jul 2015 13:58:09 +0200
> >=20
> > Heiko St=C3=BCbner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org> wrote:
> > > Am Mittwoch, 1. Juli 2015, 10:22:00 schrieb Boris Brezillon:
> > > > Implement the ->enable(), ->disable() and ->is_enabled methods =
and
> > > > remove
> > > > the PWM call in ->set_voltage_sel().
> > > > This is particularly important for critical regulators tagged a=
s
> > > > always-on,
> > > > because not claiming the PWM (and its dependencies) might lead =
to
> > > > unpredictable behavior (like a system hang because the PWM clk =
is only
> > > > claimed when the PWM device is enabled).
> > > >=20
> > > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.=
com>
> > > > ---
> > > >=20
> > > >  drivers/regulator/pwm-regulator.c | 32 +++++++++++++++++++++++=
+++------
> > > >  1 file changed, 26 insertions(+), 6 deletions(-)
> > > >=20
> > > > diff --git a/drivers/regulator/pwm-regulator.c
> > > > b/drivers/regulator/pwm-regulator.c index 12b4d9d..8159518 1006=
44
> > > > --- a/drivers/regulator/pwm-regulator.c
> > > > +++ b/drivers/regulator/pwm-regulator.c
> > > > @@ -59,12 +59,6 @@ static int pwm_regulator_set_voltage_sel(str=
uct
> > > > regulator_dev *rdev,
> > > >=20
> > > >  	drvdata->state =3D selector;
> > > >=20
> > > > -	ret =3D pwm_enable(drvdata->pwm);
> > > > -	if (ret) {
> > > > -		dev_err(&rdev->dev, "Failed to enable PWM\n");
> > > > -		return ret;
> > > > -	}
> > > > -
> > > >=20
> > > >  	return 0;
> > > > =20
> > > >  }
> > > >=20
> > > > @@ -79,11 +73,37 @@ static int pwm_regulator_list_voltage(struc=
t
> > > > regulator_dev *rdev, return drvdata->duty_cycle_table[selector]=
=2EuV;
> > > >=20
> > > >  }
> > > >=20
> > > > +static int pwm_regulator_enable(struct regulator_dev *dev)
> > > > +{
> > > > +	struct pwm_regulator_data *drvdata =3D rdev_get_drvdata(dev);
> > > > +
> > > > +	return pwm_enable(drvdata->pwm);
> > > > +}
> > > > +
> > > > +static int pwm_regulator_disable(struct regulator_dev *dev)
> > > > +{
> > > > +	struct pwm_regulator_data *drvdata =3D rdev_get_drvdata(dev);
> > > > +
> > > > +	pwm_disable(drvdata->pwm);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int pwm_regulator_is_enabled(struct regulator_dev *dev)
> > > > +{
> > > > +       struct pwm_regulator_data *drvdata =3D rdev_get_drvdata=
(dev);
> > > > +
> > > > +       return pwm_is_enabled(drvdata->pwm);
> > > > +}
> > >=20
> > > nit: indentation is wrong in pwm_regulator_is_enabled (spaces ins=
tead of
> > > tabs)
> > Yep, I noticed checkpatch warnings/errors before sending the patch,=
 but
> > since this is just an RFC I decided to fix them for the next versio=
n ;-)
>=20
> ok, so I'll just skip over any more style issues for now. Making my w=
ay=20
> through your series and trying it on my veyron right now :-)

Also note that I haven't tested the series on a real board (just compil=
e
tested) because I don't have the board with me right now, but I wanted
to post the RFC early so that we can discuss the concepts.

Anyway, any feedback on the implementation (including bug reports) is
welcome.

This is the version I actually tested on the veyron board:

https://github.com/bbrezillon/linux-rk/tree/rk-3.14

Best Regards,

Boris

--=20
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
