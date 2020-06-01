From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v15 04/11] pwm: clps711x: Use 64-bit division macro
Date: Mon, 1 Jun 2020 12:33:28 +0100
Message-ID: <20200601113328.oyhxosbtlfeaqytq@holly.lan>
References: <cover.1590514331.git.gurus@codeaurora.org>
 <dd03cc467ac3fc470826aef523822b32e15dc929.1590514331.git.gurus@codeaurora.org>
 <20200528203341.GA8065@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgFALdc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 Jun 2020 07:33:32 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351ABC03E97C
        for <linux-pwm@vger.kernel.org>; Mon,  1 Jun 2020 04:33:32 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r7so11211585wro.1
        for <linux-pwm@vger.kernel.org>; Mon, 01 Jun 2020 04:33:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200528203341.GA8065@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Guru Das Srinagesh <gurus@codeaurora.org>
Cc: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, David Collins <collinsd@codeaurora.org>, linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, Stephen Boyd <sboyd@kernel.org>, Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Guenter Roeck <linux@roeck-us.net>, Dan Carpenter <dan.carpenter@oracle.com>, linux-arm-kernel@lists.infradead.org

On Thu, May 28, 2020 at 01:33:41PM -0700, Guru Das Srinagesh wrote:
> On Tue, May 26, 2020 at 10:35:04AM -0700, Guru Das Srinagesh wrote:
> > Since the PWM framework is switching struct pwm_args.period's datatype
> > to u64, prepare for this transition by using DIV64_U64_ROUND_CLOSEST to
> > handle a 64-bit divisor.
> > 
> > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> > ---
> >  drivers/pwm/pwm-clps711x.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
> > index 924d39a..ba9500a 100644
> > --- a/drivers/pwm/pwm-clps711x.c
> > +++ b/drivers/pwm/pwm-clps711x.c
> > @@ -43,7 +43,7 @@ static void clps711x_pwm_update_val(struct clps711x_chip *priv, u32 n, u32 v)
> >  static unsigned int clps711x_get_duty(struct pwm_device *pwm, unsigned int v)
> >  {
> >  	/* Duty cycle 0..15 max */
> > -	return DIV_ROUND_CLOSEST(v * 0xf, pwm->args.period);
> > +	return DIV64_U64_ROUND_CLOSEST(v * 0xf, pwm->args.period);
> >  }
> >  
> >  static int clps711x_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> > -- 
> 
> Hi Daniel,
> 
> Could you please review this patch when you get a chance to?

I don't normally review PWM patches... but this no longer has the bug
there was there when I first read this patch.


Daniel.
