From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3] pwm: imx: Let PWM be active during suspend
Date: Mon, 11 Dec 2017 13:07:46 -0200
Message-ID: <CAOMZO5AwijXQi=gR9BaW_WYVPBpCpa8V=wWMcHBt+xCqNySo8A@mail.gmail.com>
References: <1511220443-26629-1-git-send-email-festevam@gmail.com>
 <20171205084701.GC7386@ulmo> <CAOMZO5DsWN_N5ygkCmNK_Dktp7UANdkSXi+iLacXnVHQ9j53AA@mail.gmail.com>
 <20171211091625.GA10671@ulmo> <CAOMZO5DiOx5m1Wew9v5xaqgbcNDR7gio93EKP48bdM3kaqfkoA@mail.gmail.com>
 <20171211121306.GK10671@ulmo> <CAOMZO5DsyCbTKqRv4kZqa3n7Hp-xHkCrXjegEQt9Fi694men=w@mail.gmail.com>
 <20171211142040.757f1313@karo-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:40348 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbdLKPHs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Dec 2017 10:07:48 -0500
Received: by mail-oi0-f49.google.com with SMTP id w125so11766088oie.7
        for <linux-pwm@vger.kernel.org>; Mon, 11 Dec 2017 07:07:48 -0800 (PST)
In-Reply-To: <20171211142040.757f1313@karo-electronics.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>, Russell King <linux@arm.linux.org.uk>, Fabio Estevam <fabio.estevam@nxp.com>, Lukasz Majewski <lukma@denx.de>

Hi Lothar,

On Mon, Dec 11, 2017 at 11:20 AM, Lothar Wa=C3=9Fmann <LW@karo-electronics.=
de> wrote:

> The problem is, that the PWM output goes low whenever the PWM is
> disabled, no matter what polarity is programmed. So, you would need to
> prevent the PWM from being disabled whenever the duty cycle is set to 0.

Yes, that's the key point: PWM output goes low when PWM is disabled.

I don't think we can workaround this behaviour in the pwm-imx driver.

So at the moment I see two ways to fix this:

1. Set the STOPEN bit which is what I do in this patch

or

2. Add support for allowing changing pinctrl in suspend:
https://pastebin.com/71UGrnkA

This way we can configure the pwm output pin as Hi-Z during suspend.

What do you think?

Thanks
