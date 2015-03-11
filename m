From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH RESEND] pwm: mxs: fix period divider computation
Date: Wed, 11 Mar 2015 13:13:03 +0100
Message-ID: <20150311121302.GA23668@ulmo.nvidia.com>
References: <1426075692-19340-1-git-send-email-ghug@induct.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:44510 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbbCKMNI (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Mar 2015 08:13:08 -0400
Content-Disposition: inline
In-Reply-To: <1426075692-19340-1-git-send-email-ghug@induct.be>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Gaetan Hug <ghug@induct.be>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.guo@linaro.org, fabio.estevam@freescale.com


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2015 at 01:08:12PM +0100, Gaetan Hug wrote:
> The driver computes which clock divider it sould be using from the
> requested period. This computation assumes that the link between the
> register value and the actual divider value is raising 2 to the power of
> the registry value.
>=20
>     div =3D 1 << regvalue
>=20
> This is true only for the first 5 values out of 8. Next values are 64,
> 256 and, 1024 - instead of 32, 64, 128.
> This affects only the users requesting a period > 0.04369s.
>=20
> Replace the computation with a look-up table.
>=20
> Signed-off-by: Gaetan Hug <ghug@induct.be>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/pwm/pwm-mxs.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied, though I made some last-minute changes, see below.

> diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
> index f75ecb0..c65e183 100644
> --- a/drivers/pwm/pwm-mxs.c
> +++ b/drivers/pwm/pwm-mxs.c
> @@ -35,6 +35,8 @@
>  #define  PERIOD_CDIV(div)	(((div) & 0x7) << 20)
>  #define  PERIOD_CDIV_MAX	8
> =20
> +static unsigned const int cdiv[PERIOD_CDIV_MAX] =3D {1, 2, 4, 8, 16, 64,=
 256, 1024};

I turned this into static const unsigned int, which is the more
canonical form and wrapped this over multiple lines so as not to exceed
the 80-character limit.

Thanks,
Thierry

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVADFLAAoJEN0jrNd/PrOh7icP/A9sZtwNKrA4UeAtaba3e84X
V06TuD6QPheNcBEq2wnn+iTLf/v8rU8jn8oOcboFjvYdFWpx6/WqNBVCzzhD8+87
qnYApghNzGfLz5BtjZA+zQEvc2oc02xr+X/tB8CKA4HTsCl3LXzLOZE84aPHvnFh
9pkyk5mRFbcBpjSfY64l7hWkIDsfCiehPSOxeSo+zSHvNCoPSAOmGUxaW66mIJKF
H3ogXURmgtKs60X3f2Ba14hjuu3kOk2pGnzFKftBecGezh1YxcxfDarNKCOHAo0M
Z/GyVIrDs5+d6d4QgYTK/uomWF2AY/qThWlul3heWnqd4jLWT+RoHOG9jgFsti60
npvlg2p3405WOrdb5RETrxPd3/AInTVe+9Mm7aaorg+eXBUXzxwL40qc2pU9BimZ
EJ999qDnXM272LrWyxg2QUhqqSRhzSVzLwpgIbwL6lZXWraVjeiJias3AiHTHj+A
WnvubSQKHAZY8XlxjqnI+xkxMxbH9emOWQnbonNn6PRvPZZf/fl5LEVHSpj78W8X
sdTtZKHghRp6afJofAXsv+CaLAUo7zYKWYdxPWM43rHlM/eqDtI6vFARP0GgkWWz
+Iz9/SAuasrOKlSRTL8R6LOHvFxCXm3Z1UWKr8LZurDXEloa9Wn208X62+t+SJD0
xp9SvTaYvegLKj7exDJT
=WE1a
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
