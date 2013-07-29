Return-Path: <thierry.reding@gmail.com>
Date: Mon, 29 Jul 2013 13:45:32 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 16/20] pwm: Remove superseded pwm-samsung-legacy driver
Message-ID: <20130729114531.GD23152@manwe>
References: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
 <1374278673-25615-18-git-send-email-tomasz.figa@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jCrbxBqMcLqd4mOl"
Content-Disposition: inline
In-Reply-To: <1374278673-25615-18-git-send-email-tomasz.figa@gmail.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>


--jCrbxBqMcLqd4mOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 20, 2013 at 02:04:29AM +0200, Tomasz Figa wrote:
> This patch removes the now unused pwm-samsung-legacy driver, which was
> replaced by new pwm-samsung driver.
>=20
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  drivers/pwm/Makefile             |   1 -
>  drivers/pwm/pwm-samsung-legacy.c | 353 ---------------------------------=
------
>  2 files changed, 354 deletions(-)
>  delete mode 100644 drivers/pwm/pwm-samsung-legacy.c

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--jCrbxBqMcLqd4mOl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR9lXbAAoJEN0jrNd/PrOhGlwQAI6AhvaAZAmrMGd60gG8IRoz
Cgs359sl96vUbsupucXMn9QBp4MrxPVZqN7mCfJTPEwPZC1Hmw9MmRgvwB8cd0Wk
4idr79SsA53MK9ATTVGt+W3BOPl0R++uTyM7jAsy+tg/bztn4lZ7Yn5ryXef+lXO
Q6eij0rrlsW5J2kcp9uqRPiCosqirM++/eNYez9pKGDRHzXghdZhgPZbyDftDVu9
0ELMJtkLT2yBDN10Z1RwipD0v3ZKqIxJ0o4pH6qrvyXIqY0goc/S/c3vwpGJimZY
exIM2TSxQD4ZIOEn7lDPyQmYnZq0bvI5B1FcCQhW4S5126y37qDjmL2Jy5fkWG7/
2v3OQzwkgEutTbKGo+feaTiPeoZzA4VBWl5P79hBmLSchjOCr/KbRxJ9eDJC9PQU
3IJOact/Xr8otLx47Pe4ITDlLmhQM5WMRthNsU8HCFBxCNvQ7ExZFkva8qV66DrI
h9VtD5imsff+vZGm0aNH5ixvOAjfqpEyFVfjSxa6vKCInObhYKlpLlUleP1d6+zz
zx32B/mKjeUb8lBeNuVbuJAzpfvcdYfwAOJ9IA7YHjL04OtpnEKGNPPOjjLHukMs
Cc+Zzp9ou1a/0wB6QPD4aAI4/2wtdH+Bxhf1SI0Jbxi/6NBS6ioa7fr17pRIrUzm
sYhrMUo1leHenSm/VgIH
=DaL3
-----END PGP SIGNATURE-----

--jCrbxBqMcLqd4mOl--
