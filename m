From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH 0/3] FTM PWM adds regmap and endianness support.
Date: Mon, 28 Apr 2014 15:21:47 +0000
Message-ID: <106747c19727435782fe197a96946490@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1395377590-23537-1-git-send-email-Li.Xiubo@freescale.com>
 <20140428131034.GA15946@ulmo>
 <e5e350afaa7b42cfbd93f52130560064@BY2PR03MB505.namprd03.prod.outlook.com>,<20140428145615.GA28443@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140428145615.GA28443@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "swarren@nvidia.com" <swarren@nvidia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org


> > Should I resend this patch series? If so, I will add some thing like the following:
> >
> > The FTM PWM driver will be used in our Vybrid, LS1 and LS2+ SoCs, and on Vybrid
> > and LS2 SoCs, the FTM devices are in LE mode, while on LS1 SoCs it in BE mode.
> >
> > So this patch series add endianness support based on the regmap core, which has
> > already support the rich endiannesses for the same device.
>
> Yes, please resend with that description added where appropriate. I'd
> like to see something like that in the cover letter and, more
> importantly, in the individual patches.
>

Okay, Please see the next version.

Thanks,

BRs
Xiubo