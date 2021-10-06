Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0756C433F5
	for <linux-pwm@archiver.kernel.org>; Wed,  6 Oct 2021 07:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0EF761177
	for <linux-pwm@archiver.kernel.org>; Wed,  6 Oct 2021 07:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237621AbhJFHzp (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Wed, 6 Oct 2021 03:55:45 -0400
Received: from mail.thorsis.com ([92.198.35.195]:46447 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237543AbhJFHzp (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 6 Oct 2021 03:55:45 -0400
X-Greylist: delayed 541 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Oct 2021 03:55:41 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id 2FB1EF34;
        Wed,  6 Oct 2021 09:44:48 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MA5K6ySVTUwA; Wed,  6 Oct 2021 09:44:48 +0200 (CEST)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id EE01A3376; Wed,  6 Oct 2021 09:44:47 +0200 (CEST)
Date:   Wed, 6 Oct 2021 09:44:34 +0200
From:   Alexander Dahl <ada@thorsis.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Subject: Re: [PATCH v9 1/2] dt-bindings: leds: Add Qualcomm Light Pulse
 Generator binding
Message-ID: <YV1T4lR+GNAjkuo4@ada.ifak-system.com>
Mail-Followup-To: Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>
References: <20210623035039.772660-1-bjorn.andersson@linaro.org>
 <CAE-0n53SLqmXhJBPROeQj2HzShgYoFzDqsi-KCj3dgVHdDWUTA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n53SLqmXhJBPROeQj2HzShgYoFzDqsi-KCj3dgVHdDWUTA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hei hei,

Am Wed, Sep 08, 2021 at 03:39:51AM +0000 schrieb Stephen Boyd:
> Quoting Bjorn Andersson (2021-06-22 20:50:38)
> > diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> > new file mode 100644
> > index 000000000000..10aee61a7ffc
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> > @@ -0,0 +1,164 @@
> [....]
> > +examples:
> > +  - |
> > +    #include <dt-bindings/leds/common.h>
> > +
> > +    lpg {
> 
> Should the node name be led or leds?

If I scan through Documentation/devicetree/bindings/leds and look at
other devices, it should probably be named "led-controller", right?

At least that's what Rob suggested when I converted the leds-pwm
binding last year, using generic node names:

https://lore.kernel.org/linux-leds/20200922155747.GA2734659@bogus/

Greets
Alex

> 
> > +      compatible = "qcom,pmi8994-lpg";
> 
> Shouldn't there be a reg property? I see the driver has them hardcoded
> but if this is a child of the spmi node then it should have a reg
> property (or many reg properties).
