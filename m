From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCH v3] pwm: imx: Let PWM be active during suspend
Date: Fri, 15 Dec 2017 13:02:07 +0100
Message-ID: <20171215130207.226bf773@karo-electronics.de>
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
        <20171211175250.73289f27@karo-electronics.de>
        <CAOMZO5Dc8ssuvr52Kk6iipCQfB1ftPU3fryw6qSDBy8xttKNOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from smtprelay01.ispgateway.de ([80.67.18.43]:30237 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753443AbdLOMCO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 15 Dec 2017 07:02:14 -0500
In-Reply-To: <CAOMZO5Dc8ssuvr52Kk6iipCQfB1ftPU3fryw6qSDBy8xttKNOw@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>, Russell King <linux@arm.linux.org.uk>, Fabio Estevam <fabio.estevam@nxp.com>, Lukasz Majewski <lukma@denx.de>

Hi,

On Mon, 11 Dec 2017 16:48:39 -0200 Fabio Estevam wrote:
> Hi Lothar,
> 
> On Mon, Dec 11, 2017 at 2:52 PM, Lothar Waßmann <LW@karo-electronics.de> wrote:
> 
> > I also prefer the patch that doesn't mess with the pin configs.
> 
> Thanks for your feedback.
> 
> Would you mind testing this patch on your system?
> https://patchwork.ozlabs.org/patch/839834/
> 
Sorry for the late response.
The patch does not affect the usage of the PWM with the pwm_bl driver,
since the pwm_bl driver configures the duty cycle to '0' and disables
the PWM upon suspend.


Lothar Waßmann
