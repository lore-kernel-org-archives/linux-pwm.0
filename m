From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH 3/3] pwm: ftm-pwm: Add big-endian support
Date: Mon, 28 Apr 2014 15:11:11 +0000
Message-ID: <3f5658518174446e8edfc0038235e4fc@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1395377590-23537-1-git-send-email-Li.Xiubo@freescale.com>
 <1395377590-23537-4-git-send-email-Li.Xiubo@freescale.com>,<20140428150207.GD28443@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-by2lp0237.outbound.protection.outlook.com ([207.46.163.237]:14698
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756477AbaD1PLO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Apr 2014 11:11:14 -0400
In-Reply-To: <20140428150207.GD28443@ulmo>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "swarren@nvidia.com" <swarren@nvidia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


> > Now for the following scenarios:
> >
> >      SoC     |  CPU   | FTM-PWM | 'big-endian' property is needed?
> > -------------|--------|---------|---------------------------------
> >     Vybird   |  LE    |   LE    |     No
> >     LS1     |  LE    |   BE    |     Yes
> >     LS2     |  LE    |   LE    |     No
> >
> > Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> > ---
> >  drivers/pwm/pwm-fsl-ftm.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> 
> And this should probably describe in text what happens. The table may
> look good, but you don't give a real description of what the change
> does.
> 

I will follow your advice.


> Oh, and doesn't this change need to update the device tree binding since
> you now have an additional property?
>

Yes, you are right. I just forgot it.

I will add update it.

Thanks very much.

BRs
XIubo

