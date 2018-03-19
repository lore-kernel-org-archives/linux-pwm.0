From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RESEND PATCH v5 1/5] pwm-backlight: enable/disable the PWM
 before/after LCD enable toggle.
Date: Mon, 19 Mar 2018 17:58:29 +0100
Message-ID: <20180319165829.GB22770@ulmo>
References: <20180216174034.15936-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6113318384672132869=="
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20180216174034.15936-1-enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
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
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Thompson <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <jacek.anaszewski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, kernel-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org


--===============6113318384672132869==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2018 at 06:40:30PM +0100, Enric Balletbo i Serra wrote:
> Before this patch the enable signal was set before the PWM signal and
> vice-versa on power off. This sequence is wrong, at least, it is on
> the different panels datasheets that I checked, so I inverted the sequence
> to follow the specs.
>=20
> For reference the following panels have the mentioned sequence:
>   - N133HSE-EA1 (Innolux)
>   - N116BGE (Innolux)
>   - N156BGE-L21 (Innolux)
>   - B101EAN0 (Auo)
>   - B101AW03 (Auo)
>   - LTN101NT05 (Samsung)
>   - CLAA101WA01A (Chunghwa)
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
> Acked-by: Daniel Thompson <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Acked-by: Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> Changes since v4:
>  - Rebase on top of mainline.
>  - Add the acks from Daniel Thompson and Jingoo Han.
> Changes since v3:
>  - List the part numbers for the panel checked (Daniel Thompson)
> Changes since v2:
>  - Add this as a separate patch (Thierry Reding)
> Changes since v1:
>  - None
>=20
>  drivers/video/backlight/pwm_bl.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

I'm surprised that panels even care about this. Do you see actual
breakage if these are the other way around?

Anyway, this seems to me as legit as the other way around, so:

Acked-by: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqv7DUACgkQ3SOs138+
s6FtSA/+J4+ctso+elhrUgaQEp71DttppYWGb10uYQS8GV16ZtVU2367zWt+9WNF
u0VGLmrwwvqFpvxDAQ8YYE07758CbkdWb5qonRmdN4pLOi3aNw7ywHS5ysljyPfi
Wv6tw2RaNGVCPcRH9MNwK903y8flOVLgz83CsnBtIWvM9nnSRp8IlQrzh/GIPb92
FdrrG1cDpwzgMvD+gnXH2TBvMTM8MH4qIpYSixkim4QNZ61LDHJ9CBcc+DLpiCjX
Qb31E6SemW+S4sdAq+dpgRH3e+/CCxyHcLkQWfBpsLd1aGA2AWgDhI2OdIVqLai7
QFE8eiJMqra0hV7MYF2IvYjMzJcUp4+JkPXA5slo0wW+CuJ7Vs4oDF1gHzLjsMmR
lpHUvIKoDddEaGwk7BCaiTDaDz4YPcdzcreBdwstD05faxDkPxycuEmwRpS0HvSB
q6Vaiuh3DaCBnkQFy3dlSSrWJ/f3B2x9g4rD1f2vv887tB3IP1lBna9sr7u9WJzD
95K0baI/rbXmRrGh/K+bT2zxmSUjlTOM407n1IG/ig8+06/J6Y4bOCvcHBqUGG8Y
R/8xqTSKtfutsDJBn7CrN0hZladFG0b5csW3ZMW0BYuqyyYWklHI95eAgoRS3xH8
QZADh2oGyMr4Ja12GTl8ynvGkO5k+aKDrze0CXwbkeTyL+tOvDU=
=6Ehc
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--


--===============6113318384672132869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-rockchip mailing list
Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rockchip

--===============6113318384672132869==--
