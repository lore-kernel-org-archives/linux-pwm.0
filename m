From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/4] pwm: pca9685: remove unused duty_cycle struct element
Date: Wed, 1 Apr 2020 19:45:40 +0200
Message-ID: <20200401174540.GA2978178@ulmo>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200330130743.GB2431644@ulmo>
 <CAHp75Vc_=czuRtyqgnmnYfie50gDnzrNqq3Bt+Gp_42MikX6VA@mail.gmail.com>
 <20200330160238.GD2817345@ulmo>
 <20200401163640.GA91358@workstation.tuxnet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200401163640.GA91358@workstation.tuxnet>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sven Van Asbroeck <TheSven73@gmail.com>
List-Id: linux-pwm@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2020 at 06:36:40PM +0200, Clemens Gruber wrote:
> On Mon, Mar 30, 2020 at 06:02:38PM +0200, Thierry Reding wrote:
> > On Mon, Mar 30, 2020 at 04:18:22PM +0300, Andy Shevchenko wrote:
> > > On Mon, Mar 30, 2020 at 4:09 PM Thierry Reding <thierry.reding@gmail.=
com> wrote:
> > > >
> > > > On Wed, Feb 26, 2020 at 02:52:26PM +0100, Matthias Schiffer wrote:
> > > > > duty_cycle was only set, never read.
> > > > >
> > > > > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.c=
om>
> > > > > ---
> > > > >  drivers/pwm/pwm-pca9685.c | 4 ----
> > > > >  1 file changed, 4 deletions(-)
> > > >
> > > > Applied, thanks.
> > >=20
> > > I'm not sure this patch is correct.
> >=20
> > What makes you say that? If you look at the code, the driver sets this
> > field to either 0 or some duty cycle value but ends up never using it.
> > Why would it be wrong to remove that code?
> >=20
> > > We already have broken GPIO in this driver. Do we need more breakage?
> >=20
> > My understanding is that nobody was able to pinpoint exactly when this
> > regressed, or if this only worked by accident to begin with. It sounds
> > like Clemens has a way of testing this driver, so perhaps we can solve
> > that GPIO issue while we're at it.
> >=20
> > The last discussion on this seems to have been around the time when you
> > posted a fix for it:
> >=20
> >     https://patchwork.ozlabs.org/patch/1156012/
> >=20
> > But then Sven had concerns that that also wasn't guaranteed to work:
> >=20
> >     https://lkml.org/lkml/2019/6/2/73
> >=20
> > So I think we could either apply your patch to restore the old behaviour
> > which I assume you tested, so at least it seems to work in practice,
> > even if there's still a potential race that Sven pointed out in the
> > above link.
> >=20
> > I'd prefer something alternative because it's obviously confusing and
> > completely undocumented. Mika had already proposed something that's a
> > little bit better, though still somewhat confusing.
> >=20
> > Oh... actually reading further through those threads there seems to be a
> > patch from Sven that was reviewed by Mika but then nothing happened:
> >=20
> > 	https://lkml.org/lkml/2019/6/4/1039
> >=20
> > with the corresponding patchwork URL:
> >=20
> > 	https://patchwork.ozlabs.org/patch/1110083/
> >=20
> > Andy, Clemens, do you have a way of testing the GPIO functionality of
> > this driver? If so, it'd be great if you could check the above patch
> > from Sven to fix PWM/GPIO interop.
>=20
> Looks good. Tested it today and I can no longer reproduce the issues
> when switching between PWM and GPIO modes.
> It did not apply cleanly on the current mainline or for-next branch, so
> I'll send a fixed up version of the patch with my Tested-by tag shortly.

Awesome, thank you!

> I noticed an unrelated issue when disabling and enabling the channel
> though, for which I will either send a patch or maybe try to convert the
> driver to the atomic API first and then look if it is still a problem.
> (Issue is that if you disable the channel, the LED_OFF counter is
> cleared, which means you have to reconfigure the duty cycle after
> reenabling. It's probably better if only the FULL_OFF bit is toggled in
> enable/disable as it has precedence over the others anyway and then the
> previous state would not be changed..?)

Converting to the atomic API would certainly be beneficial because it
gives you much more control over what you want to program to hardware.

Other than that, yes, if ->enable() called after ->disable() doesn't put
the PWM into the same state that it was before ->disable(), then that'd
be a bug. From what you're saying this will make the driver only work if
there's a ->config() call after ->disable(). That's wrong.

So yes, setting only that LED_FULL bit in ->disable() and clearing it in
->enable() sounds like a better option than the current implementation.

Thierry

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6E00EACgkQ3SOs138+
s6FPzQ/9Ev2jfZ6TUgRlYiSbq5Ko3pB8kpHoJMG5Q2cAZVA9cLusVZNpuNvj5Vtt
yAWbXGmWtJLPV5/e4S0fvUMAQG9zVkK42NJ5OzN8SeFPY98ILUmkka3b+eGFuspU
g0HksnC1Gi30UtrtHvx/Vy9WYrMnOJZbUwScaBZvNQI2/6HfXgcgsiaOvBuR67mw
pyMHk2Zj5wTBLSn6ufqOBN+hETAx/mV+Ned6YALaMGja0FgnGE4hl3ewJdkSWfeT
Fjik/c1+3UPkBMlZxC54t4V6/h8JUz283m8c8lHs2I5T59YM11enA0j6i+LS2kJa
YwjUd7Va0Bbr7h+4RMMOYSQY66Xa1n60xJqcxXmd3+QVE4/SpD6PwvSBzghhV+GZ
lxovaH+tjopt7Hmn8ZmQWB9Wa58H5ZiMpJwn2NdwSp6eVPganKf15Tn+NMyGJBA7
B8JDyI0iMhE3c1S7JNHSx7uyP2Z1YM+MG1dhJ768Ep/4Mbt7C7G8nmYVRgdoJOxb
HNzCXJ3dvHPFRauNXFzMvoFNcfwVylJeGTb9pYsbyiQz7ksQJ6ZKrycyRV9wjVEH
vV9jUJD0MW8441zrvh1rl5fSDrjneVGpzsFu+009cGU6iSX6CndDE5wU8a6xziTK
0wxVABuONYe26+GlRgUZF3mUjnv1rQR1ohNZPSbXeBQySmgixBU=
=b+5S
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
