From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v11 10/12] backlight: pwm_bl: Use 64-bit division function
Date: Wed, 15 Apr 2020 10:26:38 +0100
Message-ID: <20200415092638.GG2167633@dell>
References: <cover.1584667964.git.gurus@codeaurora.org>
 <17fc1dcf8b9b392d1e37dc7e3e67409e3c502840.1584667964.git.gurus@codeaurora.org>
 <20200320133123.GD5477@dell>
 <20200324110710.GL5477@dell>
 <20200324125735.2mjuvbxt5bpon2ft@pengutronix.de>
 <20200324130410.dwlg767ku6kwequv@holly.lan>
 <20200324142441.GD442973@dell>
 <20200324144307.kxhqzyjj4evrouqa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895463AbgDOJZj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 15 Apr 2020 05:25:39 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793ABC061A0F
        for <linux-pwm@vger.kernel.org>; Wed, 15 Apr 2020 02:25:39 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x18so13957942wrq.2
        for <linux-pwm@vger.kernel.org>; Wed, 15 Apr 2020 02:25:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200324144307.kxhqzyjj4evrouqa@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Guru Das Srinagesh <gurus@codeaurora.org>, linux-pwm@vger.kernel.org, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, linux-kernel@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

On Tue, 24 Mar 2020, Uwe Kleine-König wrote:

> On Tue, Mar 24, 2020 at 02:24:41PM +0000, Lee Jones wrote:
> > On Tue, 24 Mar 2020, Daniel Thompson wrote:
> > 
> > > On Tue, Mar 24, 2020 at 01:57:35PM +0100, Uwe Kleine-König wrote:
> > > > Hello Lee,
> > > > 
> > > > On Tue, Mar 24, 2020 at 11:07:10AM +0000, Lee Jones wrote:
> > > > > On Fri, 20 Mar 2020, Lee Jones wrote:
> > > > > 
> > > > > > On Thu, 19 Mar 2020, Guru Das Srinagesh wrote:
> > > > > > 
> > > > > > > Since the PWM framework is switching struct pwm_state.period's datatype
> > > > > > > to u64, prepare for this transition by using div_u64 to handle a 64-bit
> > > > > > > dividend instead of a straight division operation.
> > > > > > > 
> > > > > > > Cc: Lee Jones <lee.jones@linaro.org>
> > > > > > > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > > > > > > Cc: Jingoo Han <jingoohan1@gmail.com>
> > > > > > > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > > > > > Cc: linux-pwm@vger.kernel.org
> > > > > > > Cc: dri-devel@lists.freedesktop.org
> > > > > > > Cc: linux-fbdev@vger.kernel.org
> > > > > > > 
> > > > > > > Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> > > > > > > Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> > > > > > > ---
> > > > > > >  drivers/video/backlight/pwm_bl.c | 3 ++-
> > > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > Can this patch be taken on its own?
> > > > > 
> > > > > Hellooooo ...
> > > > 
> > > > Conceptually it can. As the last patch depends on this one (and the
> > > > others) some coordination might be beneficial. But that's up to Thierry
> > > > to decide how (and if) he want this series to be applied.
> > > 
> > > ... and on the backlight side we definitely need to know about the "if"
> > > otherwise there's no point in taking it.
> > 
> > Right.
> > 
> > I'm happy to wait for Thierry.  Although this isn't the only set he's
> > currently blocking.  Is he okay?  On holiday perhaps?
> 
> The newest commit by him in next is from last week. My guess is he
> just didn't come around yet to care for the PWM duties.

Looks like we missed the last release.

Let's hope we don't miss the next one also.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
