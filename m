From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCHv7 1/4] pwm: Add Freescale FTM PWM driver support
Date: Tue, 17 Dec 2013 13:45:06 +0100
Message-ID: <20131217124505.GB17210@ulmo.nvidia.com>
References: <1386925027-16288-1-git-send-email-Li.Xiubo@freescale.com>
 <20131217111020.GF13823@ulmo.nvidia.com>
 <20131217115136.GT4360@n2100.arm.linux.org.uk>
 <5295539.cCkPY1PpyC@flatron>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8568395196581078842=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5295539.cCkPY1PpyC@flatron>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, ian.campbell@citrix.com, pawel.moll@arm.com, swarren@wwwdotorg.org, s.hauer@pengutronix.de, linux-doc@vger.kernel.org, Alison Wang <b18965@freescale.com>, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, Jingchang Lu <b35083@freescale.com>, devicetree@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>, rob@landley.net, galak@codeaurora.org, grant.likely@linaro.org, matt.porter@linaro.org, t.figa@samsung.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


--===============8568395196581078842==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2013 at 01:00:10PM +0100, Tomasz Figa wrote:
> On Tuesday 17 of December 2013 11:51:36 Russell King - ARM Linux wrote:
> > On Tue, Dec 17, 2013 at 12:10:22PM +0100, Thierry Reding wrote:
> > > On Fri, Dec 13, 2013 at 04:57:04PM +0800, Xiubo Li wrote:
> > > > +static inline u32 fsl_pwm_readl(struct fsl_pwm_chip *fpc,
> > > > +		const void __iomem *addr)
> > > > +{
> > > > +	u32 val;
> > > > +
> > > > +	val =3D __raw_readl(addr);
> > > > +
> > > > +	if (likely(fpc->big_endian))
> > >=20
> > > The likely() probably isn't very useful in this case. But if you want=
 to
> > > keep it, it should at least be reversed, since little-endian is actua=
lly
> > > the default (you have to specify the big-endian property to activate =
the
> > > big endian mode).
> > >=20
> > > > +		val =3D be32_to_cpu(val);
> > > > +	else
> > > > +		val =3D le32_to_cpu(val);
> >=20
> > This will also cause sparse errors, because when sparse is enabled, the=
se
> > expect __le32 or __be32 arguments, not u32.
>=20
> My question is why can't you just create two sets of accessors, one big
> endian and one little endian, add two function pointers to your
> fsl_pwm_chip struct and let the driver set the to correct accessors in
> probe?

I guess that would be one possibility.

> This would eliminate the problem with types Russell mentioned and IMHO
> make the code cleaner.

I fail to see how that would eliminate the problem with the types. That
said I don't actually see sparse complaining about any type mismatches.
That's probably because the various macros implicitly cast to u32.

> > > > +	rmb();
> > >=20
> > > I'd prefer the rmb() to follow the __raw_readl() immediately to make =
the
> > > relationship more explicit.
> >=20
> > A better question to ask is: why is this barrier here?  What memory
> > ordering operations is it trying to serialise?
>=20
> I'd also add a question why __raw accessors are used here.

Because both readl() and writel() explicitly perform little endian
accesses.

Thierry

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsEdRAAoJEN0jrNd/PrOh0xoP/j0OLAvMHLjIxHq3NXCojZIq
lLrJ2v2mBb8BCLxoLMIIaMcczUcizuohtkIO2b9M2cQ6/rdcI1cqQPkKiTdwtWop
6jCCmJFQ8eEK/Vns3WNhfRQhZcuRvPc8zp6gv44L/Ffd3x/NX1DiUZ+P00vkUFWR
WK8B/lmufzPC3NLXw8K9heOoUdNz0FGD+g1O3k952LPeQYpvAKGE+zieP7tkRxNm
quFiDWJzInI0ci9X9c+rtSo64RGogY6+EMs6yNAD40zZiQ7z8ZxsXo7yIDD7EtZQ
JSF1B4X/8Ubo/F1m/BlaxPrc1AD1sIdH2GmNp1+vlpCK7RFkIcHIqpMmFBLN2Xme
ivkopOHrt8BGeBngFQTZx5+wYE3pUJLmVLxWFl4ZhfVBzflFihhmMQCHIbcwrd/h
9LE5pjZjb2El0a1uLJZGRHf9TTwONU/lUbGJONVqDPPjqItaqDOE6xz/zRDLsy4B
OZ/prE6MusMqm3I3VtV6iVPzKKldSc8i3BvsBzVBB3r6f1lZfkdRr5hjBgPqJKss
8hvp1Ck34dNIKF7ri7QoAK9tTCyt+tmehkz35Wo3yNf0U23fHgDGSjRpIRKJIxl1
anFq+zbCyp7zRkFg222sAUcxjo8B8yM04jxrKHQi+Su4Ba6ErxllFh/cu2ThcJAq
E9lg/nFoMKUSNOYEKZC4
=nALP
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--


--===============8568395196581078842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8568395196581078842==--
