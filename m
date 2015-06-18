From: YH Huang <yh.huang@mediatek.com>
Subject: Re: [PATCH v2 2/2] pwm: add MediaTek display PWM driver support
Date: Thu, 18 Jun 2015 17:02:43 +0800
Message-ID: <1434618163.18278.7.camel@mtksdaap41>
References: <1432214964-40644-1-git-send-email-yh.huang@mediatek.com>
	 <1432214964-40644-3-git-send-email-yh.huang@mediatek.com>
	 <20150612102529.GH19400@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:54812 "EHLO
	mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752368AbbFRJDK (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 18 Jun 2015 05:03:10 -0400
In-Reply-To: <20150612102529.GH19400@ulmo.nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, yh.huang@mediatek.com

On Fri, 2015-06-12 at 12:25 +0200, Thierry Reding wrote:
> On Thu, May 21, 2015 at 09:29:24PM +0800, YH Huang wrote:
> > Add display PWM driver support to modify backlight for MT8173.
> 
> The driver also claims compatibility with MT6595, so you should mention
> that here as well. Also please be more verbose in the commit message.
> You should mention things like how many channels the PWM has or typical
> use-cases.
> 
> Thierry

I will do it.
Thank for your suggestion.

Regards,
YH Huang
