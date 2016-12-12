From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 1/2] pwm: sunxi: allow the pwm to finish its pulse before
 disable
Date: Mon, 12 Dec 2016 13:24:27 +0100
Message-ID: <20161212122427.4ixo7terrlvnuqmd@lukather>
References: <1472147411-30424-1-git-send-email-oliver@schinagl.nl>
 <1472147411-30424-2-git-send-email-oliver@schinagl.nl>
 <20160826221900.GG3165@lukather>
 <afcb938d-d2df-4740-6c85-cdf2766f671c@schinagl.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3r6osu2yag7ymblo"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <afcb938d-d2df-4740-6c85-cdf2766f671c@schinagl.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Olliver Schinagl <oliver@schinagl.nl>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--3r6osu2yag7ymblo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 08, 2016 at 02:23:39PM +0100, Olliver Schinagl wrote:
> Hey Maxime,
>=20
> first off, also sorry for the slow delay :) (pun not intended)
>=20
> On 27-08-16 00:19, Maxime Ripard wrote:
> > On Thu, Aug 25, 2016 at 07:50:10PM +0200, Olliver Schinagl wrote:
> > > When we inform the PWM block to stop toggeling the output, we may end=
 up
> > > in a state where the output is not what we would expect (e.g. not the
> > > low-pulse) but whatever the output was at when the clock got disabled.
> > >=20
> > > To counter this we have to wait for maximally the time of one whole
> > > period to ensure the pwm hardware was able to finish. Since we already
> > > told the PWM hardware to disable it self, it will not continue toggli=
ng
> > > but merly finish its current pulse.
> > >=20
> > > If a whole period is considered to much, it may be contemplated to us=
e a
> > > half period + a little bit to ensure we get passed the transition.
> > >=20
> > > Signed-off-by: Olliver Schinagl<oliver@schinagl.nl>
> > > ---
> > >   drivers/pwm/pwm-sun4i.c | 11 +++++++++++
> > >   1 file changed, 11 insertions(+)
> > >=20
> > > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > > index 03a99a5..5e97c8a 100644
> > > --- a/drivers/pwm/pwm-sun4i.c
> > > +++ b/drivers/pwm/pwm-sun4i.c
> > > @@ -8,6 +8,7 @@
> > >   #include <linux/bitops.h>
> > >   #include <linux/clk.h>
> > > +#include <linux/delay.h>
> > >   #include <linux/err.h>
> > >   #include <linux/io.h>
> > >   #include <linux/module.h>
> > > @@ -245,6 +246,16 @@ static void sun4i_pwm_disable(struct pwm_chip *c=
hip, struct pwm_device *pwm)
> > >   	spin_lock(&sun4i_pwm->ctrl_lock);
> > >   	val =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> > >   	val &=3D ~BIT_CH(PWM_EN, pwm->hwpwm);
> > > +	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
> > > +	spin_unlock(&sun4i_pwm->ctrl_lock);
> > > +
> > > +	/* Allow for the PWM hardware to finish its last toggle. The pulse
> > > +	 * may have just started and thus we should wait a full period.
> > > +	 */
> > > +	ndelay(pwm_get_period(pwm));
> > Can't that use the ready bit as well?
>=20
> I started to implement our earlier discussed suggestions, but I do not th=
ink
> they will work. The read bit is not to let the user know it is ready with
> all of its commands, but only if the period registers are ready. I think =
it
> is some write lock while it copies the data into its internal control loo=
p.
> From the manual:
> PWM0 period register ready.
> 0: PWM0 period register is ready to write,
> 1: PWM0 period register is busy.
>=20
>=20
> So no, I don't think i can use the ready bit here at all. The only thing =
we
> can do here, but I doubt it's worth it, is to read the period register,
> caluclate a time from it, and then ndelay(pwm_get_period(pwm) - ran_time)
>=20
> The only 'win' then is that we could are potentially not waiting the full
> pwm period, but only a fraction of it. Since we are disabling the hardware
> (for power reasons) anyway, I don't think this is any significant win,
> except for extreme situations. E.g. we have a pwm period of 10 seconds, we
> disable it after 9.9 second, and now we have to wait for 10 seconds before
> the pwm_disable is finally done. So this could in that case be reduced to
> then only wait for 0.2 seconds since it is 'done' sooner.
>=20
> However that optimization is also not 'free'. We have to read the period
> register and calculate back the time. I suggest to do that when reworking
> this driver to work with atomic mode, and merge this patch 'as is' to
> atleast fix te bug where simply not finish properly.

That whole discussion made me realise something that is really
bad. AFAIK, pwm_get_period returns a 32 bits register, which means a
theorical period of 4s. Busy looping during 4 seconds is already very
bad, as you basically kill one CPU during that time, but doing so in a
(potentially) atomic context is even worse.

NACK.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--3r6osu2yag7ymblo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYTpb3AAoJEBx+YmzsjxAgcp0P/A5VQCqw4IG++RgSWsI4OIt0
4xCWCzEGOufs1+q8ZMSLE1VinCnpZRMMR0+9am/DzIrY1Jg+pKyzLHDlYUz3pbnN
PXQSwb3WCgR9fuFFtK27tyWsedhQc3IPavPOt7n0iq7aMIl9P4PmclLDGn0rRcqr
pNkZ88+Y5xH/EgkJhvicY1FBuODTNAwBYdC9o/sX7ViZtZguFS7NYBA8vSTdGAxl
1WUWEX2dTQNdKmPl3NT1GgtdiV4g9pEzIy7260E2kV+vNVzOKAId9HhevzIZa+5z
kjNjQ3Jpgep2RFk9NvonPXaft7pIB90DLFUrYOWs/C16QrTtw5BJIJRnd04n9jM3
3ChyVccuLrcYR5m3KY7pwmtQtZTLbWIXueCnrHx5LNUhnIq7RV3Ri2QR8oSs7LjF
YOxbYGUzbbF4OKZ2G+z9oqtH/sHBcShPkv9TZqV9j+ygcEeqSHth9ivTvh/9gfXm
umbLZxHV8nX6jog6zjs20RofoHDWni6kRY1IaTOx2t8zuQxZ7GLpOGJPcs4r+flr
c5TQfpIn3GdYaloDs7x3ScyJBRKToLO/4xh8tWhOBybS8DJezGynyL6H+1DmBRhD
GbJUcu8rhDA9AdWj6JDfePwnM987i6IbQoFWfSix6tGjQjpaNepDQJ5vdx5LkmDI
blIwdlZq4WaSYbb/rT28
=G1Qy
-----END PGP SIGNATURE-----

--3r6osu2yag7ymblo--
