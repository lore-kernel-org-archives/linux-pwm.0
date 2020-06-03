From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: Add Lee Jones as reviewer for the PWM
 subsystem
Date: Wed, 3 Jun 2020 17:22:04 +0100
Message-ID: <20200603162204.GO3714@dell>
References: <20200602123241.3363904-1-thierry.reding@gmail.com>
 <20200603123718.6fwsbpnkbjlpq2bz@taurus.defre.kleine-koenig.org>
 <20200603144224.GC3478467@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgFCQWK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 3 Jun 2020 12:22:10 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9448EC08C5C0
        for <linux-pwm@vger.kernel.org>; Wed,  3 Jun 2020 09:22:08 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y17so3005944wrn.11
        for <linux-pwm@vger.kernel.org>; Wed, 03 Jun 2020 09:22:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200603144224.GC3478467@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org

On Wed, 03 Jun 2020, Thierry Reding wrote:

> On Wed, Jun 03, 2020 at 02:37:18PM +0200, Uwe Kleine-König wrote:
> > On Tue, Jun 02, 2020 at 02:32:41PM +0200, Thierry Reding wrote:
> > > Lee has kindly offered his help in sharing the patch review workload for
> > > the PWM subsystem. If this works out well between Lee, Uwe and myself it
> > > may be a good idea to maintain the subsystem as a group.
> > > 
> > > Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> > > ---
> > >  MAINTAINERS | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index e64e5db31497..b8889bed5d1e 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -13736,6 +13736,7 @@ F:	drivers/media/rc/pwm-ir-tx.c
> > >  PWM SUBSYSTEM
> > >  M:	Thierry Reding <thierry.reding@gmail.com>
> > >  R:	Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > +M:	Lee Jones <lee.jones@linaro.org>
> > 
> > I'm bit surprised that Lee got M: which I have a R:. The commit log
> > talks about reviewer not maintainer.
> > 
> > While I'm not sure that there is a practical difference it makes me a
> > bit sad.
> 
> That was not the intention. According to the notes at the top of the
> MAINTAINERS file, recipients on M: lines will be added in the To:
> header, while R: lines will be added in the Cc: header. That's really
> the only difference.
> 
> In practical terms this may be helpful for filtering where email where
> you are on the To: line can be prioritized over those where you are on
> the Cc: line.

Exactly right.

It's a common misconception that M: means 'Maintainer'.  It doesn't.
M: simply means "Mail-to".  It has nothing to do with maintainership
levels/hierarchy and everything to do with mail filtering.

Nothing to be sad about.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
