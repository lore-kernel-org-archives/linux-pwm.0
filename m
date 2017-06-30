From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: pwm-backlight: add pwm-delay-us
 property
Date: Fri, 30 Jun 2017 13:25:05 +0200
Message-ID: <20170630112505.GA18448@amd>
References: <20170630112109.13785-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8674726711365158115=="
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20170630112109.13785-1-enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Thompson <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <jacek.anaszewski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, huang lin <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org


--===============8674726711365158115==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2017-06-30 13:21:06, Enric Balletbo i Serra wrote:
> From: huang lin <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>=20
> Add a pwm-delay-us property to specify the delay between setting an
> initial (non-zero) PWM value and enabling the backlight, and also the
> delay between disabling the backlight and setting PWM value to 0.
>=20
> Signed-off-by: huang lin <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
> ---
> Changes since v1:
>  - As suggested by Daniel Thompson
>    - Do not assume power-on delay and power-off delay will be the same
>=20
> v1: https://lkml.org/lkml/2017/6/28/219
>=20
>  Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt | 6 +=
+++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlig=
ht.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> index 764db86..49b037e 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> +++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> @@ -17,6 +17,11 @@ Optional properties:
>                 "pwms" property (see PWM binding[0])
>    - enable-gpios: contains a single GPIO specifier for the GPIO which en=
ables
>                    and disables the backlight (see GPIO binding[1])
> +  - pwm-delay-us: delay between setting an initial (non-zero) PWM value =
and
> +                  enabling the backlight, and also the delay between dis=
abling
> +                  the backlight and setting PWM value to 0.

"Hardware needs a delay between setting an initial (non-zero) PWM and
enabling the backlight using GPIO. The 1st cell specifies this delay
in micro seconds. Hardware also needs a delay between disabing the
backlight using GPIO and setting PWM value to 0. The 2nd cell is this
delay in micro seconds."

Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAllWNRAACgkQMOfwapXb+vL0lACgrF9/F+yTmwc38tPUt6qc1q6J
4ioAnjHpcp7oisDTay0pWf7y8XMYk3NJ
=Kb7S
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--


--===============8674726711365158115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-rockchip mailing list
Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rockchip

--===============8674726711365158115==--
