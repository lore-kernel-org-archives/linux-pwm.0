From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCH v3] pwm: imx: Let PWM be active during suspend
Date: Mon, 11 Dec 2017 17:52:50 +0100
Message-ID: <20171211175250.73289f27@karo-electronics.de>
References: <1511220443-26629-1-git-send-email-festevam@gmail.com>
        <20171205084701.GC7386@ulmo>
        <CAOMZO5DsWN_N5ygkCmNK_Dktp7UANdkSXi+iLacXnVHQ9j53AA@mail.gmail.com>
        <20171211091625.GA10671@ulmo>
        <CAOMZO5DiOx5m1Wew9v5xaqgbcNDR7gio93EKP48bdM3kaqfkoA@mail.gmail.com>
        <20171211121306.GK10671@ulmo>
        <CAOMZO5DsyCbTKqRv4kZqa3n7Hp-xHkCrXjegEQt9Fi694men=w@mail.gmail.com>
        <20171211142040.757f1313@karo-electronics.de>
        <CAOMZO5AwijXQi=gR9BaW_WYVPBpCpa8V=wWMcHBt+xCqNySo8A@mail.gmail.com>
        <20171211165545.2d4b21bd@karo-electronics.de>
        <CAOMZO5D-g-H2n0Fx9h=3vX_ryvPbXB64nsvzuTo_ddJeBke7Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from smtprelay04.ispgateway.de ([80.67.31.38]:61896 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752321AbdLKQw4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Dec 2017 11:52:56 -0500
In-Reply-To: <CAOMZO5D-g-H2n0Fx9h=3vX_ryvPbXB64nsvzuTo_ddJeBke7Uw@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>, Russell King <linux@arm.linux.org.uk>, Fabio Estevam <fabio.estevam@nxp.com>, Lukasz Majewski <lukma@denx.de>

Hi,

On Mon, 11 Dec 2017 14:06:31 -0200 Fabio Estevam wrote:
> Hi Lothar,
> 
> On Mon, Dec 11, 2017 at 1:55 PM, Lothar Waßmann <LW@karo-electronics.de> wrote:
> 
> >> 1. Set the STOPEN bit which is what I do in this patch
> >>
> > This should probably work.
> > But this won't fix the issue, that the LED or backlight is turned fully
> > on when the brightness value is set to 0, since both the leds-pwm and
> > the pwmbl driver explicitly disable the PWM, when the brightness
> > value is set to 0.
> 
> Yes, but in the case of imx6qdl-cubox-i.dtsi the PWM is used in the
> normal polarity and the inversion is achieved via 'active-low'
> property of pwm-leds.
> 
> On this board the current dts + current pwm-imx driver behaves
> incorrecly only during suspend (LED is on). During normal mode the PWM
> operation is correct.
> 
> By setting the STOPEN bit the LED is off in suspend.
> 
> >> 2. Add support for allowing changing pinctrl in suspend:
> >> https://pastebin.com/71UGrnkA
> >>
> >> This way we can configure the pwm output pin as Hi-Z during suspend.
> >>
> >> What do you think?
> >>
> > It would be better to enable the 22K pullup on the pin. Otherwise the
> > pin will be floating when there is no external pullup resistor.
> 
> Yes, but first we need to come to a conclusion if we go with solution
> 1 (enable STOPEN) or with solution 2 (allow changinh pinctrl) :-)
> 
> I am more inclined to go with solution 1 as this was also used in the
> old vendor 3.0.35 kernel:
> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/arch/arm/plat-mxc/pwm.c?h=imx_3.0.35_4.1.0#n106
> 
> Please let me know what you prefer.
> 
I also prefer the patch that doesn't mess with the pin configs.


Lothar Waßmann
