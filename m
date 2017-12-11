From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCH v3] pwm: imx: Let PWM be active during suspend
Date: Mon, 11 Dec 2017 14:20:40 +0100
Message-ID: <20171211142040.757f1313@karo-electronics.de>
References: <1511220443-26629-1-git-send-email-festevam@gmail.com>
        <20171205084701.GC7386@ulmo>
        <CAOMZO5DsWN_N5ygkCmNK_Dktp7UANdkSXi+iLacXnVHQ9j53AA@mail.gmail.com>
        <20171211091625.GA10671@ulmo>
        <CAOMZO5DiOx5m1Wew9v5xaqgbcNDR7gio93EKP48bdM3kaqfkoA@mail.gmail.com>
        <20171211121306.GK10671@ulmo>
        <CAOMZO5DsyCbTKqRv4kZqa3n7Hp-xHkCrXjegEQt9Fi694men=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from smtprelay09.ispgateway.de ([134.119.228.118]:56931 "EHLO
        smtprelay09.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752629AbdLKNpe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Dec 2017 08:45:34 -0500
In-Reply-To: <CAOMZO5DsyCbTKqRv4kZqa3n7Hp-xHkCrXjegEQt9Fi694men=w@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>, Russell King <linux@arm.linux.org.uk>, Fabio Estevam <fabio.estevam@nxp.com>, Lukasz Majewski <lukma@denx.de>

Hi,

On Mon, 11 Dec 2017 10:24:20 -0200 Fabio Estevam wrote:
> Adding Lukasz and Lothar who seem to have used pwm-imx driver with
> polarity inverted.
> 
> On Mon, Dec 11, 2017 at 10:13 AM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> 
> > Yeah, my suggestion was to make setting the STOPEN bit dependent on the
> > polarity inversion setting of the PWM. That way you don't have to hard-
> > code it, which might not be the correct setting for non-inverted PWMs.
> 
> After using the polarity inversion the LED comes turned on after boot.
> 
> Setting the STOPEN bit does not help in this case, as It keeps on
> during suspend.
> 
> The problem is that when polarity inversion is used I can no longer
> turn the LED off:
> 
> # echo 0 > brightness (This keeps the LED on with its maximum
> brightness, so there is a bug here)
> # echo 1 > brightness (This keeps the LED off - well, actually it is
> turned on with a minimum brightness - expected behaviour)
> # echo 248 > brightness (This keeps the LED on with its maximum
> brightness - expected behaviour)
> 
> So I think that once I managed to make 'echo 0 > brightness' to really
> turn off the LED then the original issue (LED turned on during
> suspend) will be gone.
> 
The problem is, that the PWM output goes low whenever the PWM is
disabled, no matter what polarity is programmed. So, you would need to
prevent the PWM from being disabled whenever the duty cycle is set to 0.

I'm using the PWM for an LCD backlight that has a separate ENABLE pin.
Thus by driving that pin via the backlight power supply regulator, the
backlight actually switches off, though the PWM output is constantly
active (LOW).


Lothar Waßmann
