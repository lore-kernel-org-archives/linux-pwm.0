From: Lukasz Majewski <l.majewski@majess.pl>
Subject: Re: [PATCH v2 0/6] Support PWM polarity control
Date: Thu, 6 Oct 2016 08:26:17 +0200
Message-ID: <20161006082617.54ebf41e@jawa>
References: <20161001101235.24598-1-bhuvanchandra.dv@toradex.com>
 <20161004094805.466ebc6d@jawa>
 <be9c9f6b22788ca4d9c9243a46932945@agner.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0461454752968917853=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <be9c9f6b22788ca4d9c9243a46932945@agner.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Agner <stefan@agner.ch>
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, l.majewski@samsung.com, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, thierry.reding@gmail.com, kernel@pengutronix.de, fabio.estevam@nxp.com, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

--===============0461454752968917853==
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/fc7ZTByV.E_+wg3czjqxszt"; protocol="application/pgp-signature"

--Sig_/fc7ZTByV.E_+wg3czjqxszt
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

> Hi Lukasz,
>=20
> On 2016-10-04 00:48, Lukasz Majewski wrote:
> > Dear Bhuvanchandra,
> >=20
> > Thank you for your effort to send those patches to ML.
> >=20
> >> Changes since v2:
> >>
> >> - Picked the stalled patchset[1] from Lothar Wassmann which adds
> >> the basic support for polarity control on imx-pwm driver and adds
> >> backward compatibility support for devices which does not have
> >> polarity control feature.
> >>
> >> Changes since Lothars v6:
> >>
> >> - Squash Lukasz patch[2].
> >>
> >> [1] http://thread.gmane.org/gmane.linux.pwm/1621
> >> [2] https://www.spinics.net/lists/arm-kernel/msg530818.html
> >>
> >> Bhuvanchandra DV (3):
> >>   arm: dts: imx7: Update #pwm-cells for PWM polarity control
> >>   arm: dts: imx7-colibri: Use pwm polarity control
> >>   arm: dts: imx7-colibri: Use enable-gpios for BL_ON
> >>
> >> Lothar Wassmann (3):
> >>   pwm: print error messages with pr_err() instead of pr_debug()
> >>   pwm: core: make the PWM_POLARITY flag in DTB optional
> >>   pwm: imx: support output polarity inversion
> >=20
> > For some reason this patchset works differently than the one
> > developed by Lothar.
> >=20
> > The difference is with the brightness level control.
> >=20
> > My brightness definition in DTS:
> >=20
> >            pwms =3D <&pwm2 0 5000000 PWM_POLARITY_INVERTED>;
> >=20
> >  		brightness-levels =3D <  0   1   2   3   4   5   6
> > 7   8   9
> >=20
> > 					 ..  ............
> > 				    250 251 252 253 254 255>;
> > 		default-brightness-level =3D <50>;
> > 		enable-gpios =3D <&gpio1 2 GPIO_ACTIVE_LOW>;
> >=20
>=20
> If you are using something else than i.MX 7 you also want to update
> the SoC level device tree, specifically change the pwm-cells property:
> #pwm-cells =3D <3>;

Good point. However, it is declared elsewhere (with pwm2 node)

&pwm2 {
	#pwm-cells =3D <3>;
	pinctrl-names =3D "default";
	pinctrl-0 =3D <&pinctrl_pwm2>;
	status =3D "okay";
};


>=20
>=20
> > When I go to the backlight sysfs entry:
> >=20
> > cd /sys/devices/soc0/backlight/backlight/backlight
> >=20
> > It seems like the brightness level control is inverted - i.e.=20
> > 'echo 20 > brightness" makes picture on the screen very bright, and=20
> > 'echo 200 > brightness' makes the picture diminish.
> >=20
> > With my "internal" patches the situation is opposite (and I've
> > checked it with my HW connections).
>=20
> Just to check whether the driver actually applies the polarity you can
> add a #define DEBUG at the top of the driver (drivers/pwm/pwm-imx.c)
> and pass ignore_loglevel as kernel command line. This should give you
> "PWM supports output inversion" at startup and a "... polarity set
> to .." message whenever the polarity is set.

The problem is with the Bhuvanchandra original patch.

I will point it out when replying to original patch.

Thanks for support,

=C5=81ukasz Majewski

>=20
> --
> Stefan
>=20
> >=20
> > Could you check on your setup if similar situation takes place? I
> > mean if the brightness control works as expected?
> >=20
> > Thanks in advance,
> > =C5=81ukasz Majewski
> >=20
> >>
> >>  Documentation/devicetree/bindings/pwm/imx-pwm.txt |  6 +--
> >>  arch/arm/boot/dts/imx7-colibri.dtsi               | 12 +++++-
> >>  arch/arm/boot/dts/imx7s.dtsi                      |  8 ++--
> >>  drivers/pwm/core.c                                | 31
> >> ++++++++------ drivers/pwm/pwm-imx.c                             |
> >> 51 +++++++++++++++++++++-- 5 files changed, 83 insertions(+), 25
> >> deletions(-)
> >>


--Sig_/fc7ZTByV.E_+wg3czjqxszt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlf17pAACgkQf9/hG2YwgjFtWQCgjnDuvLODUb3SDUMzpSvG4rcC
PgAAnAv/7rL08z0DXp715hDcZeVcwFbs
=igpo
-----END PGP SIGNATURE-----

--Sig_/fc7ZTByV.E_+wg3czjqxszt--


--===============0461454752968917853==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0461454752968917853==--
