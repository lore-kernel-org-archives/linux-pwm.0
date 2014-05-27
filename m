From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH] pwm: fsl-ftm: set pwm_chip can_sleep flag
Date: Tue, 27 May 2014 01:38:15 +0000
Message-ID: <1705268cae1845b288ccc561fc0166cb@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1400717120.23867.1.camel@phoenix>
 <08012c6e5240435ea1ce1836229f0b21@BY2PR03MB505.namprd03.prod.outlook.com>
 <20140523071617.GB6310@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bn1blp0184.outbound.protection.outlook.com ([207.46.163.184]:17635
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751923AbaE0BiT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 26 May 2014 21:38:19 -0400
In-Reply-To: <20140523071617.GB6310@ulmo>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Axel Lin <axel.lin@ingics.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>

> Subject: Re: [PATCH] pwm: fsl-ftm: set pwm_chip can_sleep flag
> 
> On Fri, May 23, 2014 at 01:02:21AM +0000, Li.Xiubo@freescale.com wrote:
> > > Subject: [PATCH] pwm: fsl-ftm: set pwm_chip can_sleep flag
> > >
> > > The implementation of .config(), .enable() and .disable() operations in
> this
> > > driver may sleep, thus set pwm_chip can_sleep flag.
> > >
> > > Signed-off-by: Axel Lin <axel.lin@ingics.com>
> > > ---
> >
> > Acked-by: Xiubo Li <Li.Xiubo@freescale.com>
> >
> > @Thierry,
> >
> > There are still 4 patches before this one, and I'd like to know the status
> of
> > them:
> > 	[PATCHv2 0/4] FTM PWM adds regmap and endianness support.
> 
> I was holding off on those because I thought I had seen some discussion
> about how to represent endianness support in DT and I'm not aware that
> there were any conclusions yet.
> 

  pwm: ftm-pwm: Clean up the code.
  pwm: ftm-pwm: Convert to direct regmap API usage.

Well, how about the above two patches? And that discussion is mostly about 
The following ones:

  Documentation: Add 'big-endian' property for FTM PWM.
  pwm: ftm-pwm: Add big-endian support


Thanks,

BRs
Xiubo


> Thierry
