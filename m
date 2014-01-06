From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCHv8 1/4] pwm: Add Freescale FTM PWM driver support
Date: Mon, 6 Jan 2014 07:39:13 +0000
Message-ID: <4966a79fc25647708b90d83295ffa1d8@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1388656624-26570-1-git-send-email-Li.Xiubo@freescale.com>
 <3716216.GQHQhxMFvx@wuerfel>
 <bb5e14370ddb4ce2921140d147244097@BY2PR03MB505.namprd03.prod.outlook.com>
 <201401031350.59447.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-by2lp0244.outbound.protection.outlook.com ([207.46.163.244]:16073
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750810AbaAFHjQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Jan 2014 02:39:16 -0500
In-Reply-To: <201401031350.59447.arnd@arndb.de>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, Jingchang Lu <jingchang.lu@freescale.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, Huan Wang <Huan.Wang@freescale.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Hi Arnd,

> 
> Adding Greg here to make sure we have a common understanding in the future.
> 
> ioread*() was indeed introduced for devices that can be both I/O and memory
> space, and is a bit slowed than readl() on architectures that don't have
> memory mapped I/O space (i.e. x86).
> 
> However, ioread32be is the only architecture-independent big-endian
> accessor function (some architectures have in_be32, but that doesn't
> work on ARM), and as mandated by Linus a couple of years ago when
> we wanted to take some shortcuts on powerpc, ioread32 has to be
> semantically the same as readl when used on pointers returned from
> ioremap() rather than ioport_map, and ioread32be is just the
> byte-swapped version of it.
> 
> We have a couple of drivers using ioread* because of the need for
> big-endian data access, and I would continue recommending that unless
> I hear a good argument against it.
> 
> > The big-endian supports is added at v7~v8 patch series.
> 
> Yes, that version looks fine and it avoids the above problem nicely,
> but I'd still like to make sure we come to a conclusion on the problem
> of big-endian I/O accessors.
> 
> 

How about the following ?
-----
+static inline u32 ftm_readl(struct fsl_pwm_chip *fpc, unsigned long reg)
+{
+       if (fpc->big_endian)
+               return ioread32be(fpc->base + reg);
+       else
+               return ioread32(fpc->base + reg);
+}
+
+static inline void ftm_writel(struct fsl_pwm_chip *fpc, u32 val,
+                             unsigned long reg)
+{
+       if (fpc->big_endian)
+               iowrite32be(val, fpc->base + reg);
+       else
+               iowrite32(val, fpc->base + reg);
+}
------

I'll send another version soon.
Does this patch series has other problems needed to fix or revise ?

Thanks,

Best Regards,
Xiubo
