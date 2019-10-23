Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37411 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403929AbfJWJbS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Oct 2019 05:31:18 -0400
Received: by mail-wm1-f68.google.com with SMTP id f22so18933034wmc.2
        for <linux-pwm@vger.kernel.org>; Wed, 23 Oct 2019 02:31:16 -0700 (PDT)
Date: Wed, 23 Oct 2019 10:30:58 +0100
From: Lee Jones <lee.jones@linaro.org>
Message-ID: <20191023093058.GA19477@dell>
References: <1571631083-4962-1-git-send-email-jeff@labundy.com>
 <1571631083-4962-2-git-send-email-jeff@labundy.com>
 <20191022120051.686ed9f9@archlinux>
 <20191023033646.GB4458@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191023033646.GB4458@labundy.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH 1/8] dt-bindings: mfd: iqs62x: Add bindings
To: Jeff LaBundy <jeff@labundy.com>
Cc: Jonathan Cameron <jic23@kernel.org>, dmitry.torokhov@gmail.com, jdelvare@suse.com, linux@roeck-us.net, thierry.reding@gmail.com, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-hwmon@vger.kernel.org, u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com

On Tue, 22 Oct 2019, Jeff LaBundy wrote:

> Hi Jonathan,
> 
> On Tue, Oct 22, 2019 at 12:00:51PM +0100, Jonathan Cameron wrote:
> > On Sun, 20 Oct 2019 23:11:16 -0500
> > Jeff LaBundy <jeff@labundy.com> wrote:
> > 
> > > This patch adds binding documentation for six-channel members of the
> > > Azoteq ProxFusion family of sensor devices.
> > > 
> > > Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> > 
> > I'm not sure if Lee has made the switch for mfd entirely yet, but
> > mostly new dt bindings need to be in yaml format as it allows
> > automated parsing of the examples + bindings using them for
> > correctness.
> > 
> 
> I'll wait for Lee or Rob's cue, but I'm happy to move to yaml if it's time
> to make the switch here.
> 
> > One comment inline.  I'm far from an expert on most of the stuff here
> > so will leave it for others!

It would make sense.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
