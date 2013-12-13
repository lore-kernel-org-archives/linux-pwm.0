From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [RFCv2 endianess 1/4] pwm: Add Freescale FTM PWM driver support
Date: Fri, 13 Dec 2013 09:52:02 +0000
Message-ID: <51a162531bd447f7bf934018d0526fec@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1386309134-1822-1-git-send-email-Li.Xiubo@freescale.com>
 <1386309134-1822-2-git-send-email-Li.Xiubo@freescale.com>
 <04e52411558f44d99a603c288e2dcc50@BY2PR03MB505.namprd03.prod.outlook.com>
 <20131210101959.GE1809@e106331-lin.cambridge.arm.com>
 <e806828e7d4f488c88d7bd05bdd007d2@BY2PR03MB505.namprd03.prod.outlook.com>
 <d6985022e8aa4e21b618205ddf521d9f@BY2PR03MB505.namprd03.prod.outlook.com>
 <20131212124222.GK11524@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bn1blp0186.outbound.protection.outlook.com ([207.46.163.186]:15247
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751802Ab3LMJwM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Dec 2013 04:52:12 -0500
In-Reply-To: <20131212124222.GK11524@ulmo.nvidia.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "galak@codeaurora.org" <galak@codeaurora.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "matt.porter@linaro.org" <matt.porter@linaro.org>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "rob@landley.net" <rob@landley.net>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, Pawel Moll <Pawel.Moll@arm.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Huan Wang <Huan.Wang@freescale.com>, Jingchang Lu <jingchang.lu@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Thierry,

> I think perhaps what Mark may have meant was something like this:
> 
> 	static inline u32 fsl_pwm_readl(struct fsl_pwm_chip *fpc,
> 					const void __iomem *addr)
> 	{
> 		u32 value = readl(addr);
> 
> 		if (likely(fpc->big_endian))
> 			value = be32_to_cpu(value);
> 		else
> 			value = le32_to_cpu(value);
> 
> 		return value;
> 	}
> 
> 	static inline void fsl_pwm_writel(struct fsl_pwm_chip *fpc, u32 value,
> 					  const void __iomem *addr)
> 	{
> 		if (likely(fpc->big_endian))
> 			value = cpu_to_be32(value);
> 		else
> 			value = cpu_to_le32(value);
> 
> 		writel(value, addr);
> 	}
> 
> That way you call the accessors only once, and do the conversion after
> or before that.
> 

Yes, this looks better.
And I have already sent the v7 patches has addressed about this.

--
Xiubo
