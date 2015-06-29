From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 2/2] pwm: add MediaTek display PWM driver support
Date: Mon, 29 Jun 2015 11:27:27 +0200
Message-ID: <20150629092726.GG5431@ulmo>
References: <1432214964-40644-1-git-send-email-yh.huang@mediatek.com>
 <1432214964-40644-3-git-send-email-yh.huang@mediatek.com>
 <20150612102046.GF19400@ulmo.nvidia.com>
 <1434622784.18278.39.camel@mtksdaap41>
 <1434635939.22029.7.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p7qwJlK53pWzbayA"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1434635939.22029.7.camel@mtksdaap41>
Sender: linux-kernel-owner@vger.kernel.org
To: Yingjoe Chen <yingjoe.chen@mediatek.com>
Cc: YH Huang <yh.huang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-pwm@vger.kernel.org


--p7qwJlK53pWzbayA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2015 at 09:58:59PM +0800, Yingjoe Chen wrote:
> On Thu, 2015-06-18 at 18:19 +0800, YH Huang wrote:
> > On Fri, 2015-06-12 at 12:20 +0200, Thierry Reding wrote:
> > > > +/* Shift log2(PWM_PERIOD_MAX + 1) as divisor */
> > > > +#define PWM_PERIOD_BIT_SHIFT	12
> > >=20
> > > I wasn't very clear about this in my earlier review, so let me try to
> > > explain why I think this is confusing. You use this as a divisor, but
> > > you encode it as a shift. It's also PWM_PERIOD_MAX + 1, so I think it
> > > would make more sense to drop this, keep PWM_PERIOD_MAX as above and
> > > then replace the
> > >=20
> > > 	>> PWM_PERIOD_BIT_SHIFT
> > > =09
> > > below by
> > >=20
> > > 	/ (PWM_PERIOD_MAX + 1)
> > >=20
> >=20
> > Maybe I can change in this way:
> > Remove this: #define PWM_PERIOD_MAX		0x00000fff
> > Using ">> PWM_PERIOD_BIT_SHIFT" is faster than "/ (PWM_PERIOD_MAX + 1)"
> > Is this right?
>=20
>=20
> The place which use this shift is:
>=20
> 	clk_div =3D div_u64(rate * period_ns, NSEC_PER_SEC) >>=20
> 			  PWM_PERIOD_BIT_SHIFT;
>=20
> div_u64 return u64. If we change >> to /, and somehow compiler didn't
> optimize that div into shift, it will cause build error.

Good point. I think every compiler should be able to optimize this, but
the shift isn't any worse than a divide and if we can proactively avoid
portability issues, let's go with the shift.

Thierry

--p7qwJlK53pWzbayA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVkQ9+AAoJEN0jrNd/PrOh+iIQAIhgolN7CJuG/ZbsVU3yt1c3
hluX+91cPqiXA2Djlp+4iDIyqR+Ozszdz35F6Akg3bhIiYBgddg/yIl8/a0rE1Fg
MgPyWUEBR3rtANDrhDt89Qz6zawTnkvn8nIq6i7ureHQgQ+C378QNSxz5LAbjHTt
Xe5Ob9sai39iHy62FmLTRDYjVQ+0A+xSL4oZkSLM/+GOUqjmqzfAf4BOdgn5iiJA
8YnnwrnsTbQKSGSYu+IyhhLUyqbgKfUDI5BzDHR3exuNzs9XDXOH7jGrvV7DtH9X
D88tNtDaZIxeEVY/1ICQss3mfhyfzrgaU5X2CLl+XaZgBLvnGdyI640Y03Z3GrLB
grM8HdeGqxmb/ulGCvtZW8dHL5sKLPWfXLcAfGMSKGON1m04f6jng1QT8CO4axDf
uDHtOjvkNoFKHss1ZPt8/Aaoy/Om5WVBVCLrA0XDKl4HiGqUbnc/se5HC0J3VAwu
ieVytw796++H+zyLiEnbzYi79vpLsEqE+iyI1RyegDfK1Ug4whtbHLZ6/Zmn/zBi
zzrut7D0GuwDNWlrpBG6PsIOr/m2IrMxHyk6urA2tMXOiq+4o+0jjhJbUekyezl0
pSACPptjxj0Ujw9+QZbiRS4In6wAiejqQab0pHVpjVrNL0ZVBY2NORGdYi/qHcu3
xffZQulegpUN9G+3DSJy
=nfFS
-----END PGP SIGNATURE-----

--p7qwJlK53pWzbayA--
