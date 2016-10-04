From: Lukasz Majewski <l.majewski@majess.pl>
Subject: Re: [PATCH v2 0/6] Support PWM polarity control
Date: Tue, 4 Oct 2016 09:48:05 +0200
Message-ID: <20161004094805.466ebc6d@jawa>
References: <20161001101235.24598-1-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6448540708196151922=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161001101235.24598-1-bhuvanchandra.dv@toradex.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, l.majewski@samsung.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, stefan@agner.ch, robh+dt@kernel.org, thierry.reding@gmail.com, kernel@pengutronix.de, fabio.estevam@nxp.com, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

--===============6448540708196151922==
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/X=kkHv9sKcq+KBrXQ.0/zz5"; protocol="application/pgp-signature"

--Sig_/X=kkHv9sKcq+KBrXQ.0/zz5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Dear Bhuvanchandra,

Thank you for your effort to send those patches to ML.

> Changes since v2:
>=20
> - Picked the stalled patchset[1] from Lothar Wassmann which adds the
> basic support for polarity control on imx-pwm driver and adds
> backward compatibility support for devices which does not have
> polarity control feature.
>=20
> Changes since Lothars v6:
>=20
> - Squash Lukasz patch[2].
>=20
> [1] http://thread.gmane.org/gmane.linux.pwm/1621
> [2] https://www.spinics.net/lists/arm-kernel/msg530818.html
>=20
> Bhuvanchandra DV (3):
>   arm: dts: imx7: Update #pwm-cells for PWM polarity control
>   arm: dts: imx7-colibri: Use pwm polarity control
>   arm: dts: imx7-colibri: Use enable-gpios for BL_ON
>=20
> Lothar Wassmann (3):
>   pwm: print error messages with pr_err() instead of pr_debug()
>   pwm: core: make the PWM_POLARITY flag in DTB optional
>   pwm: imx: support output polarity inversion

For some reason this patchset works differently than the one developed
by Lothar.

The difference is with the brightness level control.

My brightness definition in DTS:

           pwms =3D <&pwm2 0 5000000 PWM_POLARITY_INVERTED>;

 		brightness-levels =3D <  0   1   2   3   4   5   6   7   8   9

					 ..  ............
				    250 251 252 253 254 255>;
		default-brightness-level =3D <50>;
		enable-gpios =3D <&gpio1 2 GPIO_ACTIVE_LOW>;

When I go to the backlight sysfs entry:

cd /sys/devices/soc0/backlight/backlight/backlight

It seems like the brightness level control is inverted - i.e.=20
'echo 20 > brightness" makes picture on the screen very bright, and=20
'echo 200 > brightness' makes the picture diminish.

With my "internal" patches the situation is opposite (and I've checked it w=
ith
my HW connections).

Could you check on your setup if similar situation takes place? I mean
if the brightness control works as expected?

Thanks in advance,
=C5=81ukasz Majewski

>=20
>  Documentation/devicetree/bindings/pwm/imx-pwm.txt |  6 +--
>  arch/arm/boot/dts/imx7-colibri.dtsi               | 12 +++++-
>  arch/arm/boot/dts/imx7s.dtsi                      |  8 ++--
>  drivers/pwm/core.c                                | 31 ++++++++------
>  drivers/pwm/pwm-imx.c                             | 51
> +++++++++++++++++++++-- 5 files changed, 83 insertions(+), 25
> deletions(-)
>=20


--Sig_/X=kkHv9sKcq+KBrXQ.0/zz5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlfzXs0ACgkQf9/hG2YwgjEc5QCgxRwKKNoYv3w9mw51nYD6uOcl
PvEAnjygNuh+8QQTFvPDkiS3SZcqX8j+
=FGHs
-----END PGP SIGNATURE-----

--Sig_/X=kkHv9sKcq+KBrXQ.0/zz5--


--===============6448540708196151922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6448540708196151922==--
