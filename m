From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] backlight: pwm_bl: Set pin to sleep state when powered
 down
Date: Tue, 25 Jun 2019 11:47:56 +0200
Message-ID: <20190625094756.GC1516@ulmo>
References: <20190522163428.7078-1-paul@crapouillou.net>
 <5b0f8bb3-e7b0-52c1-1f2f-9709992b76fc@linaro.org>
 <20190621135608.GB11839@ulmo>
 <20190624112844.fmwbfpdxjkst3u7r@holly.lan>
 <1561386717.20436.0@crapouillou.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1561386717.20436.0@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, od@zcrc.me, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2019 at 04:31:57PM +0200, Paul Cercueil wrote:
>=20
>=20
> Le lun. 24 juin 2019 =C3=A0 13:28, Daniel Thompson <daniel.thompson@linar=
o.org> a
> =C3=A9crit :
> > On Fri, Jun 21, 2019 at 03:56:08PM +0200, Thierry Reding wrote:
> > >  On Fri, Jun 21, 2019 at 01:41:45PM +0100, Daniel Thompson wrote:
> > >  > On 22/05/2019 17:34, Paul Cercueil wrote:
> > >  > > When the driver probes, the PWM pin is automatically configured
> > > to its
> > >  > > default state, which should be the "pwm" function.
> > >  >
> > >  > At which point in the probe... and by who?
> > >=20
> > >  The driver core will select the "default" state of a device right
> > > before
> > >  calling the driver's probe, see:
> > >=20
> > >  	drivers/base/pinctrl.c: pinctrl_bind_pins()
> > >=20
> > >  which is called from:
> > >=20
> > >  	drivers/base/dd.c: really_probe()
> > >=20
> >=20
> > Thanks. I assumed it would be something like that... although given
> > pwm-backlight is essentially a wrapper driver round a PWM I wondered why
> > the pinctrl was on the backlight node (rather than the PWM node).
> >=20
> > Looking at the DTs in the upstream kernel it looks like ~20% of the
> > backlight drivers have pinctrl on the backlight node. Others presumable
> > have none or have it on the PWM node (and it looks like support for
> > sleeping the pins is *very* rare amoung the PWM drivers).
>=20
> If your PWM driver has more than one channel and has the pinctrl node, you
> cannot fine-tune the state of individual pins. They all share the same
> state.

But that's something that could be changed, right? We could for example
extend the PWM bindings to allow describing each PWM instance via a sub-
node of the controller node. Pin control states could be described on a
per-channel basis that way.

> > >  > > However, at this
> > >  > > point we don't know the actual level of the pin, which may be
> > > active or
> > >  > > inactive. As a result, if the driver probes without enabling the
> > >  > > backlight, the PWM pin might be active, and the backlight would
> > > be
> > >  > > lit way before being officially enabled.
> > >  > >
> > >  > > To work around this, if the probe function doesn't enable the
> > > backlight,
> > >  > > the pin is set to its sleep state instead of the default one,
> > > until the
> > >  > > backlight is enabled. Whenk the backlight is disabled, the pin
> > > is reset
> > >  > > to its sleep state.
> > >  > Doesn't this workaround result in a backlight flash between
> > > whatever enables
> > >  > it and the new code turning it off again?
> > >=20
> > >  Yeah, I think it would. I guess if you're very careful on how you
> > > set up
> > >  the device tree you might be able to work around it. Besides the
> > > default
> > >  and idle standard pinctrl states, there's also the "init" state. The
> > >  core will select that instead of the default state if available.
> > > However
> > >  there's also pinctrl_init_done() which will try again to switch to
> > > the
> > >  default state after probe has finished and the driver didn't switch
> > > away
> > >  from the init state.
> > >=20
> > >  So you could presumably set up the device tree such that you have
> > > three
> > >  states defined: "default" would be the one where the PWM pin is
> > > active,
> > >  "idle" would be used when backlight is off (PWM pin inactive) and
> > > then
> > >  another "init" state that would be the same as "idle" to be used
> > > during
> > >  probe. During probe the driver could then switch to the "idle"
> > > state so
> > >  that the pin shouldn't glitch.
> > >=20
> > >  I'm not sure this would actually work because I think the way that
> > >  pinctrl handles states both "init" and "idle" would be the same
> > > pointer
> > >  values and therefore pinctrl_init_done() would think the driver
> > > didn't
> > >  change away from the "init" state because it is the same pointer
> > > value
> > >  as the "idle" state that the driver selected. One way to work around
> > >  that would be to duplicate the "idle" state definition and
> > > associate one
> > >  instance of it with the "idle" state and the other with the "init"
> > >  state. At that point both states should be different (different
> > > pointer
> > >  values) and we'd get the init state selected automatically before
> > > probe,
> > >  select "idle" during probe and then the core will leave it alone.
> > > That's
> > >  of course ugly because we duplicate the pinctrl state in DT, but
> > > perhaps
> > >  it's the least ugly solution.
> > >  Adding Linus for visibility. Perhaps he can share some insight.
> >=20
> > To be honest I'm happy to summarize in my head as "if it flashes then
> > it's not
> > a pwm_bl.c's problem" ;-).
>=20
> It does not flash. But the backlight lits way too early, so we have a 1-2
> seconds
> of "white screen" before the panel driver starts.

