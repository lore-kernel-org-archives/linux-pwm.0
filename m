From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 0/6] Updates for the atmel PWM driver
Date: Wed, 8 Jan 2020 14:00:26 +0100
Message-ID: <20200108130026.GE1993114@ulmo>
References: <20190824001041.11007-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0413883696728615855=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190824001041.11007-1-uwe@kleine-koenig.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: linux-pwm@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Claudiu Beznea <claudiu.beznea@microchip.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


--===============0413883696728615855==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7LkOrbQMr4cezO2T"
Content-Disposition: inline


--7LkOrbQMr4cezO2T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 24, 2019 at 02:10:35AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> this is v2 of my series to update the atmel PWM driver. (Implicit) v1
> was sent on Aug 15, starting with Message-Id:
> 20190815214133.11134-1-uwe@kleine-koenig.org.
>=20
> I updated the patches from the feedback I got in v1, see the individual
> patches for the details.
>=20
> Best regards
> Uwe
>=20
> Uwe Kleine-K=C3=B6nig (6):
>   pwm: atmel: Add a hint where to find hardware documentation
>   pwm: atmel: use a constant for maximum prescale value
>   pwm: atmel: replace loop in prescale calculation by ad-hoc calculation
>   pwm: atmel: document known weaknesses of both hardware and software
>   pwm: atmel: use atmel_pwm_writel in atmel_pwm_ch_writel; ditto for
>     readl
>   pwm: atmel: implement .get_state()
>=20
>  drivers/pwm/pwm-atmel.c | 86 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 73 insertions(+), 13 deletions(-)

There were two patches in this that were not reviewed or acked, but they
seem trivial enough, so I've just applied the whole series.

Thanks,
Thierry

--7LkOrbQMr4cezO2T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4V0mgACgkQ3SOs138+
s6GwPxAAi8QbyZuxjXTyrcwXhceTZn1UkH51OaRD7myFIQ8A/sanP7QV2f4jKug8
TbrVlK9dpSj96Ne9UfXBW3+5+JvNpVshrqsc/IcIq6i+honBrJz9upJMKxt0+YRB
wNMO5dM/XEzr93hAilRGrzW/63rPsqkP/Vj14Gf3lOo/qW9WoCbWx+3/1bupYwm2
2ih1zLbDrR6d8PZ2mFkTl7WRXqOVcTpk/pyauBy2R/sq+7iK92lL4dugjlgtLO/W
mwW1g/hswT2D0FQ7QYBgApRUIsKsaSjjcLairZFTTmYvYvGSzyAsSbWPkQfMrh/T
qmMrL6TP49Ba0Ce1X7sff1hIeGsMMuhveg1viKbXDwPV0pvuT0ANejXHoPsW0Dum
6iB9xNSGyYupsbFq+Wn2LXO6dkVNCAsMVoMnxTzgAMvxoxQ7erpktjOKl5vi2dna
MHid3SqGo4kdRmGyKbGPATocpC/+A4f5fqx36Wo2sixGFpfsZhfoh2uXB9jo2bNx
b1zVcUfHxjzckt3QJPgYALNtkv5cYqbfE5nayz2m14oJDzYd8LCBloEsqak3+RMm
I4xoip1+vrA8c9qF30qHJTz4ef9s0sVB25GPd/rtOEduWvRm2rAPRmpij2u326su
N4tqKheeJJ8vscS8j+9t+WYdAOVFECuCO6YHC9wikPuZ+o6PoPA=
=opLK
-----END PGP SIGNATURE-----

--7LkOrbQMr4cezO2T--


--===============0413883696728615855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0413883696728615855==--
