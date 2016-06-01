From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 3/4] doc: dt: pwm: add binding for ChromeOS EC PWM
Date: Tue, 31 May 2016 18:10:59 -0700
Message-ID: <20160601011059.GB121799@google.com>
References: <1464399556-17222-1-git-send-email-briannorris@chromium.org>
 <1464399556-17222-4-git-send-email-briannorris@chromium.org>
 <CAMHSBOWSJbcsuojctqOY+8d2Bg8Txtxd-5wFrM0LwJQt7=YRQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35130 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbcFABLG (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 31 May 2016 21:11:06 -0400
Received: by mail-pf0-f172.google.com with SMTP id g64so3393528pfb.2
        for <linux-pwm@vger.kernel.org>; Tue, 31 May 2016 18:11:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMHSBOWSJbcsuojctqOY+8d2Bg8Txtxd-5wFrM0LwJQt7=YRQQ@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Gwendal Grignou <gwendal@chromium.org>
Cc: Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Olof Johansson <olof@lixom.net>, Linux Kernel <linux-kernel@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Stephen Barber <smbarber@chromium.org>, Sameer Nanda <snanda@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Randall Spangler <rspangler@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Todd Broch <tbroch@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>

Hi Gwendal,

On Sat, May 28, 2016 at 10:00:45PM -0700, Gwendal Grignou wrote:

(Top posting?)

> Instead of using device tree, assuming you have firmware control,
> another way could be to add a firmware feature:

I do have firmware control, but I don't think that will be too necessary
actually.

> for instance, there is one EC_FEATURE_PWM_FAN, the fan PWM, one for
> the keyboard lightning as well. (see num ec_feature_code)
> By adding one more, you let cros_ec_dev load the platform driver for
> you, it works even if the machine does not use device tree.

I think we can actually get this without doing the EC_FEATURE_* thing
(which notably is not in upstream, BTW), nor by requiring a separate
node with the "google,cros-ec-pwm" property, but instead by running a
sample EC_CMD_PWM_GET_DUTY command on indeces [0, 255], stopping at the
first INVAL_PARAM failure (if we stop at 0, then we have no PWM API at
all).

But that still leaves the problem of mapping PWMs to consumer devices.
The phandle translation is very helpful for our DT-based systems, but
there isn't a really nice equivalent for non-DT ones. I see struct
pwm_lookup, which looks like it could do some of what we want, but we'd
still either need to encode a ton of board-specific information in the
kernel, or else start exposing PWMs via the non-EC_PWM_TYPE_GENERIC
methods (see the new enum ec_pwm_type, where we can see
EC_PWM_TYPE_KB_LIGHT and EC_PWM_TYPE_DISPLAY_LIGHT).

Anyway, along this line, perhaps it makes sense to:

 (a) drop the "google,cros-ec-pwm" property (via the probe method I
 described above)
 (b) drop the separate node for "google,cros-ec-pwm", since the presence
 of this feature can be detected by the same methods as in (a)

leaving the only DT binding change to be to:

 (c) add an optional #pwm-cells property to the cros-ec node
 (Documentation/devicetree/bindings/mfd/cros-ec.txt) so that we can
 still utilize the nice PWM of_xlate stuff (and its corresponding pwms =
 <...> property for consumer devices)

This would set us up for a minimal reliance on device tree (we can try
to expose EC_PWM_TYPE_KB_LIGHT or EC_PWM_TYPE_DISPLAY_LIGHT via the
pwm_lookup infrastructure, once we need to support a non-DT system),
without losing much of its benefits (we can still do index-based /
phandle lookups with DT). The remaining question is: where should this
minimal PWM driver go, then? We would want to make calls to it from the
cros_ec MFD/platform driver, so...
drivers/platform/chrome/cros_ec_dev.c? Or more likely a modularized
drivers/platform/chrome/cros_ec_pwm.c, where cros_ec_dev.c can make a
few calls to it?

Brian

> Gwendal.
> 
> On Fri, May 27, 2016 at 6:39 PM, Brian Norris <briannorris@chromium.org> wrote:
> > The ChromeOS Embedded Controller can support controlling its attached
> > PWMs via its host-command interface. The number of supported PWMs varies
> > on a per-board basis, so we define a "google,max-pwms" property to
> > handle this. And because the EC only allows specifying the duty cycle
> > and not the period, we don't specify the period via pwm-cells, and
> > instead have only support 1 cell -- to specify the index.
> >
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> >  .../devicetree/bindings/pwm/google,cros-ec-pwm.txt | 25 ++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
> > new file mode 100644
> > index 000000000000..f1c9540fc23f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
> > @@ -0,0 +1,25 @@
> > +* PWM controlled by ChromeOS EC
> > +
> > +Google's ChromeOS EC PWM is a simple PWM attached to the Embedded Controller
> > +(EC) and controlled via a host-command interface.
> > +
> > +An EC PWM node should be only found as a sub-node of the EC node (see
> > +Documentation/devicetree/bindings/mfd/cros-ec.txt).
> > +
> > +Required properties:
> > +- compatible: Must contain "google,cros-ec-pwm"
> > +- #pwm-cells: Should be 1. The cell specifies the PWM index.
> > +- google,max-pwms: Specifies the number of PWMs supported by the EC.
> > +
> > +Example:
> > +       cros-ec@0 {
> > +               compatible = "google,cros-ec-spi";
> > +
> > +               ...
> > +
> > +               cros_ec_pwm: ec-pwm {
> > +                       compatible = "google,cros-ec-pwm";
> > +                       #pwm-cells = <1>;
> > +                       google,max-pwms = <4>;
> > +               };
> > +       };
> > --
> > 2.8.0.rc3.226.g39d4020
> >
