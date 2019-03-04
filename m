From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 5/7] pwm: atmel-hlcdc: add compatible for SAM9X60 HLCDC's
 PWM
Date: Mon, 4 Mar 2019 12:05:17 +0100
Message-ID: <20190304110517.GB5121@ulmo>
References: <1551284609-14594-1-git-send-email-claudiu.beznea@microchip.com>
 <1551284609-14594-6-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1161722519=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1551284609-14594-6-git-send-email-claudiu.beznea@microchip.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Claudiu.Beznea@microchip.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.belloni@bootlin.com, bbrezillon@kernel.org, airlied@linux.ie, Nicolas.Ferre@microchip.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Ludovic.Desroches@microchip.com, robh+dt@kernel.org, linux-pwm@vger.kernel.org, lee.jones@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


--===============1161722519==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 27, 2019 at 04:24:35PM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>=20
> Add compatible string for SAM9X60 HLCDC's PWM.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/pwm/pwm-atmel-hlcdc.c | 3 +++
>  1 file changed, 3 insertions(+)

I guess it makes more sense for this to go in with the MFD changes
rather than through the PWM tree, so:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlx9Bm0ACgkQ3SOs138+
s6EWQxAAkN1EcQnql995goLfgqGi63WG+AC7uBVsPlv8MeYUyuk5uXHwpZIfL1Yk
U7vnC6E6EByjVnj18T/faZzqMgUJJlTzmVbPBT9C2D/GW7Hg9Sz6SCIg0tiNYaFY
uN095C/+FfnAxeqmBtufXU5dQQeYSG1kxs4H6mj6Ypl71Jw0h8fg5PoXpRTM6ZOL
s8KdHnFgZPFBYg3lioKV6UBrTWnV59YUPPbBChDam7jVv9muKp+VKGct7PRC9f64
LAfmR82g8dLP1HTv6IkYhLYU6gioCBUPuk3HAMb0MndUF4szMEUOJk4Z/UxMpnzN
xMcrHiiiEfkzvS9ugK9VAGGnMV63NmtpntaItyBsLvdEairrenqI2ci45QqgrHSu
IFartnXKU87MrPj2cm6kzR6T0Zv1o/xO3WfCSskU1euKqrRpSxHkYuM30nEP/ro+
0Fxi2UzOEZenAOgVEQra+Yi+OPXbAW12kdgsNRo7zo9tuvUgXBH1ekJM6okcZNOd
/kgD3Sacjp9PgDml/jzouuSsfPLITSqYLVQWMIHTn6Wrgl31p0+iv4e2wxRB7dPW
7iFts1ZqEA1oe6OyFBo7dOoljEcP7Mjjwipl9VUgm8n1lVyauLWUqUdpxtBXJA6/
MVNpUZvMZ2thGGVEpAvRwbCZ2lF+i3Zi0lWzwao3dnHgHp9hj54=
=/1Mc
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--

--===============1161722519==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============1161722519==--
