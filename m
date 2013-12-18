From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCHv7 1/4] pwm: Add Freescale FTM PWM driver support
Date: Wed, 18 Dec 2013 09:43:51 +0000
Message-ID: <2e498771546543f18329d2c2e69a6e35@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1386925027-16288-1-git-send-email-Li.Xiubo@freescale.com>
 <5295539.cCkPY1PpyC@flatron> <20131217124505.GB17210@ulmo.nvidia.com>
 <1500339.E8bGm7xZUi@flatron> <20131217130435.GV4360@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20131217130435.GV4360@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tomasz Figa <tomasz.figa@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "galak@codeaurora.org" <galak@codeaurora.org>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "t.figa@samsung.com" <t.figa@samsung.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "matt.porter@linaro.org" <matt.porter@linaro.org>, "rob@landley.net" <rob@landley.net>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel>
List-Id: linux-pwm@vger.kernel.org


> On Tue, Dec 17, 2013 at 01:54:35PM +0100, Tomasz Figa wrote:
> > On Tuesday 17 of December 2013 13:45:06 Thierry Reding wrote:
> > > I fail to see how that would eliminate the problem with the types.
> > > That said I don't actually see sparse complaining about any type
> mismatches.
> > > That's probably because the various macros implicitly cast to u32.
> >
> > Well, in BE variant you would read the register using __raw_readl()
> > into a __be32 and then get an u32 from be32_to_cpu() and return it.
> > Similarly for writes
> 
> __raw_readl() returns a u32, so you'll get a warning trying to assign a
> u32 to a __be32.
> 

If all are ok about this method.
How about the following:

+static inline u32 fsl_pwm_readl(struct fsl_pwm_chip *fpc,
+                               const void __iomem *addr)
+{
+       u32 val;
+
+       val = __raw_readl(addr);
+
+       if (likely(fpc->big_endian))
+               val = be32_to_cpu((__force __be32)val);
+       else
+               val = le32_to_cpu((__force __le32)val);
+       rmb();
+
+       return val;
+}
+
+static inline void fsl_pwm_writel(struct fsl_pwm_chip *fpc,
+                               u32 val, void __iomem *addr)
+{
+       wmb();
+       if (likely(fpc->big_endian))
+               val = (__force u32)cpu_to_be32(val);
+       else
+               val = (__force u32)cpu_to_le32(val);
+
+       __raw_writel(val, addr);
+}

Best Regards,
Xiubo
