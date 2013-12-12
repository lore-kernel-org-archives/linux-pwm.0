From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [RFCv2 endianess 1/4] pwm: Add Freescale FTM PWM driver support
Date: Thu, 12 Dec 2013 02:43:14 +0000
Message-ID: <d6985022e8aa4e21b618205ddf521d9f@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1386309134-1822-1-git-send-email-Li.Xiubo@freescale.com>
 <1386309134-1822-2-git-send-email-Li.Xiubo@freescale.com>
 <04e52411558f44d99a603c288e2dcc50@BY2PR03MB505.namprd03.prod.outlook.com>
 <20131210101959.GE1809@e106331-lin.cambridge.arm.com>
 <e806828e7d4f488c88d7bd05bdd007d2@BY2PR03MB505.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bl2lp0211.outbound.protection.outlook.com ([207.46.163.211]:47600
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750945Ab3LLCn3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Dec 2013 21:43:29 -0500
In-Reply-To: <e806828e7d4f488c88d7bd05bdd007d2@BY2PR03MB505.namprd03.prod.outlook.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "galak@codeaurora.org" <galak@codeaurora.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "matt.porter@linaro.org" <matt.porter@linaro.org>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "rob@landley.net" <rob@landley.net>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, Pawel Moll <Pawel.Moll@arm.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Huan Wang <Huan.Wang@freescale.com>, "jingchang.lu@freescale.com" <jingchang.lu@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Mark,


> > > > +static inline u32 fsl_pwm_readl(struct fsl_pwm_chip *fpc,
> > > > +             const void __iomem *addr)
> > > > +{
> > > > +     if (likely(fpc->big_endian))
> > > > +             return ioread32be(addr);
> > > > +     else
> > > > +             return readl(addr);
> > > > +}
> >
> > It looks a little odd to to have two different accessors here.
> >
> > Could these not be unified somehow?
> >
> 
> How about the following :
> 
> +static inline u32 fsl_pwm_readl(struct fsl_pwm_chip *fpc,
> +			const void __iomem *addr)
> +{
> +	u32 val;
> +
> +	if (likely(fpc->big_endian))
> +		val = be32_to_cpu(__raw_readl(addr));
> +	else
> +		val = le32_to_cpu(__raw_readl(addr));
> +
> +	rmb();
> +
> +	return val;
> +}
> +
> +static inline void fsl_pwm_writel(struct fsl_pwm_chip *fpc,
> +			u32 val, void __iomem *addr)
> +{
> +	wmb();
> +
> +	if (likely(fpc->big_endian))
> +		__raw_writel(cpu_to_be32(val), addr);
> +	else
> +		__raw_writel(cpu_to_le32(val), addr);
> +}
> +
> 
> 

Or, will these be much better ?
+++++++++++
+static inline u32 fsl_pwm_readl(struct fsl_pwm_chip *fpc,
+		const void __iomem *addr)
+{
+	u32 val;
+
+	if (likely(fpc->big_endian))
+		val = be32_to_cpu((__force __be32)__raw_readl(addr));
+	else
+		val = le32_to_cpu((__force __le32)__raw_readl(addr));
+
+	rmb();
+
+	return val;
+}
+
+static inline void fsl_pwm_writel(struct fsl_pwm_chip *fpc,
+		u32 val, void __iomem *addr)
+{
+	wmb();
+
+	if (likely(fpc->big_endian))
+		__raw_writel((__force u32)cpu_to_be32(val), addr);
+	else
+		__raw_writel((__force u32)cpu_to_le32(val), addr); }
+
-----------


Thanks,
--
Xiubo

