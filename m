Date: Mon, 29 Jul 2013 13:44:52 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 13/20] pwm: Add new pwm-samsung driver
Message-ID: <20130729114452.GC23152@manwe>
References: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
 <1374278673-25615-15-git-send-email-tomasz.figa@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kfjH4zxOES6UT95V"
Content-Disposition: inline
In-Reply-To: <1374278673-25615-15-git-send-email-tomasz.figa@gmail.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>


--kfjH4zxOES6UT95V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 20, 2013 at 02:04:26AM +0200, Tomasz Figa wrote:
> This patch introduces new Samsung PWM driver, which uses Samsung
> PWM/timer master driver to control shared parts of the hardware.
>=20
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-samsung.c | 606 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 607 insertions(+)
>  create mode 100644 drivers/pwm/pwm-samsung.c

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--kfjH4zxOES6UT95V
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR9lW0AAoJEN0jrNd/PrOhJYUP/AhHZ+kQTLcP0DwXpMYj9d0f
hxsjPFt+KHR0jw/gv/3UOr0+TX/546HNTPpiVE9FS8wu9pyhGdk5kB1Lc5ns9nGL
RPCPMxhZ2oP21l3epiuGxwvJiNaNCjVe63WwQxE6CQZGOtpS5+YFX95rAlnHwSUM
7I3UHZjJm7qvGzUIGkrI3FZ6+QYQB73OjMNRdMo/FX5mT3uprhtUOJ0tX+dSiRrT
x4We5aFsO7W8Jee/eT6efhtxtz92qq0Y6OQjQK9scMSzbtFGoT+WDakebTA+Kx9K
j7ASXqwffqdZFflVVxeEEn839s+LzSyPWI4SvUwV03rXpGYh5NokQFlLyGToicnA
+dZgNkidAZ+L2cDhge/9zNGQLtfs2HwxUSLz86CzCCh3g+7X/KB/ZaVPsYw0pVzl
rkbWJAFBjZNfrevmUEl0647Bvghpav8tVxqOret0kxlUkZ6die/8P8G+2Ptx6F3s
+OYsHeDDQ+Ixg+QxGZjVNsXslBxWZzROqZt5eqBYGpV0cRTU86UsrIgsa+yTh4g4
Qsk83mfVBz6B0+0ncwNXaMcWzz6bsJTQNi8Wr73ew2XSD+n0BTABpcWS5JEcuRpU
jhSMh6SRk+UiNBaeYaJoeUMnMQWlEyYGjnu+cC4N3atbDo6zNFL/EEmj59Pa1rCj
krS6JmPsZwKxe7mS5sdf
=TaBY
-----END PGP SIGNATURE-----

--kfjH4zxOES6UT95V--
