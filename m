From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3] pwm: imx: Let PWM be active during suspend
Date: Tue, 5 Dec 2017 16:56:00 -0200
Message-ID: <CAOMZO5DsWN_N5ygkCmNK_Dktp7UANdkSXi+iLacXnVHQ9j53AA@mail.gmail.com>
References: <1511220443-26629-1-git-send-email-festevam@gmail.com> <20171205084701.GC7386@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ot0-f173.google.com ([74.125.82.173]:46745 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752410AbdLES4C (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Dec 2017 13:56:02 -0500
Received: by mail-ot0-f173.google.com with SMTP id j2so1162737ota.13
        for <linux-pwm@vger.kernel.org>; Tue, 05 Dec 2017 10:56:01 -0800 (PST)
In-Reply-To: <20171205084701.GC7386@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>, Russell King <linux@arm.linux.org.uk>, Fabio Estevam <fabio.estevam@nxp.com>

Hi Thierry,

On Tue, Dec 5, 2017 at 6:47 AM, Thierry Reding <thierry.reding@gmail.com> wrote:

> It looks like this would also keep other PWMs enabled in suspend. If for
> example you hooked up a fan to this PWM this change would make it so
> that the fan would remain on during suspend. That doesn't sound
> desirable to me.

It is expected that the PWM fan driver would disable the fan upon
entering into suspend.

The old vendor driver also sets the STOPEN bit unconditionally:
http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/arch/arm/plat-mxc/pwm.c?h=imx_2.6.35_11.09.01#n97

>
> On v2, I see this reply from you:
>
>         Please note that on imx6qdl-cuboxi the pwm is active low.

What I meant to say is that a logic level 0 turns on the LED.

> I also see that imx6q-cubox-i uses the "fsl,imx27-pwm" compatible
> version of this controller and that supports polarity inversion. I think
> the correct thing to do here is to mark the PWM as inverted (according
> to the DTS file it is actually the pwmleds node that has an active-low
> property). If you invert the PWM you could add extra code to the PWM
> driver to deal with this properly and set STOPEN only for inverted PWM
> signals.

Polarity is correct:

echo 0 > brightness --> turns off the LED
echo 248 > brightness ---> turns on the LED with the maximum brightness

It is only the behaviour during suspend which is not correct (LCD turns on).

Tried your suggestion of changing the polarity and it does not work
and breaks the usage during normal mode (non low power).

Another way to fix this would be to do like tegra pwm driver does in
implementing suspend/resume:
https://pastebin.com/sAFdKpDv

where the pinctrl state can be switched.

I tested it here and it works too.

Would it be acceptable to do add suspend/resume hooks for pwm-imx?

Thanks
