From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 3/4] pwm: jz4740: Obtain regmap from parent node
Date: Mon, 30 Mar 2020 16:37:16 +0200
Message-ID: <20200330143716.GI2431644@ulmo>
References: <20200323142421.42817-1-paul@crapouillou.net>
 <20200323142421.42817-3-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5uO961YFyoDlzFnP"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35247 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbgC3OhV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Mar 2020 10:37:21 -0400
Content-Disposition: inline
In-Reply-To: <20200323142421.42817-3-paul@crapouillou.net>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, od@zcrc.me, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Mathieu Malaterre <malat@debian.org>, Artur Rojek <contact@artur-rojek.eu>


--5uO961YFyoDlzFnP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2020 at 03:24:20PM +0100, Paul Cercueil wrote:
[...]
> diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
[...]
> @@ -196,12 +208,19 @@ static const struct pwm_ops jz4740_pwm_ops =3D {
>  static int jz4740_pwm_probe(struct platform_device *pdev)
>  {
>  	struct jz4740_pwm_chip *jz4740;
> +	struct device *dev =3D &pdev->dev;
> =20
> -	jz4740 =3D devm_kzalloc(&pdev->dev, sizeof(*jz4740), GFP_KERNEL);
> +	jz4740 =3D devm_kzalloc(dev, sizeof(*jz4740), GFP_KERNEL);
>  	if (!jz4740)
>  		return -ENOMEM;
> =20
> -	jz4740->chip.dev =3D &pdev->dev;
> +	jz4740->map =3D device_node_to_regmap(dev->parent->of_node);
> +	if (!jz4740->map) {

This seems wrong. According to the code, device_node_to_regmap() returns
an ERR_PTR()-encoded error code on failure, so I think this should be:

	if (IS_ERR(jz4740->map)) {
		...
		return PTR_ERR(jz4740->map);
	}

No need to resend for that, I can take care of that when applying. Let
me know if that doesn't work.

Thierry

--5uO961YFyoDlzFnP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6CBBkACgkQ3SOs138+
s6HtCw/+ObsrCeW3Qpro0kEkUAgc55EE8fppGxsicDBZs+p64q4N3XCH0iduAZuc
3yeXxtv5jLhz5x9/kwq+h61+UzAqrPbCOWBOBOTq5s2srhrr6WSi9zCYUR6AaTjv
Ooq6wm0rNJzuIvfWp/+EoLl/MTuJOD/WauAT01rvygN9b7i+fgSORlsDkoKptiJ2
C7KwuvhqGlHRcAoHtOfgLub6jca/kWwifSWQ1gBkc312IcKuW6ZLHfu7ijLf8+bc
oH8C/FNuC++mjT13lLJoqc1yIB1y0h1asX2VYUgsQPQGT1ioKjNsgUFqdEKIq49S
HVzvpIGMsQKiDyO9ka++tMItvLz/L8oMBCCYgHp0zNX8FiSqWqsK/RliMZSHiQFj
WMyYMbJZPp1Bbxjy4lz8bQz2pQQMbC9dSKlU4PI/hG9JVo/GsM/m1Eu7iUKW7+KB
P1yJKlG5PqOlPpumyb+vkNOysYbAV4hiSAQt440ga7+SkObdUK+sh6vv7zHMsa2T
ULjANwIcBiyFR4C0jicNqehIqCql4u/GvNpY2plagzm8kIt7woyTHkWNF12utnJO
rgAUY75J6QWWmXmzetmVMiqg2fVyzIyrJwhS8xt8SoJM/XWnSf4AuHAkpIBaXuGb
eQ/hGqkwSHcs+KHgVoyvN9Yu5uIUS2Vtq46NthNGHFMphaxR0fc=
=SgmS
-----END PGP SIGNATURE-----

--5uO961YFyoDlzFnP--
