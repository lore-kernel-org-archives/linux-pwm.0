Return-Path: <broonie@sirena.org.uk>
Date: Mon, 25 Nov 2013 17:29:04 +0000
From: Mark Brown <broonie@kernel.org>
Message-ID: <20131125172904.GP14725@sirena.org.uk>
References: <20131122142231.GA1741@ulmo.nvidia.com>
 <20131122145224.GO14725@sirena.org.uk>
 <20131125031029.GC11613@S2101-09.ap.freescale.net>
 <CAOMZO5CtNnma8Sv35P3jeNYQiLV=jdmN0Q7w2_LFMOj-nTbPZg@mail.gmail.com>
 <20131125133659.GA30476@S2101-09.ap.freescale.net>
 <CAOMZO5DW3pSxPGe6N0CRiCEc+iVV9X_13JbzAvuFbb4jide+zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RvYRPxT9kmUw5evD"
Content-Disposition: inline
In-Reply-To: <CAOMZO5DW3pSxPGe6N0CRiCEc+iVV9X_13JbzAvuFbb4jide+zw@mail.gmail.com>
Subject: Re: [PATCH] backlight: pwm_bl: Do not make the regulator mandatory
List-ID: <linux-pwm.vger.kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <fabio.estevam@freescale.com>, Marek =?utf-8?B?VmHFoXV0?= <marex@denx.de>, Thierry Reding <thierry.reding@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pwm@vger.kernel.org


--RvYRPxT9kmUw5evD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 25, 2013 at 12:43:58PM -0200, Fabio Estevam wrote:

> What commit provides this regulator core functionality?

regulator: core: Provide a dummy regulator with full constraints

> Looks like it has not reached 3.13-rc1.

Yes, it did.

--RvYRPxT9kmUw5evD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSk4jdAAoJELSic+t+oim9apsP/RRuWcCJjVPmqM3Xl0t9wKOi
8iTJI3GZqC5HqtI0Fw77XLGg3M5Kubp+qgGV4wTuzRxl/22YUujPAegfIc2Huerp
LEgfTGyxmXA1Cb6UO6UGbIZB2R865czksNfsK0iTr40IzEtBhnTHuM2BhaJFIFcB
0SXxqrfHD8POCx8RTlN6xkzuAHrKQ5s36tQ71saH6PTNnAcFSLE/6KMj1Xh9txKU
ZzUy/9uQX6ivIcHoqjLX4RZ1BgmRU73SSv36cCWNlV0ip2Gdi4JKEGcNe7UQ6aYA
8EbS2pqcZdnorDG9B1IGd5R6gJ09MXMMFQS5Xpqfse7pv/SIbkdeoThOZORy/y9k
KnL5zIj7PZlUSeLk4lOR0vkW6dpRb8MF2N4XEqkXRRKVSoX83Cn2dRxKRuEWg4Pi
S/RTDKuMMF+v6lLw14vY0nmrVg/PzmYUzVVaxistDUXXe7vfBFhR7WRAmhP3MbCy
pcqSWQ3AWQ9F5nGtCRiPYUFY7lohi+TuJSu+u/9y8fWZKuZG7tx97Z24pwVyR3BO
LPNerlM5GYEop1dTgmJv05CVKHoRWI4upGUrSlJ7oTb4pUroa+OFQXbGkNGBPUba
m1RXQiznOuh4HL1J3Rl1HXBCYMlXRNtcec86RULdYlK8YKTFthaMdD+EHVKsJgaW
mM6/tGQEFS0ajgVAmDfK
=wwE/
-----END PGP SIGNATURE-----

--RvYRPxT9kmUw5evD--
