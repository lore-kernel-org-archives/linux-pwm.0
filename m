From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/1] pwm: samsung: avoid setting manual update bit
 unnecessarily
Date: Thu, 28 Nov 2013 14:26:41 +0100
Message-ID: <20131128132640.GA23201@ulmo.nvidia.com>
References: <1383108704-3297-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:61792 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042Ab3K1N11 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 28 Nov 2013 08:27:27 -0500
Content-Disposition: inline
In-Reply-To: <1383108704-3297-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, tomasz.figa@gmail.com, Andrew Bresticker <abrestic@chromium.org>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2013 at 10:21:44AM +0530, Sachin Kamat wrote:
> From: Andrew Bresticker <abrestic@chromium.org>
>=20
> When possible, avoid setting the manual update bit and starting/stopping
> the PWM when adjusting the PWM as it causes noticable flickering when
> setting the backlight brightness.
>=20
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/pwm/pwm-samsung.c |   23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)

There has been no comment on this, so can I assume this is fine with
everyone?

Thierry

> diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
> index b59639e..6d23eb3 100644
> --- a/drivers/pwm/pwm-samsung.c
> +++ b/drivers/pwm/pwm-samsung.c
> @@ -34,6 +34,7 @@
> =20
>  #define REG_TCNTB(chan)			(0x0c + ((chan) * 0xc))
>  #define REG_TCMPB(chan)			(0x10 + ((chan) * 0xc))
> +#define REG_TCNTO(chan)			(0x14 + ((chan) * 0xc))
> =20
>  #define TCFG0_PRESCALER_MASK		0xff
>  #define TCFG0_PRESCALER1_SHIFT		8
> @@ -234,15 +235,29 @@ static int pwm_samsung_enable(struct pwm_chip *chip=
, struct pwm_device *pwm)
>  	struct samsung_pwm_chip *our_chip =3D to_samsung_pwm_chip(chip);
>  	unsigned int tcon_chan =3D to_tcon_channel(pwm->hwpwm);
>  	unsigned long flags;
> -	u32 tcon;
> +	u32 tcon, tcnt, tcnt_o;
> =20
>  	spin_lock_irqsave(&samsung_pwm_lock, flags);
> =20
>  	tcon =3D readl(our_chip->base + REG_TCON);
> +	tcnt =3D readl(our_chip->base + REG_TCNTB(pwm->hwpwm));
> +	tcnt_o =3D readl(our_chip->base + REG_TCNTO(pwm->hwpwm));
> =20
> -	tcon &=3D ~TCON_START(tcon_chan);
> -	tcon |=3D TCON_MANUALUPDATE(tcon_chan);
> -	writel(tcon, our_chip->base + REG_TCON);
> +	/*
> +	 * If we've got a big value stuck in the PWM we need to adjust it using
> +	 * manualupdate.  The start bit needs to be off for that to work
> +	 * properly so we only do this if strictly necessary since it can cause
> +	 * the PWM to blink.
> +	 *
> +	 * We will also use manualupdate if we find that the autoreload bit
> +	 * wasn't set previously since the very first time the timer is
> +	 * configured we seem to need to kickstart the PWM.
> +	 */
> +	if ((tcnt_o > tcnt) || !(tcon & TCON_AUTORELOAD(tcon_chan))) {
> +		tcon &=3D ~TCON_START(tcon_chan);
> +		tcon |=3D TCON_MANUALUPDATE(tcon_chan);
> +		writel(tcon, our_chip->base + REG_TCON);
> +	}
> =20
>  	tcon &=3D ~TCON_MANUALUPDATE(tcon_chan);
>  	tcon |=3D TCON_START(tcon_chan) | TCON_AUTORELOAD(tcon_chan);
> --=20
> 1.7.9.5
>=20

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSl0SQAAoJEN0jrNd/PrOhk8kQALpe3+n91B1+4oPF1k0NeDNw
R86OrS7KyjZhWoZlkvUuNiRUlZKv9nTAHRCDO6rAMTsr1g/QjhHY71nSq0JayOgZ
tx5k54nl8o7vxzPfxVDXuyf0sbiUqF82cxG/0LJJ/rKgUoavkod4ToOgmPBlwlUE
x4G6iezGLxEnYmFTbHkQK32/+3J8dH3z09cnLyW6tt+7CaD6aOA6537+yoavFsy0
qGWShb6AYSVB3ZTJy1rNpLnsEE57fvalosclcNt2YIXVyZKmQ8cwPwOt31jJ89EG
0Ff2l8l1HHc3yhWC2J36PZcQ8p4QxqkoYgtn/Jjco/kbZsCht0DvQ31i52QwX0xB
zjfnjN4afV8jWeq5ITmD3nDhjf5Q8khlc9M+jxP9c0zaFtogrzMtFLCVR/DjvXMd
AsiQwnLSXYqtIXgxtNfw4VAxph2wI2eOkpZhpkFN7S3MyqT9jOBF7iApZNrbFURj
TbNhuTPpmMJd9vh1gC86/Jtdoao2TAt15h9/a2IW2u6sZkmtPXr+/kchj1TKcLVA
VNia8L0esmHjU+DEqVj1FC3nLDl/5pOizrNxvhNUoRDBhSDx7JSSAXrhnQni2wgq
zy+tUcWtX3zzXVAylTnhJzP0A9uY81g54NxuBVlmLtqs1/qzfn5SlljHDg6dsuY0
GHsnvMIjposTj7eI99a4
=Efw7
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
