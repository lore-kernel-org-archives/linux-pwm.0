From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: fsl-ftm: set pwm_chip can_sleep flag
Date: Fri, 23 May 2014 09:15:05 +0200
Message-ID: <20140523071504.GA6310@ulmo>
References: <1400717120.23867.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ee0-f54.google.com ([74.125.83.54]:51326 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453AbaEWHR2 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 23 May 2014 03:17:28 -0400
Received: by mail-ee0-f54.google.com with SMTP id b57so3374711eek.27
        for <linux-pwm@vger.kernel.org>; Fri, 23 May 2014 00:17:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400717120.23867.1.camel@phoenix>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Xiubo Li <Li.Xiubo@freescale.com>, linux-pwm@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2014 at 08:05:20AM +0800, Axel Lin wrote:
> The implementation of .config(), .enable() and .disable() operations in t=
his
> driver may sleep, thus set pwm_chip can_sleep flag.
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/pwm/pwm-fsl-ftm.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
> index 420169e..a18bc8f 100644
> --- a/drivers/pwm/pwm-fsl-ftm.c
> +++ b/drivers/pwm/pwm-fsl-ftm.c
> @@ -454,6 +454,7 @@ static int fsl_pwm_probe(struct platform_device *pdev)
>  	fpc->chip.of_pwm_n_cells =3D 3;
>  	fpc->chip.base =3D -1;
>  	fpc->chip.npwm =3D 8;
> +	fpc->chip.can_sleep =3D true;
> =20
>  	ret =3D pwmchip_add(&fpc->chip);
>  	if (ret < 0) {

Applied, thanks.

Thierry

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTfvV4AAoJEN0jrNd/PrOhkyUP/i+876IKjieMSMddRjnqJe+J
7qwOVvRBWvq8NYCBs64Vji/fZa2r7DD9VDjIi0YtQC/o3Mx+rPNIa+N6WlrOaeF/
O1wcjXz85Qv91tm5IHzPiuYy7upSBcEor7GZQzaPkVUpo+Qom0H1e2Ji9K0X9a4L
xjA3yZXz2vpcOkq6BG+pPDqkeGI1G3yoNiLqgvpKpsF0PX4Apmv9AqlqDDZ7BxG3
rMirbwEYWcUdIVih0WMa98MMWseK3fBJAEKpba7uiMB0u3aBfYweiNeSEyJCP0c+
h3nE+az9qvzDtu5lWA2VsirOMoo86Npr3uuaKo6d/QrtrRqeJWugN+xqs3YRUs1q
+WNB++BZPx+QaH+J6746EwIfp8lnBkDXvofQw/DDeP7CqiuJeTSqmMJwQHHj+Y/v
+nBumxqY3J4wxeUGuAiasF32byvNm+TQPIB4KdHDrWuhandVP/ByqFC1fUnYcwbY
2W1GznGcIR78+YicvUlk+oGOCaRo8ZJSGpdOJpF27Xxh6je5QLcfs2RRznxJmU0S
ys9Q9gDGDd1i9zTAM4lUfFAsRz2hrdIR9Ql3UBWL7DhDNMI5dDfMKEQPJA58b0pO
0wxACChewdY5jKpl+dVw8fR3Y5G6b7DhFG9j2aqyjMt/g3G7fGqccJEoUaLR4SPx
QTqXXKN7r64OKvvUJrQY
=nXRQ
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
