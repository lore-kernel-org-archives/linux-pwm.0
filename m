From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3] pwm: imx: Let PWM be active during suspend
Date: Sat, 16 Dec 2017 16:26:13 -0200
Message-ID: <CAOMZO5Bsnxzdjo6PLPK4V4=7jj_dnG2tm_OZPX-dAqUinB8vJQ@mail.gmail.com>
References: <1511220443-26629-1-git-send-email-festevam@gmail.com>
 <20171205084701.GC7386@ulmo> <CAOMZO5DsWN_N5ygkCmNK_Dktp7UANdkSXi+iLacXnVHQ9j53AA@mail.gmail.com>
 <20171211091625.GA10671@ulmo> <CAOMZO5DiOx5m1Wew9v5xaqgbcNDR7gio93EKP48bdM3kaqfkoA@mail.gmail.com>
 <20171211121306.GK10671@ulmo> <CAOMZO5DsyCbTKqRv4kZqa3n7Hp-xHkCrXjegEQt9Fi694men=w@mail.gmail.com>
 <20171211142040.757f1313@karo-electronics.de> <CAOMZO5AwijXQi=gR9BaW_WYVPBpCpa8V=wWMcHBt+xCqNySo8A@mail.gmail.com>
 <20171211165545.2d4b21bd@karo-electronics.de> <CAOMZO5D-g-H2n0Fx9h=3vX_ryvPbXB64nsvzuTo_ddJeBke7Uw@mail.gmail.com>
 <20171211175250.73289f27@karo-electronics.de> <CAOMZO5Dc8ssuvr52Kk6iipCQfB1ftPU3fryw6qSDBy8xttKNOw@mail.gmail.com>
 <20171215130207.226bf773@karo-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:42532 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756694AbdLPS0O (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 16 Dec 2017 13:26:14 -0500
Received: by mail-oi0-f44.google.com with SMTP id o64so8237805oia.9
        for <linux-pwm@vger.kernel.org>; Sat, 16 Dec 2017 10:26:14 -0800 (PST)
In-Reply-To: <20171215130207.226bf773@karo-electronics.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>, Russell King <linux@arm.linux.org.uk>, Fabio Estevam <fabio.estevam@nxp.com>, Lukasz Majewski <lukma@denx.de>

Hi Lothar,

On Fri, Dec 15, 2017 at 10:02 AM, Lothar Wa=C3=9Fmann <LW@karo-electronics.=
de> wrote:

>> Would you mind testing this patch on your system?
>> https://patchwork.ozlabs.org/patch/839834/
>>
> Sorry for the late response.
> The patch does not affect the usage of the PWM with the pwm_bl driver,
> since the pwm_bl driver configures the duty cycle to '0' and disables
> the PWM upon suspend.

Ok,so I take this as a no-objection for this patch from you.

Thierry, could you please consider applying this one?

Thanks
