From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] backlight: pwm_bl: Set pin to sleep state when powered
 down
Date: Fri, 21 Jun 2019 15:56:08 +0200
Message-ID: <20190621135608.GB11839@ulmo>
References: <20190522163428.7078-1-paul@crapouillou.net>
 <5b0f8bb3-e7b0-52c1-1f2f-9709992b76fc@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5b0f8bb3-e7b0-52c1-1f2f-9709992b76fc@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Paul Cercueil <paul@crapouillou.net>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, od@zcrc.me, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2019 at 01:41:45PM +0100, Daniel Thompson wrote:
> On 22/05/2019 17:34, Paul Cercueil wrote:
> > When the driver probes, the PWM pin is automatically configured to its
> > default state, which should be the "pwm" function.
>=20
> At which point in the probe... and by who?

The driver core will select the "default" state of a device right before
calling the driver's probe, see:

	drivers/base/pinctrl.c: pinctrl_bind_pins()

which is called from:

	drivers/base/dd.c: really_probe()

> > However, at this
> > point we don't know the actual level of the pin, which may be active or
> > inactive. As a result, if the driver probes without enabling the
> > backlight, the PWM pin might be active, and the backlight would be
> > lit way before being officially enabled.
> >=20
> > To work around this, if the probe function doesn't enable the backlight,
> > the pin is set to its sleep state instead of the default one, until the
> > backlight is enabled. Whenk the backlight is disabled, the pin is reset
> > to its sleep state.
> Doesn't this workaround result in a backlight flash between whatever enab=
les
> it and the new code turning it off again?

Yeah, I think it would. I guess if you're very careful on how you set up
the device tree you might be able to work around it. Besides the default
and idle standard pinctrl states, there's also the "init" state. The
core will select that instead of the default state if available. However
there's also pinctrl_init_done() which will try again to switch to the
default state after probe has finished and the driver didn't switch away
=66rom the init state.

So you could presumably set up the device tree such that you have three
states defined: "default" would be the one where the PWM pin is active,
"idle" would be used when backlight is off (PWM pin inactive) and then
another "init" state that would be the same as "idle" to be used during
probe. During probe the driver could then switch to the "idle" state so
that the pin shouldn't glitch.

I'm not sure this would actually work because I think the way that
pinctrl handles states both "init" and "idle" would be the same pointer
values and therefore pinctrl_init_done() would think the driver didn't
change away from the "init" state because it is the same pointer value
as the "idle" state that the driver selected. One way to work around
that would be to duplicate the "idle" state definition and associate one
instance of it with the "idle" state and the other with the "init"
state. At that point both states should be different (different pointer
values) and we'd get the init state selected automatically before probe,
select "idle" during probe and then the core will leave it alone. That's
of course ugly because we duplicate the pinctrl state in DT, but perhaps
it's the least ugly solution.

Adding Linus for visibility. Perhaps he can share some insight.

On that note, I'm wondering if perhaps it'd make sense for pinctrl to
support some mode where a device would start out in idle mode. That is,
where pinctrl_bind_pins() would select the "idle" mode as the default
before probe. With something like that we could easily support this
use-case without glitching.

I suppose yet another variant would be for the PWM backlight to not use
any of the standard pinctrl states at all. Instead it could just define
custom states, say "active" and "inactive". Looking at the code that
would prevent pinctrl_bind_pins() from doing anything with pinctrl
states and given the driver exact control over when each of the states
will be selected. That's somewhat suboptimal because we can't make use
of the pinctrl PM helpers and it'd require more boilerplate.

Thierry

> > Signed-off-by: Paul Cercueil <paul@crapouillou.net> > ---
> >   drivers/video/backlight/pwm_bl.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> >=20
> > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight=
/pwm_bl.c
> > index fb45f866b923..422f7903b382 100644
> > --- a/drivers/video/backlight/pwm_bl.c
> > +++ b/drivers/video/backlight/pwm_bl.c
> > @@ -16,6 +16,7 @@
> >   #include <linux/module.h>
> >   #include <linux/kernel.h>
> >   #include <linux/init.h>
> > +#include <linux/pinctrl/consumer.h>
> >   #include <linux/platform_device.h>
> >   #include <linux/fb.h>
> >   #include <linux/backlight.h>
> > @@ -50,6 +51,8 @@ static void pwm_backlight_power_on(struct pwm_bl_data=
 *pb)
> >   	struct pwm_state state;
> >   	int err;
> > +	pinctrl_pm_select_default_state(pb->dev);
> > +
> >   	pwm_get_state(pb->pwm, &state);
> >   	if (pb->enabled)
> >   		return;
> > @@ -90,6 +93,8 @@ static void pwm_backlight_power_off(struct pwm_bl_dat=
a *pb)
> >   	regulator_disable(pb->power_supply);
> >   	pb->enabled =3D false;
> > +
> > +	pinctrl_pm_select_sleep_state(pb->dev);
> >   }
> >   static int compute_duty_cycle(struct pwm_bl_data *pb, int brightness)
> > @@ -626,6 +631,10 @@ static int pwm_backlight_probe(struct platform_dev=
ice *pdev)
> >   	backlight_update_status(bl);
> >   	platform_set_drvdata(pdev, bl);
> > +
> > +	if (bl->props.power =3D=3D FB_BLANK_POWERDOWN)
> > +		pinctrl_pm_select_sleep_state(&pdev->dev);
>=20
> Didn't backlight_update_status(bl) already do this?
>=20
>=20
> Daniel.
>=20
>=20
> > +
> >   	return 0;
> >   err_alloc:
> >=20
>=20

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0M4fUACgkQ3SOs138+
s6HOkQ/+LbUhpnHIQP1vYEaPlj84ZxnKK1Y2dsbvsBPgry6U/vvqXTICQ/Z25op/
Q3PbxTQtU+XnulIhDNfGiwDm426bxBI7XGWfYuYqCjMgkWjlnozlNKCS+GUU4hno
asckWM11gkQ5BIFQDtzaeof6HPezKy7UJ/PT6TrQuAkJmKiNPfXdcLpJ4Qe7FsR4
TRRIDQBdulh20rsyxUNcbhQRAMX6y8rL8rZNAHkZpYQSyGTNxMd54pJDiNuhGpDY
zvti2jQdLMWn9+7AwaFeu2aZ/a88Xc3OYMoRozSBs9iRQKQE7Patba45fqVBRB2k
h3ZXRU0P27wmsi7MmlBsltv21jIFLKsDoNrfPmy76ON09iaTSVA67jQq2SovLZO2
MSyFKSARWe7jVEknURpy2R3MHnhsxy6lvqu5919RcwCjBQ1MkOW/C0ItZMMXlvEl
XV4XERYdNAEbneTkqbx5LdekXzrnq69Dkauaonac7yF++xKVb+3a+G71rbd5/2B/
19MYN6r3eSz/C8Q88oqnXJ/yloPrvdh5l8hMGMvWD/8dUVxbBW8NObCnotjLjNIm
WKGYcQuX5scJtrSopF30GClAeM+lr7pmj9v0PwOB1b0ftx1p/wNIsucLqhMk//fs
pnW9J9GG6wlsWFwKX34QDfbfWnWgCpwrDqS9ooXO5tsh8oJZdTA=
=x+jh
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--
