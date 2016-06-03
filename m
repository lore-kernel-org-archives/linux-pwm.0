From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 3/4] doc: dt: pwm: add binding for ChromeOS EC PWM
Date: Thu, 2 Jun 2016 18:17:39 -0700
Message-ID: <20160603011739.GA36948@google.com>
References: <1464399556-17222-1-git-send-email-briannorris@chromium.org>
 <1464399556-17222-4-git-send-email-briannorris@chromium.org>
 <CAMHSBOWSJbcsuojctqOY+8d2Bg8Txtxd-5wFrM0LwJQt7=YRQQ@mail.gmail.com>
 <20160601011059.GB121799@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34367 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbcFCBRo (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 2 Jun 2016 21:17:44 -0400
Received: by mail-pa0-f43.google.com with SMTP id bz2so9574160pad.1
        for <linux-pwm@vger.kernel.org>; Thu, 02 Jun 2016 18:17:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160601011059.GB121799@google.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Gwendal Grignou <gwendal@chromium.org>
Cc: Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Olof Johansson <olof@lixom.net>, Linux Kernel <linux-kernel@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Stephen Barber <smbarber@chromium.org>, Sameer Nanda <snanda@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Randall Spangler <rspangler@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Todd Broch <tbroch@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>

Hi,

After some more thought, a small change in plans.

On Tue, May 31, 2016 at 06:10:59PM -0700, Brian Norris wrote:
> On Sat, May 28, 2016 at 10:00:45PM -0700, Gwendal Grignou wrote:
> > Instead of using device tree, assuming you have firmware control,
> > another way could be to add a firmware feature:
> 
> I do have firmware control, but I don't think that will be too necessary
> actually.
> 
> > for instance, there is one EC_FEATURE_PWM_FAN, the fan PWM, one for
> > the keyboard lightning as well. (see num ec_feature_code)
> > By adding one more, you let cros_ec_dev load the platform driver for
> > you, it works even if the machine does not use device tree.
> 
> I think we can actually get this without doing the EC_FEATURE_* thing
> (which notably is not in upstream, BTW), nor by requiring a separate
> node with the "google,cros-ec-pwm" property, but instead by running a
> sample EC_CMD_PWM_GET_DUTY command on indeces [0, 255], stopping at the
> first INVAL_PARAM failure (if we stop at 0, then we have no PWM API at
> all).
> 
> But that still leaves the problem of mapping PWMs to consumer devices.
> The phandle translation is very helpful for our DT-based systems, but
> there isn't a really nice equivalent for non-DT ones. I see struct
> pwm_lookup, which looks like it could do some of what we want, but we'd
> still either need to encode a ton of board-specific information in the
> kernel, or else start exposing PWMs via the non-EC_PWM_TYPE_GENERIC
> methods (see the new enum ec_pwm_type, where we can see
> EC_PWM_TYPE_KB_LIGHT and EC_PWM_TYPE_DISPLAY_LIGHT).

I think the way that DT systems and non-DT systems work means that we
really want to address this in different ways. DT has nice phandles,
which naturally work well with index-based addressing, while non-DT has
the much inferior pwm_lookup stuff, which we'd have to encode directly
in the drivers, and which would probably work out better with the
TYPE-based addressing. So if/when we want to work on the non-DT case,
we'll just need to extend this driver to support either method.
But as we're interested in DT right now, I plan to only implement the DT
method.

> Anyway, along this line, perhaps it makes sense to:
> 
>  (a) drop the "google,cros-ec-pwm" property (via the probe method I
>  described above)

So I will be doing (a) still...

>  (b) drop the separate node for "google,cros-ec-pwm", since the presence
>  of this feature can be detected by the same methods as in (a)
> 
> leaving the only DT binding change to be to:
> 
>  (c) add an optional #pwm-cells property to the cros-ec node
>  (Documentation/devicetree/bindings/mfd/cros-ec.txt) so that we can
>  still utilize the nice PWM of_xlate stuff (and its corresponding pwms =
>  <...> property for consumer devices)

...but I'm not doing (b) or (c).

Will send v2 shortly.

Regards,
Brian