I think this always goes both ways. If you set the sleep state for the
PWM on backlight probe with this patch, you may be able to work around
the problem of the backlight lighting up too early. But what if your
bootloader had already enabled the backlight and is showing a splash
screen during boot? Your patch would turn off the backlight and then it
would turn on again after everything else was initialized. That's one
type of flashing.

What we need in this case are explicit pin control states that will
enable fine-grained control over what happens. Anything implicit is
bound to fail because it bakes in an assumption (either that the
backlight is off during boot, or that it has been turned on already).

Ideally we'd need to detect that the backlight is on and if it is we
just don't do anything with it. Actually, I think that's what we want
even if the backlight is off. During probe the backlight state should
not be modified. You only want to modify it when you know that some
display driver is going to take over. If you can't seamlessly transition
to the kernel display driver, flashing may be okay. If your display
driver can take over seamlessly, then the backlight is likely already in
the desired state anyway.

Thierry

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0R7cwACgkQ3SOs138+
s6FL5Q/+LnIWzKdbonzgRFNIdGOvTzzhsl/UXibA/87usIpnjSEyvhDGTIPP/HAk
J0y5cyOws1pUhwyzmSbcz31MAsMUO4q9PjMFGRJHN0DbjEJSlFw8DgMV8Vii4jpk
xKiRTwch9VKjIe/iiT0kEk7C0ZlaKPu1fUoacN98UrskLNF4x3megjuvoZiGuiNu
URKLlTrYmHpcZUgGr6N+e1PHCHWnPGvWR5sk6FuQk7At//3gs1a40lOPSBDgxvwo
DuEHGi7SWZkgd1kVkPTxz4QiyHKt5Hw0ryw+BRyW2eqX2Od3LNJOFFHroR8vYKs4
7fo5hK4aoTDpNBbudd86dxo85XL7w+DMbz29u/punmSrxDFUKIDfOZqcyasFsm+r
JEoMPuZEjYr/6ssZpKebuInBiuBRyLY7PCCy7NU2lUb7/Ls79wYj1ZkURO3J2w5m
ioWNeDSqrgy6bEp699HPNaybR0ffxt4fqeP5cAhNUa1++Jc2b2C5UFcCgKuuks4t
fP/H+sjjvQHMI6m9wTdWrZzYHDNuHk414522/v6ybqqNf36seB5kStD3kGOBDsKo
MyLDMBuw5WXOmCaCSnjvZdOe3SFTY3n0yMl/JaxX5EWpCwxnZFSJpdKNantHdc2U
zvwFz5elaoCeu7P8HekTRV2e3xqeDeusk/OJrbPo5VJOaK+sIJs=
=B4rf
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--
