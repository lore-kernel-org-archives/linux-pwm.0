Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from p3plsmtpa06-07.prod.phx3.secureserver.net ([173.201.192.108]:36990
        "EHLO p3plsmtpa06-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390785AbfJXCiT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Oct 2019 22:38:19 -0400
Date: Wed, 23 Oct 2019 21:38:16 -0500
From: Jeff LaBundy <jeff@labundy.com>
Message-ID: <20191024023816.GA3321@labundy.com>
References: <1571631083-4962-1-git-send-email-jeff@labundy.com>
 <1571631083-4962-2-git-send-email-jeff@labundy.com>
 <20191022120051.686ed9f9@archlinux>
 <20191023033646.GB4458@labundy.com>
 <20191023093058.GA19477@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191023093058.GA19477@dell>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH 1/8] dt-bindings: mfd: iqs62x: Add bindings
To: Lee Jones <lee.jones@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, dmitry.torokhov@gmail.com, jdelvare@suse.com, linux@roeck-us.net, thierry.reding@gmail.com, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-hwmon@vger.kernel.org, u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com

Hi Lee,

On Wed, Oct 23, 2019 at 10:30:58AM +0100, Lee Jones wrote:
> On Tue, 22 Oct 2019, Jeff LaBundy wrote:
> 
> > Hi Jonathan,
> > 
> > On Tue, Oct 22, 2019 at 12:00:51PM +0100, Jonathan Cameron wrote:
> > > On Sun, 20 Oct 2019 23:11:16 -0500
> > > Jeff LaBundy <jeff@labundy.com> wrote:
> > > 
> > > > This patch adds binding documentation for six-channel members of the
> > > > Azoteq ProxFusion family of sensor devices.
> > > > 
> > > > Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> > > 
> > > I'm not sure if Lee has made the switch for mfd entirely yet, but
> > > mostly new dt bindings need to be in yaml format as it allows
> > > automated parsing of the examples + bindings using them for
> > > correctness.
> > > 
> > 
> > I'll wait for Lee or Rob's cue, but I'm happy to move to yaml if it's time
> > to make the switch here.
> > 
> > > One comment inline.  I'm far from an expert on most of the stuff here
> > > so will leave it for others!
> 
> It would make sense.
> 

Sure thing; will do.

> -- 
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
> 

Kind regards,
Jeff LaBundy
