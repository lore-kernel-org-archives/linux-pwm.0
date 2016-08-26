From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 1/2] pwm: sunxi: allow the pwm to finish its pulse before
 disable
Date: Sat, 27 Aug 2016 00:19:00 +0200
Message-ID: <20160826221900.GG3165@lukather>
References: <1472147411-30424-1-git-send-email-oliver@schinagl.nl>
 <1472147411-30424-2-git-send-email-oliver@schinagl.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UTZ8bGhNySVQ9LYl"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:55549 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754449AbcHZWTC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 26 Aug 2016 18:19:02 -0400
Content-Disposition: inline
In-Reply-To: <1472147411-30424-2-git-send-email-oliver@schinagl.nl>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Olliver Schinagl <oliver@schinagl.nl>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


--UTZ8bGhNySVQ9LYl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 25, 2016 at 07:50:10PM +0200, Olliver Schinagl wrote:
> When we inform the PWM block to stop toggeling the output, we may end up
> in a state where the output is not what we would expect (e.g. not the
> low-pulse) but whatever the output was at when the clock got disabled.
>=20
> To counter this we have to wait for maximally the time of one whole
> period to ensure the pwm hardware was able to finish. Since we already
> told the PWM hardware to disable it self, it will not continue toggling
> but merly finish its current pulse.
>=20
> If a whole period is considered to much, it may be contemplated to use a
> half period + a little bit to ensure we get passed the transition.
>=20
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> ---
>  drivers/pwm/pwm-sun4i.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 03a99a5..5e97c8a 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -8,6 +8,7 @@
> =20
>  #include <linux/bitops.h>
>  #include <linux/clk.h>
> +#include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> @@ -245,6 +246,16 @@ static void sun4i_pwm_disable(struct pwm_chip *chip,=
 struct pwm_device *pwm)
>  	spin_lock(&sun4i_pwm->ctrl_lock);
>  	val =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
>  	val &=3D ~BIT_CH(PWM_EN, pwm->hwpwm);
> +	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
> +	spin_unlock(&sun4i_pwm->ctrl_lock);
> +
> +	/* Allow for the PWM hardware to finish its last toggle. The pulse
> +	 * may have just started and thus we should wait a full period.
> +	 */
> +	ndelay(pwm_get_period(pwm));

Can't that use the ready bit as well?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--UTZ8bGhNySVQ9LYl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXwMBUAAoJEBx+YmzsjxAgJo0QAK+WlLGbijnErXYkNhazl8Q1
pxMb+2mbaEvVlRBKzlVJ9yvPmQm7EWF/ksUAZeo3EleAEiwM0Q9vCyKHfESGSQmk
bYVAk/7wSESSPg190lRw0SzSJ2q7z++hbtNmVuFgS+X96qOpW9JNkGZV/NrU3p0j
lDIjjZgJVh08WTy2BNcEqtKW4ZS73p5u1joRxqm39HN5eVZSyrt+m9IGi8/923S9
0A7qiOB5Ck08m9IztZzQTSZsECrOlxBJfhf2ET31umqzPUHKBjoRjV5ogo67g5oA
lNyuhNGPcdntgyrunQHV4dLQmWUNUZ613183FDLLI6cOBROVlXZxJHHbCgvlDBUL
df1ShRvCJnZba2IOOmK3aLcB9PyBoxAMlWoOdorAggsNmwBIEYtrLd7mfGjpw2l5
cN4zzNtlBmCaErHMf37l9LqiIWc0UPSK4XAKjP9ihO7iuPD0h1gB0he+48dudg05
xKliiRg4dvLTEsuG3cfXQNCzKoqVRg2XJJeWfXaU3c/WY6sO7amBrbSQzgNSdvBg
TMLhFzvQQf3tIlzPN2uZMFLZLtDRRmUztMjVNEK6b1+danU8yx9ElVMtSD4SJPkz
WG/W8cG7Qw2tmje7S74uXVjuntDV0bCMvsI7SEoBqzqIu1xxf+MFtWqicAso8YdZ
twVbpQN4i88ZIry0OdDw
=h0cr
-----END PGP SIGNATURE-----

--UTZ8bGhNySVQ9LYl--
