From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH v6 2/2] pwm: Add support for R-Car PWM Timer
Date: Wed, 30 Sep 2015 08:49:45 +0000
Message-ID: <SG2PR06MB091904CF251C9CF1A999C768D84D0@SG2PR06MB0919.apcprd06.prod.outlook.com>
References: <1439957639-4816-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1439957639-4816-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20150819100732.GC26627@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:64771 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750927AbbI3Itu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Wed, 30 Sep 2015 04:49:50 -0400
Content-Language: ja-JP
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Thierry,

> Sent: Tuesday, September 15, 2015 7:01 PM
> 
> Hi Thierry,
> 
> > Sent: Wednesday, August 19, 2015 8:01 PM
> >
> > Hi Thierry,
> >
> > > Sent: Wednesday, August 19, 2015 7:08 PM
> > >
> > > On Wed, Aug 19, 2015 at 01:13:59PM +0900, Yoshihiro Shimoda wrote:
> > > > This patch adds support for R-Car SoCs PWM Timer. The PWM timer of
> > > > R-Car H2 has 7 channels. So, we can use the channels if we describe
> > > > device tree nodes.
> > > >
> > > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> > > > ---
> > > >  drivers/pwm/Kconfig    |  11 ++
> > > >  drivers/pwm/Makefile   |   1 +
> > > >  drivers/pwm/pwm-rcar.c | 265 +++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 277 insertions(+)
> > > >  create mode 100644 drivers/pwm/pwm-rcar.c
> > >
> > > Found a couple more things. No need to respin for any of these, I can
> > > make the changes when applying, but I'd like confirmation on a couple
> > > of things below.
> >
> > Thank you!
> 
> I could not find this driver in the latest your linux-pwm.git / for-next branch.
> Should I send v7 patch?

I submitted v7 patch now. So, would you review it?

Best regards,
Yoshihiro Shimoda
