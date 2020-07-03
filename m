From: "Alim Akhtar" <alim.akhtar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH v2 2/8] arm64: dts: exynos: Describe PWM interrupts on
 Exynos7
Date: Fri, 3 Jul 2020 22:40:09 +0530
Message-ID: <000001d6515c$d19f7de0$74de79a0$@samsung.com>
References: <20200702155149.12854-1-krzk@kernel.org>
        <CGME20200702155204epcas5p34d7635968376b68fc243e8887cf16388@epcas5p3.samsung.com>
        <20200702155149.12854-2-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200702155149.12854-2-krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Content-Language: en-in
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Krzysztof Kozlowski' <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, 'Thierry Reding' <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?utf-8?Q?'Uwe_Kleine-K=C3=B6nig'?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, 'Lee Jones' <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Rob Herring' <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, 'Kukjin Kim' <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: 'Marek Szyprowski' <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Bartlomiej Zolnierkiewicz' <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Sylwester Nawrocki' <snawrocki-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, 'Chanwoo Choi' <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Pankaj Dubey' <pankaj.dubey-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hi Krzysztof,

> -----Original Message-----
> From: Krzysztof Kozlowski <krzk=40kernel.org>
> Sent: 02 July 2020 21:22
> To: Thierry Reding <thierry.reding=40gmail.com>; Uwe Kleine-K=C3=B6nig=20=
<u.kleine-=0D=0A>=20koenig=40pengutronix.de>;=20Lee=20Jones=20<lee.jones=40=
linaro.org>;=20Rob=20Herring=0D=0A>=20<robh+dt=40kernel.org>;=20Kukjin=20Ki=
m=20<kgene=40kernel.org>;=20Krzysztof=20Kozlowski=0D=0A>=20<krzk=40kernel.o=
rg>;=20linux-pwm=40vger.kernel.org;=20devicetree=40vger.kernel.org;=0D=0A>=
=20linux-kernel=40vger.kernel.org;=20linux-arm-kernel=40lists.infradead.org=
;=20linux-=0D=0A>=20samsung-soc=40vger.kernel.org=0D=0A>=20Cc:=20Marek=20Sz=
yprowski=20<m.szyprowski=40samsung.com>;=20Bartlomiej=20Zolnierkiewicz=0D=
=0A>=20<b.zolnierkie=40samsung.com>;=20Sylwester=20Nawrocki=20<snawrocki=40=
kernel.org>;=0D=0A>=20Alim=20Akhtar=20<alim.akhtar=40samsung.com>;=20Chanwo=
o=20Choi=0D=0A>=20<cw00.choi=40samsung.com>;=20Pankaj=20Dubey=20<pankaj.dub=
ey=40samsung.com>=0D=0A>=20Subject:=20=5BPATCH=20v2=202/8=5D=20arm64:=20dts=
:=20exynos:=20Describe=20PWM=20interrupts=20on=0D=0A>=20Exynos7=0D=0A>=20=
=0D=0A>=20Add=20interrupts=20property=20to=20PWM=20node=20on=20Exynos7=20to=
=20describe=20the=20hardware=0D=0A>=20fully.=20=20No=20functional=20change=
=20as=20the=20interrupts=20are=20not=20used=20by=20drivers.=0D=0A>=20=0D=0A=
>=20Signed-off-by:=20Krzysztof=20Kozlowski=20<krzk=40kernel.org>=0D=0A>=20=
=0D=0AReviewed-by:=20Alim=20Akhtar=20<alim.akhtar=40samsung.com>=0D=0A>=20-=
--=0D=0A>=20=0D=0A>=20Changes=20since=20v1:=0D=0A>=201.=20Correct=20the=20i=
nterrupts,=20change=20message.=0D=0A>=20=0D=0A>=20Not=20tested=0D=0A>=20---=
=0D=0A>=20=20arch/arm64/boot/dts/exynos/exynos7.dtsi=20=7C=205=20+++++=0D=
=0A>=20=201=20file=20changed,=205=20insertions(+)=0D=0A>=20=0D=0A>=20diff=
=20--git=20a/arch/arm64/boot/dts/exynos/exynos7.dtsi=0D=0A>=20b/arch/arm64/=
boot/dts/exynos/exynos7.dtsi=0D=0A>=20index=20f590891efe25..709742b98c9c=20=
100644=0D=0A>=20---=20a/arch/arm64/boot/dts/exynos/exynos7.dtsi=0D=0A>=20++=
+=20b/arch/arm64/boot/dts/exynos/exynos7.dtsi=0D=0A>=20=40=40=20-581,6=20+5=
81,11=20=40=40=0D=0A>=20=20=09=09pwm:=20pwm=40136c0000=20=7B=0D=0A>=20=20=
=09=09=09compatible=20=3D=20=22samsung,exynos4210-pwm=22;=0D=0A>=20=20=09=
=09=09reg=20=3D=20<0x136c0000=200x100>;=0D=0A>=20+=09=09=09interrupts=20=3D=
=20<GIC_SPI=20449=20IRQ_TYPE_LEVEL_HIGH>,=0D=0A>=20+=09=09=09=09=20=20=20=
=20=20<GIC_SPI=20450=20IRQ_TYPE_LEVEL_HIGH>,=0D=0A>=20+=09=09=09=09=20=20=
=20=20=20<GIC_SPI=20451=20IRQ_TYPE_LEVEL_HIGH>,=0D=0A>=20+=09=09=09=09=20=
=20=20=20=20<GIC_SPI=20452=20IRQ_TYPE_LEVEL_HIGH>,=0D=0A>=20+=09=09=09=09=
=20=20=20=20=20<GIC_SPI=20453=20IRQ_TYPE_LEVEL_HIGH>;=0D=0A>=20=20=09=09=09=
samsung,pwm-outputs=20=3D=20<0>,=20<1>,=20<2>,=20<3>;=0D=0A>=20=20=09=09=09=
=23pwm-cells=20=3D=20<3>;=0D=0A>=20=20=09=09=09clocks=20=3D=20<&clock_peric=
0=20PCLK_PWM>;=0D=0A>=20--=0D=0A>=202.17.1=0D=0A=0D=0A=0D=0A
