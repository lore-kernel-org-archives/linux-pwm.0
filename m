From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3] pwm: imx: Let PWM be active during suspend
Date: Mon, 11 Dec 2017 16:48:39 -0200
Message-ID: <CAOMZO5Dc8ssuvr52Kk6iipCQfB1ftPU3fryw6qSDBy8xttKNOw@mail.gmail.com>
References: <1511220443-26629-1-git-send-email-festevam@gmail.com>
 <20171205084701.GC7386@ulmo> <CAOMZO5DsWN_N5ygkCmNK_Dktp7UANdkSXi+iLacXnVHQ9j53AA@mail.gmail.com>
 <20171211091625.GA10671@ulmo> <CAOMZO5DiOx5m1Wew9v5xaqgbcNDR7gio93EKP48bdM3kaqfkoA@mail.gmail.com>
 <20171211121306.GK10671@ulmo> <CAOMZO5DsyCbTKqRv4kZqa3n7Hp-xHkCrXjegEQt9Fi694men=w@mail.gmail.com>
 <20171211142040.757f1313@karo-electronics.de> <CAOMZO5AwijXQi=gR9BaW_WYVPBpCpa8V=wWMcHBt+xCqNySo8A@mail.gmail.com>
 <20171211165545.2d4b21bd@karo-electronics.de> <CAOMZO5D-g-H2n0Fx9h=3vX_ryvPbXB64nsvzuTo_ddJeBke7Uw@mail.gmail.com>
 <20171211175250.73289f27@karo-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:45330 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752103AbdLKSsk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Dec 2017 13:48:40 -0500
Received: by mail-oi0-f45.google.com with SMTP id x20so12278811oix.12
        for <linux-pwm@vger.kernel.org>; Mon, 11 Dec 2017 10:48:40 -0800 (PST)
In-Reply-To: <20171211175250.73289f27@karo-electronics.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>, Russell King <linux@arm.linux.org.uk>, Fabio Estevam <fabio.estevam@nxp.com>, Lukasz Majewski <lukma@denx.de>

Hi Lothar,

On Mon, Dec 11, 2017 at 2:52 PM, Lothar Wa=C3=9Fmann <LW@karo-electronics.d=
e> wrote:

> I also prefer the patch that doesn't mess with the pin configs.

Thanks for your feedback.

Would you mind testing this patch on your system?
https://patchwork.ozlabs.org/patch/839834/

Thanks
