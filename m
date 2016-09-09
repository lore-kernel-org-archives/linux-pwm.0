From: Olliver Schinagl <oliver@schinagl.nl>
Subject: Re: [PATCH 1/2] pwm: sunxi: allow the pwm to finish its pulse
 before disable
Date: Fri, 09 Sep 2016 11:01:08 +0200
Message-ID: <1473411668.731.75.camel@schinagl.nl>
References: <1472147411-30424-1-git-send-email-oliver@schinagl.nl>
         <1472147411-30424-2-git-send-email-oliver@schinagl.nl>
         <20160826221900.GG3165@lukather> <1473145976.731.20.camel@schinagl.nl>
         <20160906195149.GJ9040@lukather>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-eBGLUNhvFhVVIrDLom3z"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from 7of9.schinagl.nl ([88.159.158.68]:52920 "EHLO 7of9.schinagl.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752795AbcIIJBR (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 9 Sep 2016 05:01:17 -0400
In-Reply-To: <20160906195149.GJ9040@lukather>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


--=-eBGLUNhvFhVVIrDLom3z
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On di, 2016-09-06 at 21:51 +0200, Maxime Ripard wrote:
> On Tue, Sep 06, 2016 at 09:12:56AM +0200, Olliver Schinagl wrote:
> >=20
> > Hi Maxime!,
> >=20
> > On za, 2016-08-27 at 00:19 +0200, Maxime Ripard wrote:
> > >=20
> > > On Thu, Aug 25, 2016 at 07:50:10PM +0200, Olliver Schinagl wrote:
> > > >=20
> > > >=20
> > > > When we inform the PWM block to stop toggeling the output, we
> > > > may
> > > > end up
> > > > in a state where the output is not what we would expect (e.g.
> > > > not
> > > > the
> > > > low-pulse) but whatever the output was at when the clock got
> > > > disabled.
> > > >=20
> > > > To counter this we have to wait for maximally the time of one
> > > > whole
> > > > period to ensure the pwm hardware was able to finish. Since we
> > > > already
> > > > told the PWM hardware to disable it self, it will not continue
> > > > toggling
> > > > but merly finish its current pulse.
> > > >=20
> > > > If a whole period is considered to much, it may be contemplated
> > > > to
> > > > use a
> > > > half period + a little bit to ensure we get passed the
> > > > transition.
> > > >=20
> > > > Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> > > > ---
> > > > =C2=A0drivers/pwm/pwm-sun4i.c | 11 +++++++++++
> > > > =C2=A01 file changed, 11 insertions(+)
> > > >=20
> > > > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > > > index 03a99a5..5e97c8a 100644
> > > > --- a/drivers/pwm/pwm-sun4i.c
> > > > +++ b/drivers/pwm/pwm-sun4i.c
> > > > @@ -8,6 +8,7 @@
> > > > =C2=A0
> > > > =C2=A0#include <linux/bitops.h>
> > > > =C2=A0#include <linux/clk.h>
> > > > +#include <linux/delay.h>
> > > > =C2=A0#include <linux/err.h>
> > > > =C2=A0#include <linux/io.h>
> > > > =C2=A0#include <linux/module.h>
> > > > @@ -245,6 +246,16 @@ static void sun4i_pwm_disable(struct
> > > > pwm_chip
> > > > *chip, struct pwm_device *pwm)
> > > > =C2=A0	spin_lock(&sun4i_pwm->ctrl_lock);
> > > > =C2=A0	val =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> > > > =C2=A0	val &=3D ~BIT_CH(PWM_EN, pwm->hwpwm);
> > > > +	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
> > > > +	spin_unlock(&sun4i_pwm->ctrl_lock);
> > > > +
> > > > +	/* Allow for the PWM hardware to finish its last
> > > > toggle.
> > > > The pulse
> > > > +	=C2=A0* may have just started and thus we should wait a
> > > > full
> > > > period.
> > > > +	=C2=A0*/
> > > > +	ndelay(pwm_get_period(pwm));
> > >=20
> > > Can't that use the ready bit as well?
> > It depends whatever is cheaper. If we disable the pwm, we have to
> > commit that request to hardware first. Then we have to read back
> > the
> > has ready and in the strange situation it is not, wait for it to
> > become
> > ready?
>=20
> If it works like you were suggesting, yes.
>=20
> >=20
> > Also, that would mean we would loop in a spin lock, or keep
> > setting/clearing an additional spinlock to read the ready bit.
>=20
> You're using a spin_lock, so it's not that bad, but I was just
> suggesting replacing the ndelay.
If you say the spin_lock + wait for the ready is just as expensive as
the ndelay, or the ndelay is less preferred, then I gladly make the
change; but I think we need the ndelay for the else where we do not
have the ready flag (A10 or A13 iirc?)

Olliver

>=20
> Maxime
>=20
--=-eBGLUNhvFhVVIrDLom3z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJX0npUAAoJEChwBZsDyQQMULwP/3VtRm1fjrhg6LKv/fguuJrF
S4r5thfTL5CNWYmgtE1XuhPT7w+/0pzItEd541RMFBrZQ8YCjQNDGP5/thzFKa3G
NIjhB1U00G7J1jMVjKQgnFw5cP9+c5tgK1eBTOYsVAtOLeqbblzA4jVQsty45pQB
bXgLpUbXuA9HXXvYwSvNBtEHH8InYFCsDeYvHdl/K6bNzStBjvMD0jCF3nezG/5X
pH/KFkHAkfPDZaD6rRRv+skToNz76392dJrmm+zlf3GWog1y92PCDJKCjLn+8BTN
327NVUjtVyqPKfZfI1IXLYJBWc+i9x7kgOWBVra0tP8FkijhOa/LenI0REpMcdZ+
ZVspI4YCKG+C2mhU0y9BpE1Ni6eJSyVIKi6k3BF64bG+TfktwuH2IT9HtK5jbduN
7s1siokOiF5fmFg6GYqpsCpXALyliYc47iE6H4az6ZRsC4dqMmS+A6eHjHLrYevr
mKRONjwSqMt0D90Uviy6u9A3vzJBcZhERUOUkmgbSOap0imFtqtt6SqrpVoSVWtr
dGr4fUYK5GnTandscRrAi5eRA49xiQU2Bc8hTaGKe6E335wDRF2uJQH5Jx4QdqfZ
tNQt/Hn1kKhMEVuUpd2MUGixmIJc/yIIYxDq4L1VOnQbyElsz9VWCIC3E13ipOvr
PacmmvzYnkGK/Ur3HdH3
=zWFk
-----END PGP SIGNATURE-----

--=-eBGLUNhvFhVVIrDLom3z--
