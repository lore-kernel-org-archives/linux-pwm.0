From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 05/11] pwm: add support for sl28cpld PWM controller
Date: Mon, 8 Jun 2020 08:46:30 +0100
Message-ID: <20200608074630.GA3567@dell>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-6-michael@walle.cc>
 <20200605084915.GE3714@dell>
 <b3324f5c1c908edc89a9cd2676644dfe@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729007AbgFHHqe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 Jun 2020 03:46:34 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A12C08C5C4
        for <linux-pwm@vger.kernel.org>; Mon,  8 Jun 2020 00:46:34 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j10so16245451wrw.8
        for <linux-pwm@vger.kernel.org>; Mon, 08 Jun 2020 00:46:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <b3324f5c1c908edc89a9cd2676644dfe@walle.cc>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Michael Walle <michael@walle.cc>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>

On Fri, 05 Jun 2020, Michael Walle wrote:

> Am 2020-06-05 10:49, schrieb Lee Jones:
> [..]
> > > +static inline struct sl28cpld_pwm *to_sl28cpld_pwm(struct pwm_chip
> > > *chip)
> > > +{
> > > +	return container_of(chip, struct sl28cpld_pwm, pwm_chip);
> > > +}
> > 
> > Why not save yourself the trouble and just:
> > 
> >   struct sl28cpld_pwm *pwm = dev_get_drvdata(chip->dev);
> 
> Is there a reason why not a single pwm driver uses something like that?

Copy/paste?  Habit?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
