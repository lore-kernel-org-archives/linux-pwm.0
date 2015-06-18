From: Yingjoe Chen <yingjoe.chen@mediatek.com>
Subject: Re: [PATCH v2 2/2] pwm: add MediaTek display PWM driver support
Date: Thu, 18 Jun 2015 21:58:59 +0800
Message-ID: <1434635939.22029.7.camel@mtksdaap41>
References: <1432214964-40644-1-git-send-email-yh.huang@mediatek.com>
	 <1432214964-40644-3-git-send-email-yh.huang@mediatek.com>
	 <20150612102046.GF19400@ulmo.nvidia.com>
	 <1434622784.18278.39.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:60440 "EHLO
	mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932091AbbFRN7F (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 18 Jun 2015 09:59:05 -0400
In-Reply-To: <1434622784.18278.39.camel@mtksdaap41>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: YH Huang <yh.huang@mediatek.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>

On Thu, 2015-06-18 at 18:19 +0800, YH Huang wrote:
> On Fri, 2015-06-12 at 12:20 +0200, Thierry Reding wrote:
> > > +/* Shift log2(PWM_PERIOD_MAX + 1) as divisor */
> > > +#define PWM_PERIOD_BIT_SHIFT	12
> > 
> > I wasn't very clear about this in my earlier review, so let me try to
> > explain why I think this is confusing. You use this as a divisor, but
> > you encode it as a shift. It's also PWM_PERIOD_MAX + 1, so I think it
> > would make more sense to drop this, keep PWM_PERIOD_MAX as above and
> > then replace the
> > 
> > 	>> PWM_PERIOD_BIT_SHIFT
> > 	
> > below by
> > 
> > 	/ (PWM_PERIOD_MAX + 1)
> > 
> 
> Maybe I can change in this way:
> Remove this: #define PWM_PERIOD_MAX		0x00000fff
> Using ">> PWM_PERIOD_BIT_SHIFT" is faster than "/ (PWM_PERIOD_MAX + 1)"
> Is this right?


The place which use this shift is:

	clk_div = div_u64(rate * period_ns, NSEC_PER_SEC) >> 
			  PWM_PERIOD_BIT_SHIFT;

div_u64 return u64. If we change >> to /, and somehow compiler didn't
optimize that div into shift, it will cause build error.

Joe.C
