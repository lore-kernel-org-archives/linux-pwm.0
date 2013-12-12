From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFCv2 endianess 1/4] pwm: Add Freescale FTM PWM driver support
Date: Thu, 12 Dec 2013 13:42:23 +0100
Message-ID: <20131212124222.GK11524@ulmo.nvidia.com>
References: <1386309134-1822-1-git-send-email-Li.Xiubo@freescale.com>
 <1386309134-1822-2-git-send-email-Li.Xiubo@freescale.com>
 <04e52411558f44d99a603c288e2dcc50@BY2PR03MB505.namprd03.prod.outlook.com>
 <20131210101959.GE1809@e106331-lin.cambridge.arm.com>
 <e806828e7d4f488c88d7bd05bdd007d2@BY2PR03MB505.namprd03.prod.outlook.com>
 <d6985022e8aa4e21b618205ddf521d9f@BY2PR03MB505.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ah40dssYA/cDqAW1"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:59036 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476Ab3LLMnj (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Dec 2013 07:43:39 -0500
Content-Disposition: inline
In-Reply-To: <d6985022e8aa4e21b618205ddf521d9f@BY2PR03MB505.namprd03.prod.outlook.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "galak@codeaurora.org" <galak@codeaurora.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "matt.porter@linaro.org" <matt.porter@linaro.org>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "rob@landley.net" <rob@landley.net>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, Pawel Moll <Pawel.Moll@arm.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Huan Wang <Huan.Wang@freescale.com>, "jingchang.lu@freescale.com" <jingchang.lu@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


--Ah40dssYA/cDqAW1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2013 at 02:43:14AM +0000, Li.Xiubo@freescale.com wrote:
> Hi Mark,
>=20
>=20
> > > > > +static inline u32 fsl_pwm_readl(struct fsl_pwm_chip *fpc,
> > > > > +             const void __iomem *addr)
> > > > > +{
> > > > > +     if (likely(fpc->big_endian))
> > > > > +             return ioread32be(addr);
> > > > > +     else
> > > > > +             return readl(addr);
> > > > > +}
> > >
> > > It looks a little odd to to have two different accessors here.
> > >
> > > Could these not be unified somehow?
> > >
> >=20
> > How about the following :
> >=20
> > +static inline u32 fsl_pwm_readl(struct fsl_pwm_chip *fpc,
> > +			const void __iomem *addr)
> > +{
> > +	u32 val;
> > +
> > +	if (likely(fpc->big_endian))
> > +		val =3D be32_to_cpu(__raw_readl(addr));
> > +	else
> > +		val =3D le32_to_cpu(__raw_readl(addr));
> > +
> > +	rmb();
> > +
> > +	return val;
> > +}
> > +
> > +static inline void fsl_pwm_writel(struct fsl_pwm_chip *fpc,
> > +			u32 val, void __iomem *addr)
> > +{
> > +	wmb();
> > +
> > +	if (likely(fpc->big_endian))
> > +		__raw_writel(cpu_to_be32(val), addr);
> > +	else
> > +		__raw_writel(cpu_to_le32(val), addr);
> > +}
> > +
> >=20
> >=20
>=20
> Or, will these be much better ?
> +++++++++++
> +static inline u32 fsl_pwm_readl(struct fsl_pwm_chip *fpc,
> +		const void __iomem *addr)
> +{
> +	u32 val;
> +
> +	if (likely(fpc->big_endian))
> +		val =3D be32_to_cpu((__force __be32)__raw_readl(addr));
> +	else
> +		val =3D le32_to_cpu((__force __le32)__raw_readl(addr));
> +
> +	rmb();
> +
> +	return val;
> +}
> +
> +static inline void fsl_pwm_writel(struct fsl_pwm_chip *fpc,
> +		u32 val, void __iomem *addr)
> +{
> +	wmb();
> +
> +	if (likely(fpc->big_endian))
> +		__raw_writel((__force u32)cpu_to_be32(val), addr);
> +	else
> +		__raw_writel((__force u32)cpu_to_le32(val), addr); }
> +
> -----------

I think perhaps what Mark may have meant was something like this:

	static inline u32 fsl_pwm_readl(struct fsl_pwm_chip *fpc,
					const void __iomem *addr)
	{
		u32 value =3D readl(addr);

		if (likely(fpc->big_endian))
			value =3D be32_to_cpu(value);
		else
			value =3D le32_to_cpu(value);

		return value;
	}

	static inline void fsl_pwm_writel(struct fsl_pwm_chip *fpc, u32 value,
					  const void __iomem *addr)
	{
		if (likely(fpc->big_endian))
			value =3D cpu_to_be32(value);
		else
			value =3D cpu_to_le32(value);

		writel(value, addr);
	}

That way you call the accessors only once, and do the conversion after
or before that.

Thierry

--Ah40dssYA/cDqAW1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSqa8uAAoJEN0jrNd/PrOhBJoP/2U09Y+/CKNacy4XwyehffmI
0iEU/w0Qxd+B6QVhAVtQ3XbT+RAdnlwrmn1woTHZz44YB/cU/m8d+RS4XPzbKZlf
M/400/TznnTeweF6qrbPIpl372h7qyyx80BH/Nueesh8iFfvWVGC6qph/o6iiy08
jAu1pmXBFNA3GExy0EbRAlPv2dMPPAQfOOBUPvX98uQHEIbzC3D7G7eywRDGfypi
zKcndn312VAYD0mrxD/sRybGD1aib5GD1pSUqxnxz/uY3YLNMfT/MRKccDOlPp0x
YVaYdbbxXwiR3zX56hHoAKdDOZfc7uNToIfpcyqO+lSfQnpz2CKjmFQg4xpY270C
v8/y+Vv4JFkkUB00Cd1BjOHQOyNJbDggRpi2mygKnePqG5rT/wFLRnBT6C5KzOCv
RDsz2n4nhoSd7cMtmLdWM7dKJp4KaXMypwjyiTnYlrc8rLIMLojpTzfnfqTwTHan
cInWuR86Uly35LqZeJxNdn0lySY2/JfmrVvQEA+RHnsTc/TnG2rRylNf2RBSBNO8
rkoTiAfpLA05wdq6AYQBtSjiqdzJx8Rjt+9QuB3AirS/yVDuDVSLXvVSNzcBO+w0
ZOlNe2vbBGLhJIRNU0VBRztJ0tX23xW8ouHYzt0ESQR6gQoEyAxs6Aojrm/WHz3y
93KPD0TvvKH6IHMbb6YC
=W72D
-----END PGP SIGNATURE-----

--Ah40dssYA/cDqAW1--
