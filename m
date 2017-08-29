From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm_bl: Fix overflow condition
Date: Tue, 29 Aug 2017 16:05:34 +0200
Message-ID: <20170829140534.GA18114@ulmo>
References: <20170828200033.40673-1-dbasehore@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35074 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753298AbdH2OFi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 29 Aug 2017 10:05:38 -0400
Content-Disposition: inline
In-Reply-To: <20170828200033.40673-1-dbasehore@chromium.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Derek Basehore <dbasehore@chromium.org>
Cc: linux-kernel@vger.kernel.org, jingoohan1@gmail.com, lee.jones@linaro.org, linux-pwm@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2017 at 01:00:33PM -0700, Derek Basehore wrote:
> This fixes and overflow condition that happens with a high value of
> brightness-levels-scale by using a 64-bit variable. The issue would
> prevent a range of higher brightness levels from being set.
>=20
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---
>  drivers/video/backlight/pwm_bl.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/p=
wm_bl.c
> index 76311ec5e400..e7ffd2108acf 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -88,14 +88,17 @@ static void pwm_backlight_power_off(struct pwm_bl_dat=
a *pb)
>  static int compute_duty_cycle(struct pwm_bl_data *pb, int brightness)
>  {
>  	unsigned int lth =3D pb->lth_brightness;
> -	int duty_cycle;
> +	s64 duty_cycle;
> =20
>  	if (pb->levels)
>  		duty_cycle =3D pb->levels[brightness];
>  	else
>  		duty_cycle =3D brightness;
> =20
> -	return (duty_cycle * (pb->period - lth) / pb->scale) + lth;
> +	duty_cycle *=3D pb->period - lth;
> +	do_div(duty_cycle, pb->scale);
> +
> +	return duty_cycle + lth;
>  }

I don't think your commit message accurately describes the change here.
The overflow that you're preventing might happen with a large value of
pb->period (or rather, in combination with a large value of duty_cycle)
but it's unrelated to pb->scale.

Also, the semantics of do_div() are that it takes an unsigned dividend,
so your duty_cycle should be a u64.

Thierry

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmldKwACgkQ3SOs138+
s6FJKxAAo7NplDavupIfsUfaxYPkTpZDm0Ra9hJZv6+Op65bBfQnuaj8k/QQ98z5
R0s0bfhCFSQX+5UFrqWgNss4l3NiHxorSr7a0GgMARiicfs/5HwMi3c9dmLdrmVz
GReJ9Lv/de/IBcV9w19LH1FUMzTIAyM6mbce3rCLyQuy+GKMTVJmb9ptw3ow0+bZ
WtKO107furCNcuYedWfkJpJMWUK0YrZfKhtSH6JFPehN8nJSyoMqmUrOyeONoK5P
Xl2CnSob/4Ew9CatY7LfZGAJKtmlKug3FamEmlRf2YKtNXWkxy2osaMCPxLHgjAL
1eJiLv2iBrbu3Xlz5dZ/YDauAGuSKUAOR9+Q8B8VXu7ReaKy4S96gaQ/QDAljA1n
taF4CBK8mXE7ITqjFY7wBWHOnx/vWf30CsDR5/0wzgwCLBZJ+CqrEwNbGVTSB69O
+q55+3uvaLF2MyQr6Wv8ltHQ37MR3E8z/z1ICHKRMjKS6ow9rUz7plxToHVH9HmN
GxXe7REFarNoEBMJP94VGI6U42Qoef822rjDz3aDpkksHt7cFprt/vb8owe7sWk+
MWGWDF4CqnKWCu7xuNuaBZqNj/Jp4hOEmNt38VsuVWEUO+VACb9MP6TM9+dz7uCC
+3IXxOFhJ2r6GzhBeDZOJCjD5tShzNpyOwCZWiR1FMzyHF4LZ7A=
=fyeE
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
