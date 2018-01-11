From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v1 4/4] ARM: dts: add pwm node for r40.
Date: Thu, 11 Jan 2018 13:47:52 +0100
Message-ID: <20180111124752.2ljspnaclwgz2s62@flea.lan>
References: <20180111113412.GA22008@arx-s1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4xnqe4wdxzka55yq"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180111113412.GA22008@arx-s1>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: hao_zhang <hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--4xnqe4wdxzka55yq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 11, 2018 at 07:34:12PM +0800, hao_zhang wrote:
> This patch add pwm node for r40.
>=20
> Signed-off-by: hao_zhang <hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  arch/arm/boot/dts/sun8i-r40.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r=
40.dtsi
> index 173dcc1..84c963c 100644
> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> @@ -295,6 +295,11 @@
>  				bias-pull-up;
>  			};
> =20
> +			pwm_pins: pwm-pins {
> +				pins =3D "PB2", "PB3";
> +				function =3D "pwm";
> +			};
> +

Is it the only combination of pins that is usable?

If so, you can add the pinctrl-0 property directly in the pwm nodes.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--4xnqe4wdxzka55yq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlpXXPcACgkQ0rTAlCFN
r3Thyw/9Grr+zgmNahbjNDuTMPgbsjO+ABnXgTZ/p/9QiB9TySIUIOtmP4jIXnWa
mPoFOkpWXJaW+8RJWP+BnN8eDGyCJ/SfK1G+l5MtLMR5UySWBNObK35hOLP3J4My
Bwa5Vi6KOOyV8lcKG8TyewfhTWGoKJ9e61XEdxgFI2YPij2yzGsJYC3P1xYlfH/Q
5nnqpzROVg7PNy9H5diOE/g4DmlqgbHuBfbBnCDcbOOe2IrLVbdq1LazkE2mbPAb
hxOhturwE80+ytFllyjbQJ5CBo0Z8ZYt8lAas+xpJ9lJO3VZB9/b4UwgeQtbGsWB
l+mV1adsspmiWg518FjsOIKgmysaHuOHZDX7dWzwnoiqFBfW4oo/YfQKX2wGnPUy
upE7VYyXxPSVaXSRjK28uPB4NdhdwpQug3XkhGvTxjNmM5NzW9I4NLJXmF0c6lYd
65T3FDUnvLigeY/XKV1f8SZ26KxpoKmmxYk0UnilEkotXC0fq+rAhy+kV8lf0kci
sAFtlNGUHRe0gQhD+CzDJ1Sss+fx6kNRd5dpot/Tqd1STG5qhQmx+PzWY9PCgqln
+XIJO3w2dmcXkGx7JgAy0D6tiGJheiViCNLxtEJ7TkCt0kDo1yp6rI4gja0kQdza
bsyNyTAhrNhMis0eZFYGfVBtpYcrZtoDyfjwikHhfj022LgPe7k=
=iQ7m
-----END PGP SIGNATURE-----

--4xnqe4wdxzka55yq--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
