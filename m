From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH] pwm: core: Use devm_kzalloc instead of kzalloc
Date: Tue, 7 Jan 2014 07:36:14 +0000
Message-ID: <20a8a6494bfd4a7e8367e53b13c7b3b2@DM2PR03MB509.namprd03.prod.outlook.com>
References: <1389074700-1825-1-git-send-email-Li.Xiubo@freescale.com>
 <1389078870.32137.5.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-by2lp0239.outbound.protection.outlook.com ([207.46.163.239]:17873
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754056AbaAGHgQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Jan 2014 02:36:16 -0500
In-Reply-To: <1389078870.32137.5.camel@joe-AO722>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


> > Use devm_kzalloc instead of kzalloc to free automatically and make
> > the cleanup paths simpler and the code slightly shorter.
> []
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> []
> > @@ -245,7 +244,9 @@ int pwmchip_add(struct pwm_chip *chip)
> >  	if (ret < 0)
> >  		goto out;
> >
> > -	chip->pwms = kzalloc(chip->npwm * sizeof(*pwm), GFP_KERNEL);
> > +	chip->pwms = devm_kzalloc(chip->dev,
> > +				  chip->npwm * sizeof(*pwm),
> > +				  GFP_KERNEL);
> 
> There is a devm_kcalloc and this should likely use it.
> 

Yes, I will use it.

Thanks,

 

