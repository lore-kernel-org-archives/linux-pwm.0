Return-Path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-db9lp0253.outbound.messaging.microsoft.com ([213.199.154.253]:25313
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753195Ab3HVHcb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Thu, 22 Aug 2013 03:32:31 -0400
From: Xiubo Li-B47053 <B47053@freescale.com>
Subject: RE: [PATCH 4/4] Documentation: Add device tree bindings for
 Freescale FTM PWM
Date: Thu, 22 Aug 2013 07:32:25 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F827D241A@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1377054462-6283-1-git-send-email-Li.Xiubo@freescale.com>
 <1377054462-6283-5-git-send-email-Li.Xiubo@freescale.com>
 <1473340.OXSHEp7d4P@flatron>
 <1DD289F6464F0949A2FCA5AA6DC23F827D2244@039-SN2MPN1-013.039d.mgd.msft.net>
 <20130822062610.GR31036@pengutronix.de>
In-Reply-To: <20130822062610.GR31036@pengutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Guo Shawn-R65073 <r65073@freescale.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "rob@landley.net" <rob@landley.net>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>

Hi Sascha,

> > > Could you explain meaning of this property more precisely? I'm
> > > interested especially how is this related to the PWM IP block and
> boards.
> > >
> >
> > Yes.
> > There are 8 channels most. While the pinctrls of 4th and 5th channels
> > could be used by uart's Rx and Tx, then these 2 channels won't be used
> > for pwm output, so there will be 6 channels available by the pwm.
> > Thus, the pwm chip will register only 6 pwms(6 channels)
> > most("fsl,pwm-channel-orders = {0 1 2 3 6 7}").And also the "fsl,pwm-
> > channel-number" will be 6.
> 
> If the chip has eight PWMs I would register all of them. If some of them
> are not routed out by the pinmux then just nothing happens if you use
> them. In a sane devicetree they won't be referenced anyway when they are
> not routed out of the SoC.
> 

Yes, that's perfect well.

I will do it in v2.

Thanks very much.
--
Best Regards,
Xiubo

