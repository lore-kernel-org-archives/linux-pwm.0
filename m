From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2 2/4] mfd: cros_ec: add EC_PWM function definitions
Date: Fri, 17 Jun 2016 12:21:33 -0700
Message-ID: <20160617192133.GA83919@google.com>
References: <1464916904-37554-1-git-send-email-briannorris@chromium.org>
 <1464916904-37554-3-git-send-email-briannorris@chromium.org>
 <20160616153817.GD21702@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35055 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847AbcFQTVh (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Jun 2016 15:21:37 -0400
Received: by mail-pf0-f175.google.com with SMTP id c2so33515140pfa.2
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jun 2016 12:21:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160616153817.GD21702@dell>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Stephen Barber <smbarber@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Randall Spangler <rspangler@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>

On Thu, Jun 16, 2016 at 04:38:17PM +0100, Lee Jones wrote:
> On Thu, 02 Jun 2016, Brian Norris wrote:
> > The EC_CMD_PWM_{GET,SET}_DUTY commands allow us to control a PWM that is
> > attached to the EC, rather than the main host SoC. The API provides
> > functionality-based (e.g., keyboard light, backlight) or index-based
> > addressing of the PWM(s). Duty cycles are represented by a 16-bit value,
> > where 0 maps to 0% duty cycle and U16_MAX maps to 100%. The period
> > cannot be controlled.
> > 
> > This command set is more generic than, e.g.,
> > EC_CMD_PWM_{GET,SET}_KEYBOARD_BACKLIGHT and could possibly used to
> > replace it on future products.
> > 
> > Let's update the command header to include the definitions.
> > 
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> > v2: no change
> > 
> >  include/linux/mfd/cros_ec_commands.h | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> > 
> > diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
> > index 13b630c10d4c..d673575e0ada 100644
> > --- a/include/linux/mfd/cros_ec_commands.h
> > +++ b/include/linux/mfd/cros_ec_commands.h
> > @@ -949,6 +949,37 @@ struct ec_params_pwm_set_fan_duty {
> >  	uint32_t percent;
> >  } __packed;
> >  
> > +#define EC_CMD_PWM_SET_DUTY 0x25
> > +/* 16 bit duty cycle, 65535 = 100% */
> > +#define EC_PWM_MAX_DUTY 65535
> 
> Any reason this isn't represented in hex, like we do normally?

Hex would probably be clearer. I'll try to change that.

> > +enum ec_pwm_type {
> > +	/* All types, indexed by board-specific enum pwm_channel */
> > +	EC_PWM_TYPE_GENERIC = 0,
> > +	/* Keyboard backlight */
> > +	EC_PWM_TYPE_KB_LIGHT,
> > +	/* Display backlight */
> > +	EC_PWM_TYPE_DISPLAY_LIGHT,
> > +	EC_PWM_TYPE_COUNT,
> > +};
> 
> Are these comments really necessary?  I'd recommend that if your
> defines require comments, then they are not adequately named.  In this
> case however, I'd suggest that they are and the comments are
> superfluous.

I don't think your rule holds water: there are definitely cases where
defines/enums require (or at least are better with) additional comments.
Sentence-long identifier names are not very readable, but sometimes a
sentence of comment can help.

Anyway, I think two of the three are probably unnecessary, if you really
want to ask. The first (EC_PWM_TYPE_GENERIC) seems useful.

But then, how do you suggest handling this in conjunction with your
kerneldoc suggestion? IIRC, kerneldoc requires that if one
entry/field/parameter is documented, then all most be documented. So
avoid kerneldoc on the enum, and just use inline comments?

[snip the rest, which was discussed in other branches of this thread]

Brian
