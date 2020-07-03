From: "Alim Akhtar" <alim.akhtar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH v2 3/8] arm64: dts: exynos: Remove generic
 arm,armv8-pmuv3 compatible
Date: Fri, 3 Jul 2020 22:47:58 +0530
Message-ID: <000101d6515d$e91f2870$bb5d7950$@samsung.com>
References: <20200702155149.12854-1-krzk@kernel.org>
        <CGME20200702155208epcas5p3b392837ed0d7183aa8d8724b1ccac9aa@epcas5p3.samsung.com>
        <20200702155149.12854-3-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200702155149.12854-3-krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Content-Language: en-in
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Krzysztof Kozlowski' <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, 'Thierry Reding' <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?utf-8?Q?'Uwe_Kleine-K=C3=B6nig'?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, 'Lee Jones' <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Rob Herring' <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, 'Kukjin Kim' <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: 'Marek Szyprowski' <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Bartlomiej Zolnierkiewicz' <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Sylwester Nawrocki' <snawrocki-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, 'Chanwoo Choi' <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Pankaj Dubey' <pankaj.dubey-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

HI Krzysztof

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
ey=40samsung.com>=0D=0A>=20Subject:=20=5BPATCH=20v2=203/8=5D=20arm64:=20dts=
:=20exynos:=20Remove=20generic=20arm,armv8-pmuv3=0D=0A>=20compatible=0D=0A>=
=20=0D=0A>=20The=20ARM=20PMU=20node=20is=20described=20enough=20with=20firs=
t=20compatible=20so=20remove=20the=0D=0A>=20arm,armv8-pmuv3=20to=20fix=20dt=
schema=20warnings=20like:=0D=0A>=20=0D=0A>=20=20=20=20=20arm-pmu:=20compati=
ble:=20Additional=20items=20are=20not=20allowed=20('arm,armv8-pmuv3'=0D=0A>=
=20was=20unexpected)=0D=0A>=20=20=20=20=20arm-pmu:=20compatible:=20=5B'arm,=
cortex-a57-pmu',=20'arm,armv8-pmuv3'=5D=20is=20too=20long=0D=0A>=20=0D=0A>=
=20Signed-off-by:=20Krzysztof=20Kozlowski=20<krzk=40kernel.org>=0D=0A>=20=
=0D=0AReviewed-by:=20Alim=20Akhtar=20<alim.akhtar=40samsung.com>=0D=0A>=20-=
--=0D=0A>=20=0D=0A>=20Changes=20since=20v1:=0D=0A>=201.=20None=0D=0A>=20=0D=
=0A>=20Not=20tested=20although=20no=20effect=20expected.=0D=0A>=20---=0D=0A=
Booted=20on=20exynos7=20board=20and=20see=20arm=20PMU=20still=20gets=20regi=
stered=0D=0ATested-by:=20Alim=20Akhtar=20<alim.akhtar=40samsung.com>=0D=0A=
=0D=0A=0D=0A
