Return-Path: <thierry.reding@gmail.com>
Date: Wed, 14 Aug 2013 12:48:24 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: pwm-tiehrpwm: add missing __iomem annotation
Message-ID: <20130814104823.GA14228@ulmo>
References: <000f01ce8f48$9a60de60$cf229b20$@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <000f01ce8f48$9a60de60$cf229b20$@samsung.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Thierry Reding' <thierry.reding@avionic-design.de>, linux-pwm@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 02, 2013 at 03:22:03PM +0900, Jingoo Han wrote:
> Fix the following sparse warnings:
>=20
> drivers/pwm/pwm-tiehrpwm.c:144:16: warning: incorrect type in argument 1 =
(different address spaces)
> drivers/pwm/pwm-tiehrpwm.c:144:16:    expected void const volatile [noder=
ef] <asn:2>*addr
> drivers/pwm/pwm-tiehrpwm.c:144:16:    got void *
> drivers/pwm/pwm-tiehrpwm.c:149:9: warning: incorrect type in argument 2 (=
different address spaces)
> drivers/pwm/pwm-tiehrpwm.c:149:9:    expected void volatile [noderef] <as=
n:2>*addr
> drivers/pwm/pwm-tiehrpwm.c:149:9:    got void *
> drivers/pwm/pwm-tiehrpwm.c:157:18: warning: incorrect type in argument 1 =
(different address spaces)
> drivers/pwm/pwm-tiehrpwm.c:157:18:    expected void const volatile [noder=
ef] <asn:2>*addr
> drivers/pwm/pwm-tiehrpwm.c:157:18:    got void *
> drivers/pwm/pwm-tiehrpwm.c:160:9: warning: incorrect type in argument 2 (=
different address spaces)
> drivers/pwm/pwm-tiehrpwm.c:160:9:    expected void volatile [noderef] <as=
n:2>*addr
> drivers/pwm/pwm-tiehrpwm.c:160:9:    got void *
>=20
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/pwm/pwm-tiehrpwm.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

Thierry

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSC2B3AAoJEN0jrNd/PrOh8fMQALw6D4FN7C8xy09xBI0S+fQZ
7LGkIZY0wJGvhIA74ipO88KaTTan2KP77+vdy6UNMlW3yP48zYW7KWXtZOiiLtPY
UPIbrY4Jux/K7lY0b+LoO2SNar5FvU2UAjBlaqQNTHeimIC9U887Kxukoa9O5bYv
wxV2kXDQrT1vB6SnjyljDE70beIiWCi672h4zDjsiAxw9za/i+k5UbwNqRaKKpAd
I5nXzcvZFPl8QO/i/2j9htr8SDewE6Xa5nRGINU3YrZ1Qio9qrGdTWQZcP05+5MX
A4hUt+mnsyfJ9Gz+kDZa44JeFRwpfY61sk4RIkqIoFM9LqyQpZsvcGgkjS3qDN7F
PNR0aaXt7TS7S8MdHziQfy/cBEE3tVN66MqEwyXBg4DL/PdCjv1pcCzvSfjYaOf2
pH1yR7OsE+jx6Lb+Ml7uySVk+o40gHlPhcZ8YIw9TeO2hVIsoynG0hOlv9Zl1ZJD
yl/Nz08QGd5v2/aRQupQcq5jv3Fg0WYl+EpYl4SogL0IM5IOMmwYHRToyDsNChKU
rKHv8fMVYNR+Ht/wIpoMdRd/MYzZDlnVtnOh1aJVkEIcj0dwhbXtg/JWpPloYRey
fc3J8Aa7Lpq+O90qa00ZXiQb0hN0xTA1YAWiAjUHfe47dDkkvH9ydVK4lw2Di+mq
rFIeKcM+mlrp1sg4jPRT
=iP6V
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
