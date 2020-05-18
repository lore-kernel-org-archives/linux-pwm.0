From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v2 15/16] backlight: make of_find_backlight_by_node()
 static
Date: Mon, 18 May 2020 20:56:56 +0100
Message-ID: <20200518195656.z2wag34mbr3e2hip@holly.lan>
References: <20200517190139.740249-1-sam@ravnborg.org>
 <20200517190139.740249-16-sam@ravnborg.org>
 <20200518165648.ltgtofjsteyyse4j@holly.lan>
 <20200518181227.GC770425@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgERT5B (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 May 2020 15:57:01 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF17C061A0C
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 12:57:01 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k12so721202wmj.3
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 12:57:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200518181227.GC770425@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org, Bjorn Andersson <bjorn.andersson@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Russell King <linux@armlinux.org.uk>, Andy Gross <agross@kernel.org>, Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jani Nikula <jani.nikula@intel.com>, linux-arm-msm@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>, Jingoo Han <jingoohan1@gmail.com>

On Mon, May 18, 2020 at 08:12:27PM +0200, Sam Ravnborg wrote:
> On Mon, May 18, 2020 at 05:56:48PM +0100, Daniel Thompson wrote:
> > On Sun, May 17, 2020 at 09:01:38PM +0200, Sam Ravnborg wrote:
> > > There are no external users of of_find_backlight_by_node().
> > > Make it static so we keep it that way.
> > > 
> > > v2:
> > >   - drop EXPORT of of_find_backlight_by_node
> > > 
> > > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > > Cc: Lee Jones <lee.jones@linaro.org>
> > > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > > Cc: Jingoo Han <jingoohan1@gmail.com>
> > 
> > Assuming the 0day-ci comments are because some of the patches have
> > already been sucked up in a different tree then:
> Correct. For now only drm-misc-next have no users of
> of_find_backlight_by_node() which is why the other trees failed.
> 
>  
> > Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Thanks for all your reviews!
> I will shortly (within a few days) address the comments and send out a v3.
> 
> Is is correct that I assume you or Lee or Jingoo will apply the patches
> to a backlight tree somewhere when they are ready?
> If you have a tree you use for backlight patches I can base v3 on that,
> given that I get a link and have access to pull from it.

Absent holidays and the like, Lee usually does that actual patch
hoovering.


Daniel.
