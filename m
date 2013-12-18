From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCHv7 1/4] pwm: Add Freescale FTM PWM driver support
Date: Wed, 18 Dec 2013 06:28:34 +0000
Message-ID: <803c9e5db83b41ceb593441c5b452be9@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1386925027-16288-1-git-send-email-Li.Xiubo@freescale.com>
 <20131217111020.GF13823@ulmo.nvidia.com>
 <20131217115136.GT4360@n2100.arm.linux.org.uk> <5295539.cCkPY1PpyC@flatron>
 <20131217124505.GB17210@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20131217124505.GB17210@ulmo.nvidia.com>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Tomasz Figa <tomasz.figa@gmail.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "galak@codeaurora.org" <galak@codeaurora.org>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "t.figa@samsung.com" <t.figa@samsung.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "matt.porter@linaro.org" <matt.porter@linaro.org>, "rob@landley.net" <rob@landley.net>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Huan Wang <Huan.Wang@freescale.com>
List-Id: linux-pwm@vger.kernel.org


> On Tue, Dec 17, 2013 at 01:00:10PM +0100, Tomasz Figa wrote:
> > On Tuesday 17 of December 2013 11:51:36 Russell King - ARM Linux wrote:
> > > On Tue, Dec 17, 2013 at 12:10:22PM +0100, Thierry Reding wrote:
> > > > On Fri, Dec 13, 2013 at 04:57:04PM +0800, Xiubo Li wrote:
> > > > > +static inline u32 fsl_pwm_readl(struct fsl_pwm_chip *fpc,
> > > > > +		const void __iomem *addr)
> > > > > +{
> > > > > +	u32 val;
> > > > > +
> > > > > +	val = __raw_readl(addr);
> > > > > +
> > > > > +	if (likely(fpc->big_endian))
> > > >
> > > > The likely() probably isn't very useful in this case. But if you
> > > > want to keep it, it should at least be reversed, since
> > > > little-endian is actually the default (you have to specify the
> > > > big-endian property to activate the big endian mode).
> > > >
> > > > > +		val = be32_to_cpu(val);
> > > > > +	else
> > > > > +		val = le32_to_cpu(val);
> > >
> > > This will also cause sparse errors, because when sparse is enabled,
> > > these expect __le32 or __be32 arguments, not u32.
> >
> > My question is why can't you just create two sets of accessors, one
> > big endian and one little endian, add two function pointers to your
> > fsl_pwm_chip struct and let the driver set the to correct accessors in
> > probe?
> 
> I guess that would be one possibility.
>

Yes, that's one possibility.

If so, it must deference the function pointers and do the C stack push/pop stuff
every time when doing the accesses. For instance, but for some devices(USB, NET,
DMA..), we need to do many accesses every time in the frequent interrupt handler,
and I think the inline type functions will be more efficiency.

In LS-1 series platforms, there are many devices that need to do the same work like
this, and could these be moved to some global files ?


--
Xiubo
