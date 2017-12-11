From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3] pwm: imx: Let PWM be active during suspend
Date: Mon, 11 Dec 2017 10:24:20 -0200
Message-ID: <CAOMZO5DsyCbTKqRv4kZqa3n7Hp-xHkCrXjegEQt9Fi694men=w@mail.gmail.com>
References: <1511220443-26629-1-git-send-email-festevam@gmail.com>
 <20171205084701.GC7386@ulmo> <CAOMZO5DsWN_N5ygkCmNK_Dktp7UANdkSXi+iLacXnVHQ9j53AA@mail.gmail.com>
 <20171211091625.GA10671@ulmo> <CAOMZO5DiOx5m1Wew9v5xaqgbcNDR7gio93EKP48bdM3kaqfkoA@mail.gmail.com>
 <20171211121306.GK10671@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ot0-f179.google.com ([74.125.82.179]:34861 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbdLKMYW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Dec 2017 07:24:22 -0500
Received: by mail-ot0-f179.google.com with SMTP id q3so14529885oth.2
        for <linux-pwm@vger.kernel.org>; Mon, 11 Dec 2017 04:24:21 -0800 (PST)
In-Reply-To: <20171211121306.GK10671@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>, Russell King <linux@arm.linux.org.uk>, Fabio Estevam <fabio.estevam@nxp.com>, =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>, Lukasz Majewski <lukma@denx.de>

Adding Lukasz and Lothar who seem to have used pwm-imx driver with
polarity inverted.

On Mon, Dec 11, 2017 at 10:13 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:

> Yeah, my suggestion was to make setting the STOPEN bit dependent on the
> polarity inversion setting of the PWM. That way you don't have to hard-
> code it, which might not be the correct setting for non-inverted PWMs.

After using the polarity inversion the LED comes turned on after boot.

Setting the STOPEN bit does not help in this case, as It keeps on
during suspend.

The problem is that when polarity inversion is used I can no longer
turn the LED off:

# echo 0 > brightness (This keeps the LED on with its maximum
brightness, so there is a bug here)
# echo 1 > brightness (This keeps the LED off - well, actually it is
turned on with a minimum brightness - expected behaviour)
# echo 248 > brightness (This keeps the LED on with its maximum
brightness - expected behaviour)

So I think that once I managed to make 'echo 0 > brightness' to really
turn off the LED then the original issue (LED turned on during
suspend) will be gone.

Thanks
