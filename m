From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH 2/3] pwm: ftm-pwm: Convert to direct regmap API usage.
Date: Mon, 28 Apr 2014 15:14:30 +0000
Message-ID: <74580957bdd04894aa303b86f4fb536a@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1395377590-23537-1-git-send-email-Li.Xiubo@freescale.com>
 <1395377590-23537-3-git-send-email-Li.Xiubo@freescale.com>,<20140428145930.GC28443@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140428145930.GC28443@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "swarren@nvidia.com" <swarren@nvidia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org


> >  drivers/pwm/pwm-fsl-ftm.c | 83 +++++++++++++++++++++++++----------------------
> >  1 file changed, 44 insertions(+), 39 deletions(-)
> 
> This could explain the advantages of converting to regmap. Looking at
> this diffstat above, it's not immediately obvious that there's an
> advantage because you end up adding 5 lines.
> 
> Again I'm guessing this is in preparation to add endianess support, and
> it will be really easy to add that using regmap, so the gains will only
> become obvious later on.
> 
> That's the kind of thing I'd like to see in the patch description. It
> tells me why this patch makes sense.
> 

Yes, That`s why converting to use the regmap.

I`ll update this as you have mentioned.

Thanks,
BRs
Xiubo
