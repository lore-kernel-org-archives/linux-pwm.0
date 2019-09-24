Return-path: <kernel-bounces@pengutronix.de>
Date: Tue, 24 Sep 2019 13:03:26 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20190924110326.GG14924@ulmo>
References: <20190923084937.20358-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8bBEDOJVaa9YlTAt"
Content-Disposition: inline
In-Reply-To: <20190923084937.20358-1-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/3] MAINTAINERS: add a selection of pwm related keywords
 to the PWM entry
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>


--8bBEDOJVaa9YlTAt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2019 at 10:49:35AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> This is just a small subset of the relevant functions, but should at
> least catch all new code as every consumer has to call pwm_apply_state
> (or the legacy function pwm_config) and every PWM provider has to
> implement pwm_ops.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

All three patches applied. Thanks for volunteering to be a reviewer!

Thierry

> diff --git a/MAINTAINERS b/MAINTAINERS
> index b85f2abfe69b..2e8dd2ea4eaa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13254,6 +13254,7 @@ F:	drivers/video/backlight/pwm_bl.c
>  F:	include/linux/pwm_backlight.h
>  F:	drivers/gpio/gpio-mvebu.c
>  F:	Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
> +K:	pwm_(config|apply_state|ops)
> =20
>  PXA GPIO DRIVER
>  M:	Robert Jarzmik <robert.jarzmik@free.fr>
> --=20
> 2.23.0
>=20

--8bBEDOJVaa9YlTAt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2J9/4ACgkQ3SOs138+
s6GAJA/+KAXbZrvmE4BhxjVt6j0+Z+VsP9oculsxeVlXWrvZoklv+7C5URh+jKBg
BO2KsOJjUYFlpI6smIhBrBHIIGrAd35Sastr5uYYn330jkG+bPTjcfx9oon/bPwA
tYHQfJAs64dgE5nSNnp+S91EYO9BuAt0Qsnng13XXPazyjkOVzTp24IMXGLMkG5y
5b8j8Jl3JIqc8AhZIHYru13HACOzdwGA74C2E6hRZzo2lykzqPsROTOc5zOsdwBv
SVcm/Zcte2Vz3QdrjBORfLsWSqNyG3e/SDguNQKYF3qEIEgD1l+IpIf5aafGLPVd
dCwOncRFTz+gFCYFX90bshfmnp5YKCyTwVMAGk6VMjFtqXDAD2MjTVWmAXBByavR
LPR2LsFcCohv3dLTryrha4nUjZwlPQrkhPtrSpKEZi+n2AgAv7ITDe6rb1dNP1rA
6/PwHHi/8udAlIaR763YAAcyGbTOfNPpgmbIUVZt5s2SYKUo/crpQEyGwILZTpeK
hcXTpvtrIE8YNwR6d5nZ1ELbCBiNkpTOCjk/Ospitp0sFoX93sSts8B4WUd/f6ED
46frDDYK9Gw3y1uEmJfZGb5CLb29vkPab4BmRdZxxprtkttxC770/sS/3u51uGkf
GBKLNroYESED770h0LkZZU4WJAFnkx1nZNiVktpcjXEz0x07HBs=
=nVwz
-----END PGP SIGNATURE-----

--8bBEDOJVaa9YlTAt--
