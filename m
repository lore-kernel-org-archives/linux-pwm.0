From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH 0/3] FTM PWM adds regmap and endianness support.
Date: Mon, 28 Apr 2014 14:26:57 +0000
Message-ID: <e5e350afaa7b42cfbd93f52130560064@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1395377590-23537-1-git-send-email-Li.Xiubo@freescale.com>,<20140428131034.GA15946@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-by2lp0235.outbound.protection.outlook.com ([207.46.163.235]:17166
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752171AbaD1O1B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Apr 2014 10:27:01 -0400
In-Reply-To: <20140428131034.GA15946@ulmo>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "swarren@nvidia.com" <swarren@nvidia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>




> > Xiubo Li (3):
> >   pwm: ftm-pwm: Clean up the code.
> >   pwm: ftm-pwm: Convert to direct regmap API usage.
> >   pwm: ftm-pwm: Add big-endian support
> >
> >  drivers/pwm/pwm-fsl-ftm.c | 96 ++++++++++++++++++++++++++---------------------
> >  1 file changed, 53 insertions(+), 43 deletions(-)
>
> This leaves me with only very vague idea of why this is necessary and
> why it should be merged.
>
> Please describe in more detail (in both the cover-letter and each
> individual patch) why you want me to apply these patches.
>

Thanks very much for your reply.

Should I resend this patch series? If so, I will add some thing like the following:

The FTM PWM driver will be used in our Vybrid, LS1 and LS2+ SoCs, and on Vybrid
and LS2 SoCs, the FTM devices are in LE mode, while on LS1 SoCs it in BE mode.

So this patch series add endianness support based on the regmap core, which has
already support the rich endiannesses for the same device.

Thanks,

BRs
Xiubo
