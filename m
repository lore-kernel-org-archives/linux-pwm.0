From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 4/4] pwm: sunxi: Add H3 support
Date: Mon, 5 Sep 2016 12:09:19 +0200
Message-ID: <20160905100919.GD31424@ulmo.ba.sec>
References: <20160831082520.25962-1-woogyom.kim@gmail.com>
 <20160831082520.25962-5-woogyom.kim@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160831082520.25962-5-woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Milo Kim <woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 31, 2016 at 05:25:20PM +0900, Milo Kim wrote:
> H3 PWM controller has same register layout as sun4i driver, so it works
> by adding H3 specific data.
>=20
> Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Cc: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Milo Kim <woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-sun4i.txt | 1 +
>  drivers/pwm/pwm-sun4i.c                             | 9 +++++++++
>  2 files changed, 10 insertions(+)

Applied, thanks.

Thierry

--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXzUROAAoJEN0jrNd/PrOhexEP/R7Q5H3A6p3e637LK75PQ7a8
UTIbIWNaW9OL0j/3u3HY7qRxcSdmtySgp3r8fsYryciw1d0a3WTFB+K3c99YFxtd
Hiibc8GOvMAJ2yfPldhnbxnGRBG/xkWjMUCQEmncO7XrZclr/QUymGmsXJptTJiZ
JTGfK26PWt3wyaD8fKwhIlAbiJ2/oJYcdnri9fY+IrfLYxJHbdTdsvnyy16cNfSR
eeWHyPtVY9UEQTLvhDbkTwvBYGCbBKnUYPQu6ba89kM8PTXlofpyCFWjHGG8NYFJ
gbipmp/s2YQHxDmZydvBxa6g9SmWAgnMppOozNr0rbI+iSn3e2Ct/h03d2uVkzMY
7GVacz5wMKQDR+xqwGh5Jsb2HZnAXOpbKjKemBU/IPANPHHLXkGEbYh6WpWfciXz
Cq5A+NgAohSXl67uM/R5VUMAPMz40pE+w1UjppJ+nDFrPbkZo3q7YHHwcCm5HQoX
g4WDkRcxOKFTMBlyK3yiE+8PTpPpUsGKrOWIame7uyxky7XTc8fvvNrEIvGKjXjO
DHgnWYz89YWdJ/+GedYBLK6nifKb53tyCgF/9Yh/dDgU7xsFDPVQNPmiLQA4WhBa
foPsBnTeTMCc/UYdwP0kPHEJh6em8khlPahMHatFbjY0A+VPOwfaBk9dMla3o6Hy
tNoNBKwR5VmBYmtbTdXO
=J2jr
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
