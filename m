From: "Alim Akhtar" <alim.akhtar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH v2 4/8] arm64: dts: exynos: Remove DMA controller bus
 node name to fix dtschema warnings
Date: Fri, 3 Jul 2020 22:53:04 +0530
Message-ID: <000201d6515e$9f7a33d0$de6e9b70$@samsung.com>
References: <20200702155149.12854-1-krzk@kernel.org>
        <CGME20200702155211epcas5p1bcbcd489b250d3e66a8022c5c4e429ba@epcas5p1.samsung.com>
        <20200702155149.12854-4-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200702155149.12854-4-krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Content-Language: en-in
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Krzysztof Kozlowski' <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, 'Thierry Reding' <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?utf-8?Q?'Uwe_Kleine-K=C3=B6nig'?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, 'Lee Jones' <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Rob Herring' <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, 'Kukjin Kim' <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: 'Marek Szyprowski' <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Bartlomiej Zolnierkiewicz' <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Sylwester Nawrocki' <snawrocki-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, 'Chanwoo Choi' <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Pankaj Dubey' <pankaj.dubey-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hi Krzysztof

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
ey=40samsung.com>=0D=0A>=20Subject:=20=5BPATCH=20v2=204/8=5D=20arm64:=20dts=
:=20exynos:=20Remove=20DMA=20controller=20bus=20node=0D=0A>=20name=20to=20f=
ix=20dtschema=20warnings=0D=0A>=20=0D=0A>=20There=20is=20no=20need=20to=20k=
eep=20DMA=20controller=20nodes=20under=20AMBA=20bus=20node.=0D=0A>=20Remove=
=20the=20=22amba=22=20node=20to=20fix=20dtschema=20warnings=20like:=0D=0A>=
=20=0D=0A>=20=20=20=20=20amba:=20=24nodename:0:=20'amba'=20does=20not=20mat=
ch=20'=5E(bus=7Csoc=7Caxi=7Cahb=7Capb)(=40=5B0-=0D=0A>=209a-f=5D+)?=24'=0D=
=0A>=20=0D=0A>=20Signed-off-by:=20Krzysztof=20Kozlowski=20<krzk=40kernel.or=
g>=0D=0A>=20=0D=0AReviewed-by:=20Alim=20Akhtar=20<alim.akhtar=40samsung.com=
>=0D=0A>=20---=0D=0A>=20=0D=0A>=20Changes=20since=20v1:=0D=0A>=201.=20Remov=
e=20the=20bus,=20as=20suggested=20by=20Marek=0D=0A>=20---=0D=0A>=20=20arch/=
arm64/boot/dts/exynos/exynos5433.dtsi=20=7C=2047=20+++++++++-------------=
=0D=0A>=20=20arch/arm64/boot/dts/exynos/exynos7.dtsi=20=20=20=20=7C=2047=20=
+++++++++-------------=0D=0A>=20=202=20files=20changed,=2040=20insertions(+=
),=2054=20deletions(-)=0D=0A=0D=0A=0D=0A
