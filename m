Return-Path: <SRS0=dBUW=BW=vger.kernel.org=linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE8FC433E0
	for <linux-pwm@archiver.kernel.org>; Wed, 12 Aug 2020 09:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7201A20885
	for <linux-pwm@archiver.kernel.org>; Wed, 12 Aug 2020 09:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgHLJez (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Wed, 12 Aug 2020 05:34:55 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:39683 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgHLJez (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Aug 2020 05:34:55 -0400
X-Originating-IP: 90.66.108.79
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id D3CBD1BF206;
        Wed, 12 Aug 2020 09:34:52 +0000 (UTC)
Date:   Wed, 12 Aug 2020 11:34:52 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, Lee Jones <lee.jones@linaro.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: atmel: Make use of dev_err_probe()
Message-ID: <20200812093452.GJ3448@piout.net>
References: <20200812080259.4431-1-u.kleine-koenig@pengutronix.de>
 <20200812082002.GD4354@dell>
 <20200812083204.kktnid63j6vefsky@pengutronix.de>
 <20200812084728.GI3448@piout.net>
 <20200812092539.fbpapvrwxbmzfi65@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200812092539.fbpapvrwxbmzfi65@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 12/08/2020 11:25:39+0200, Uwe Kleine-König wrote:
> Hello Alexandre,
> 
> On Wed, Aug 12, 2020 at 10:47:28AM +0200, Alexandre Belloni wrote:
> > On 12/08/2020 10:32:04+0200, Uwe Kleine-König wrote:
> > > On Wed, Aug 12, 2020 at 09:20:02AM +0100, Lee Jones wrote:
> > > > On Wed, 12 Aug 2020, Uwe Kleine-König wrote:
> > > > >  	atmel_pwm->clk = devm_clk_get(&pdev->dev, NULL);
> > > > >  	if (IS_ERR(atmel_pwm->clk))
> > > > > -		return PTR_ERR(atmel_pwm->clk);
> > > > > +		return dev_err_probe(&pdev->dev, PTR_ERR(atmel_pwm->clk),
> > > > > +				     "Failed to get clock\n");
> > > > 
> > > > Isn't dev_err_probe() only useful for drivers handling -EPROBE_DEFER?
> > > 
> > > devm_clk_get() might return -EPROBE_DEFER.
> > 
> > If it did, you wouldn't be able to print this message.
> 
> Why that? It probably won't make it to the console immediately, but once
> the clk is available the log buffer should be pushed out, shouldn't it?
> 

No because that would mean that there is not timer clock and te system
would not be booting to that point at all.

> > I' not sure it is worth adding so many checks for errors that will
> > never happen.
> 
> I'm sure this train of thought is unsustainable. And people will copy
> this code to platforms where this assumption might even be more wrong
> than on at91. 

Well my point is that if you keep the error checks, you can remove the
strings as they will never be printed.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
