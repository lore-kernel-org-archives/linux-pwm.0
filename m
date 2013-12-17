From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCHv7 1/4] pwm: Add Freescale FTM PWM driver support
Date: Tue, 17 Dec 2013 13:54:35 +0100
Message-ID: <1500339.E8bGm7xZUi@flatron>
References: <1386925027-16288-1-git-send-email-Li.Xiubo@freescale.com> <5295539.cCkPY1PpyC@flatron> <20131217124505.GB17210@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20131217124505.GB17210@ulmo.nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Xiubo Li <Li.Xiubo@freescale.com>, mark.rutland@arm.com, s.hauer@pengutronix.de, galak@codeaurora.org, swarren@wwwdotorg.org, t.figa@samsung.com, grant.likely@linaro.org, matt.porter@linaro.org, rob@landley.net, ian.campbell@citrix.com, pawel.moll@arm.com, rob.herring@calxeda.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Alison Wang <b18965@freescale.com>, Jingchang Lu <b35083@freescale.com>
List-Id: linux-pwm@vger.kernel.org

On Tuesday 17 of December 2013 13:45:06 Thierry Reding wrote:
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
> > > > The likely() probably isn't very useful in this case. But if you want to
> > > > keep it, it should at least be reversed, since little-endian is actually
> > > > the default (you have to specify the big-endian property to activate the
> > > > big endian mode).
> > > > 
> > > > > +		val = be32_to_cpu(val);
> > > > > +	else
> > > > > +		val = le32_to_cpu(val);
> > > 
> > > This will also cause sparse errors, because when sparse is enabled, these
> > > expect __le32 or __be32 arguments, not u32.
> > 
> > My question is why can't you just create two sets of accessors, one big
> > endian and one little endian, add two function pointers to your
> > fsl_pwm_chip struct and let the driver set the to correct accessors in
> > probe?
> 
> I guess that would be one possibility.
> 
> > This would eliminate the problem with types Russell mentioned and IMHO
> > make the code cleaner.
> 
> I fail to see how that would eliminate the problem with the types. That
> said I don't actually see sparse complaining about any type mismatches.
> That's probably because the various macros implicitly cast to u32.

Well, in BE variant you would read the register using __raw_readl() into
a __be32 and then get an u32 from be32_to_cpu() and return it. Similarly
for writes

In LE variant, readl()/writel() could be used directly.

> 
> > > > > +	rmb();
> > > > 
> > > > I'd prefer the rmb() to follow the __raw_readl() immediately to make the
> > > > relationship more explicit.
> > > 
> > > A better question to ask is: why is this barrier here?  What memory
> > > ordering operations is it trying to serialise?
> > 
> > I'd also add a question why __raw accessors are used here.
> 
> Because both readl() and writel() explicitly perform little endian
> accesses.

Right. Thanks for pointing this out.

Best regards,
Tomasz

