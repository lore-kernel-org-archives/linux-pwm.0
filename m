Date: Mon, 24 Jun 2013 19:49:04 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 11/18] pwm: Add new pwm-samsung driver
Message-ID: <20130624174903.GA6795@mithrandir>
References: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com>
 <1371766383-29077-12-git-send-email-tomasz.figa@gmail.com>
 <2925617.TjWXJcIKRC@flatron>
 <51C86442.6090406@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <51C86442.6090406@samsung.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2013 at 12:22:42AM +0900, Kukjin Kim wrote:
> On 06/22/13 22:06, Tomasz Figa wrote:
> >This patch introduces new Samsung PWM driver, which is heavily cleaned,
> >multiplatform aware and supports DeviceTree based instantiation.
> >
> >Since on historical hardware PWM block can be shared with clocksource
> >driver, a shared spinlock is used to protect access to shared registers,
> >already exported from the clocksource driver.
> >
> >Signed-off-by: Tomasz Figa<tomasz.figa@gmail.com>
> >---
> >  drivers/pwm/Makefile      |   1 +
> >  drivers/pwm/pwm-samsung.c | 601 ++++++++++++++++++++++++++++++++++++++=
++++++++
> >  2 files changed, 602 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-samsung.c
> >
> >Changes since v2:
> >  - Replaced __raw_{readl,writel} with {readl,writel}.
> >  - Corrected commit message.
> >
>=20
> [...]
>=20
> >+	of_property_for_each_u32(np, "samsung,pwm-outputs", prop, cur, val) {
> >+		if (val>=3D SAMSUNG_PWM_NUM) {
> >+			pr_warning("%s: invalid channel index in samsung,pwm-outputs propert=
y\n",
>=20
> Just note, checkpatch complains following, so fixed to use pr_warn()
> when I applied.

Note that you can't apply patches that touch the PWM tree without my Ack
and I already mentioned that the current way this driver is written
isn't acceptable.

So either you fix it properly, or if everybody except me thinks we don't
need a proper design for drivers anymore, then the only way I'll accept
this driver into the PWM tree is if you put a really big comment at the
top of the file saying that the driver is badly designed on purpose and
that people shouldn't be using it as a reference.

Thierry

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRyIaPAAoJEN0jrNd/PrOhbvsP/0S0Mw+DRFjcPW8qf5TH0C5s
icCeeHYBMF+c4Mcsv0Vxjfgzd0taW4FPr6A/yeZOVlor/dIWV4xcaa7960QP3Ajs
Cj6tuYaSC+L01SA57trukb9A+fM6IZ1fpv6p8ehM0gj0YJ7duvc3P32xPJ3PTH/V
e5q084d1xc7uOkAapaxZYwe5a1B8kz6fWs6rXSsuq6dSAff/r94iFODHwxnpNOL4
3DfTOCrZDK5sZNF7u/wq/l7xHctJIdhgy+aBORei+k0uSWhUW8WfNIv5YMC72Mt5
0UhzKh2jBe7JRCv4jLalwbQu9RN95DeeSNEQUANB8Z/Gad+xbuFrWAxWLVCbjdK+
5XIVPmBwB01bZs4RTgxBP9ZKMhx1miP/FMUP2/iuKncTg4c+QrMjUAc/+laFVvsW
Qv9qCZ6SiykMxiYgiosp078FAX68Po+WHq6KMemAZTrIpW8nDT+G0ntwrJ78IlF0
0N91W0WY8z2I/aVrpMPMqoDnSP1ZbG2l8LwK05sYXxDjxwOPOf4wfMaWUCRkcmiT
Cjc93YshDO3zyAqvu8oEU3u+eZaSvEq+lVL+QDTVRMZAI4wlrqp+p+Dyz3QTG0xn
uh2lIixIUGDRcjjwnc6V/5KX2ozaNkz6RE3pDeo9uC+D6e3kgyJz2Vjl4k1VkGQP
tty0NU/t07fXGyiuF+BS
=0inD
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
