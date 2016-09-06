From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 1/2] pwm: sunxi: allow the pwm to finish its pulse before
 disable
Date: Tue, 6 Sep 2016 21:51:49 +0200
Message-ID: <20160906195149.GJ9040@lukather>
References: <1472147411-30424-1-git-send-email-oliver@schinagl.nl>
 <1472147411-30424-2-git-send-email-oliver@schinagl.nl>
 <20160826221900.GG3165@lukather>
 <1473145976.731.20.camel@schinagl.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="j+MD90OnwjQyWNYt"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1473145976.731.20.camel@schinagl.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Olliver Schinagl <oliver@schinagl.nl>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--j+MD90OnwjQyWNYt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 06, 2016 at 09:12:56AM +0200, Olliver Schinagl wrote:
> Hi Maxime!,
>=20
> On za, 2016-08-27 at 00:19 +0200, Maxime Ripard wrote:
> > On Thu, Aug 25, 2016 at 07:50:10PM +0200, Olliver Schinagl wrote:
> > >=20
> > > When we inform the PWM block to stop toggeling the output, we may
> > > end up
> > > in a state where the output is not what we would expect (e.g. not
> > > the
> > > low-pulse) but whatever the output was at when the clock got
> > > disabled.
> > >=20
> > > To counter this we have to wait for maximally the time of one whole
> > > period to ensure the pwm hardware was able to finish. Since we
> > > already
> > > told the PWM hardware to disable it self, it will not continue
> > > toggling
> > > but merly finish its current pulse.
> > >=20
> > > If a whole period is considered to much, it may be contemplated to
> > > use a
> > > half period + a little bit to ensure we get passed the transition.
> > >=20
> > > Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> > > ---
> > > =A0drivers/pwm/pwm-sun4i.c | 11 +++++++++++
> > > =A01 file changed, 11 insertions(+)
> > >=20
> > > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > > index 03a99a5..5e97c8a 100644
> > > --- a/drivers/pwm/pwm-sun4i.c
> > > +++ b/drivers/pwm/pwm-sun4i.c
> > > @@ -8,6 +8,7 @@
> > > =A0
> > > =A0#include <linux/bitops.h>
> > > =A0#include <linux/clk.h>
> > > +#include <linux/delay.h>
> > > =A0#include <linux/err.h>
> > > =A0#include <linux/io.h>
> > > =A0#include <linux/module.h>
> > > @@ -245,6 +246,16 @@ static void sun4i_pwm_disable(struct pwm_chip
> > > *chip, struct pwm_device *pwm)
> > > =A0	spin_lock(&sun4i_pwm->ctrl_lock);
> > > =A0	val =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> > > =A0	val &=3D ~BIT_CH(PWM_EN, pwm->hwpwm);
> > > +	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
> > > +	spin_unlock(&sun4i_pwm->ctrl_lock);
> > > +
> > > +	/* Allow for the PWM hardware to finish its last toggle.
> > > The pulse
> > > +	=A0* may have just started and thus we should wait a full
> > > period.
> > > +	=A0*/
> > > +	ndelay(pwm_get_period(pwm));
> >=20
> > Can't that use the ready bit as well?
> It depends whatever is cheaper. If we disable the pwm, we have to
> commit that request to hardware first. Then we have to read back the
> has ready and in the strange situation it is not, wait for it to become
> ready?

If it works like you were suggesting, yes.

> Also, that would mean we would loop in a spin lock, or keep
> setting/clearing an additional spinlock to read the ready bit.

You're using a spin_lock, so it's not that bad, but I was just
suggesting replacing the ndelay.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--j+MD90OnwjQyWNYt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXzx5VAAoJEBx+YmzsjxAgdtUP/0/UHtGcf/urEmamxPKkehfP
hDyUJ4qQK6S2UMngiWcGXoB3EsJaWPrMgOlmeTqTQoW+oztLEgM8eARcMZOqxy+3
S173FhVz8qUoQn0o4rCT/3kM6gHu4+DXNsYYuC2v3XM7eN8smLnyIK7VvnmcMKw5
pwJONRqyxr7PrjL4BGnaqIDqIPJO3eOXexTLBkFYuq7J40XD6SMpomiks6o4o+1g
nD1I4EzICvgr+Yx2kEDJA2gRGWRJaiucnVY1Lf0TyPLFxV+MbU27zXSOaqpVIn67
SJ+QxsR+WBKb6pOR2jTCzoKm/1dSXFoaTGEUu2uwCqLjMoY2jQVzySdRq9Lxieic
WDwNBFF6y1/3iDEtA5LMQG+U0CyssJfjj55sqAdGlk3WdEWY7TAYTGRbFM9RvmeL
kJmS97Of8w5Y3lBX7vFv/R9P2Hrklkq6Ln6/hPsGSIeI+jgX/lA+sOEcUjgZ0IWD
FThCqmP/5iolWfVVwNagGa/Xrs7is0r7FxX7pWvwbknArs9vr+U6UPLc/Yd/F2F4
fGnEcbV8sYcPaZ7Xgiel7PVDchMt/R7uaj1+bZth7PRZbEm2Jj3yZyvggKYDoaN2
7M3jUYEWkTrmaM7vx7ua2vVNr4iJr8lF5X+hgaqOruk4kgZr1aqLiH/OvGTOHxZU
3BOStbQiHlw8ETQaPikX
=oIKq
-----END PGP SIGNATURE-----

--j+MD90OnwjQyWNYt--
