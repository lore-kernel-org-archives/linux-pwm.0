From: Olliver Schinagl <oliver@schinagl.nl>
Subject: Re: [PATCH 1/2] pwm: sunxi: allow the pwm to finish its pulse
 before disable
Date: Tue, 06 Sep 2016 09:12:56 +0200
Message-ID: <1473145976.731.20.camel@schinagl.nl>
References: <1472147411-30424-1-git-send-email-oliver@schinagl.nl>
         <1472147411-30424-2-git-send-email-oliver@schinagl.nl>
         <20160826221900.GG3165@lukather>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-vZptlPcPtPUurBsJXM4v"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from 7of9.schinagl.nl ([88.159.158.68]:60636 "EHLO 7of9.schinagl.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751570AbcIFHNd (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 6 Sep 2016 03:13:33 -0400
In-Reply-To: <20160826221900.GG3165@lukather>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


--=-vZptlPcPtPUurBsJXM4v
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maxime!,

On za, 2016-08-27 at 00:19 +0200, Maxime Ripard wrote:
> On Thu, Aug 25, 2016 at 07:50:10PM +0200, Olliver Schinagl wrote:
> >=20
> > When we inform the PWM block to stop toggeling the output, we may
> > end up
> > in a state where the output is not what we would expect (e.g. not
> > the
> > low-pulse) but whatever the output was at when the clock got
> > disabled.
> >=20
> > To counter this we have to wait for maximally the time of one whole
> > period to ensure the pwm hardware was able to finish. Since we
> > already
> > told the PWM hardware to disable it self, it will not continue
> > toggling
> > but merly finish its current pulse.
> >=20
> > If a whole period is considered to much, it may be contemplated to
> > use a
> > half period + a little bit to ensure we get passed the transition.
> >=20
> > Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> > ---
> > =C2=A0drivers/pwm/pwm-sun4i.c | 11 +++++++++++
> > =C2=A01 file changed, 11 insertions(+)
> >=20
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index 03a99a5..5e97c8a 100644
> > --- a/drivers/pwm/pwm-sun4i.c
> > +++ b/drivers/pwm/pwm-sun4i.c
> > @@ -8,6 +8,7 @@
> > =C2=A0
> > =C2=A0#include <linux/bitops.h>
> > =C2=A0#include <linux/clk.h>
> > +#include <linux/delay.h>
> > =C2=A0#include <linux/err.h>
> > =C2=A0#include <linux/io.h>
> > =C2=A0#include <linux/module.h>
> > @@ -245,6 +246,16 @@ static void sun4i_pwm_disable(struct pwm_chip
> > *chip, struct pwm_device *pwm)
> > =C2=A0	spin_lock(&sun4i_pwm->ctrl_lock);
> > =C2=A0	val =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> > =C2=A0	val &=3D ~BIT_CH(PWM_EN, pwm->hwpwm);
> > +	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
> > +	spin_unlock(&sun4i_pwm->ctrl_lock);
> > +
> > +	/* Allow for the PWM hardware to finish its last toggle.
> > The pulse
> > +	=C2=A0* may have just started and thus we should wait a full
> > period.
> > +	=C2=A0*/
> > +	ndelay(pwm_get_period(pwm));
>=20
> Can't that use the ready bit as well?
It depends whatever is cheaper. If we disable the pwm, we have to
commit that request to hardware first. Then we have to read back the
has ready and in the strange situation it is not, wait for it to become
ready?

Also, that would mean we would loop in a spin lock, or keep
setting/clearing an additional spinlock to read the ready bit.

If that is cheaper then an ndelay, I can rewrite it of course, and
assuming the 'ready' bit gets set from disabeling the PWM. It needs to
be investigated if disabeling the PWM, the ready bit is used.q

>=20
> Maxime
>=20
--=-vZptlPcPtPUurBsJXM4v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXzmx4AAoJEChwBZsDyQQM/YcQAJaBlNUzH5+Ejm0YpO6FxBLH
nBcyyVhWpPgKQTw7dbbYupTPjwo1mTot58At/jwUx57yXbv0UwcOz+RCR2Sm+yMA
DEaa4tpnRdsIfPA2wUSlRfcOwek5KlH448fgIFpnGatFKGNe6XQLe0PBoyySc3V+
t/MI0JTMi5Gg/yyCqetgKS0QFU1nS20IEaovQSZgjYh5P91jHK1qZ2pnuZUiQT0D
lZ58PmL6mwtAGRfTSvcofJwiYkAxD2AMtHUf/wAiVt23wOxqy2oV7Hw58zJtTZEl
rR/9tp/HrUfKtPJKkFwIyr6XiqwLPaIY+x+64G0i9CrCLOMM6+QYOfjVYqqhh7/1
l+VNOrkv+sKP3IHTfyRjJ8CREy3Sdz9umsgnTmKzjBwMPruo8sq3BsVq/NJGrjHf
HZTv7HuaWkxDPisv2rD8ObFKF2lp3ck8hfX8AuLGKnE2lC1vlZMVlFejKIchJkSi
9eJubFiNSJTd3Hyulq8Uwmmdi+dB0vAfHRI+cCsoY+3ICKIbBeTSdzeyF6ozeuzT
KcdAKhR+dDA2vyibDu8FyfvzKO4S9ZlkDeB3OrWrWboMfiLNW+KfCBGoRagc8EXJ
Q7t9jmvWpTPhLQIFJ4nTvlMhkFlbhbxLN32H1BeFr7tvwvB0urlQAQ0bwxpSLUGw
+SULQ/swo8h88i8IXFje
=yUlG
-----END PGP SIGNATURE-----

--=-vZptlPcPtPUurBsJXM4v--
