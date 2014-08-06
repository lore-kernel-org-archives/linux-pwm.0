From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v4 2/2] pwm: rockchip: Added to support for RK3288 SoC
Date: Wed, 6 Aug 2014 15:46:21 -0700
Message-ID: <CAD=FV=V4Kp-H3CcAKZPV1jBnYX+Ntwvxx6RB13TLxS5RRPHTWA@mail.gmail.com>
References: <1406197295-10604-1-git-send-email-caesar.wang@rock-chips.com>
	<1406197295-10604-3-git-send-email-caesar.wang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-vc0-f175.google.com ([209.85.220.175]:48587 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753927AbaHFWqV (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 6 Aug 2014 18:46:21 -0400
Received: by mail-vc0-f175.google.com with SMTP id ik5so5047915vcb.6
        for <linux-pwm@vger.kernel.org>; Wed, 06 Aug 2014 15:46:21 -0700 (PDT)
In-Reply-To: <1406197295-10604-3-git-send-email-caesar.wang@rock-chips.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Caesar Wang <caesar.wang@rock-chips.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, b.galvani@gmail.com, Rob Herring <robh+dt@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Randy Dunlap <rdunlap@infradead.org>, Kumar Gala <galak@codeaurora.org>, Eddie Cai <cf@rock-chips.com>, Tao Huang <huangtao@rock-chips.com>, Jianqun Xu <xjq@rock-chips.com>, Addy Ke <addy.ke@rock-chips.com>, =?UTF-8?B?6ZmI5riQ6aOe?= <cjf@rock-chips.com>, han jiang <hj@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pwm <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>

Caesar,

On Thu, Jul 24, 2014 at 3:21 AM, Caesar Wang <caesar.wang@rock-chips.com> wrote:
> +static const struct rockchip_pwm_data pwm_data_v1 = {
> +       .regs.duty = PWM_HRC,
> +       .regs.period = PWM_LRC,
> +       .regs.cntr = PWM_CNTR,
> +       .regs.ctrl = PWM_CTRL,
> +       .prescaler = PRESCALER,
> +       .set_enable = rockchip_pwm_set_enable_v1,
> +};
> +
> +static const struct rockchip_pwm_data pwm_data_v2 = {
> +       .regs.duty = PWM_LRC,
> +       .regs.period = PWM_HRC,
> +       .regs.cntr = PWM_CNTR,
> +       .regs.ctrl = PWM_CTRL,
> +       .prescaler = PRESCALER-1,
> +       .set_enable = rockchip_pwm_set_enable_v2,
> +};
> +
> +static const struct rockchip_pwm_data pwm_data_vop = {
> +       .regs.duty = PWM_LRC,
> +       .regs.period = PWM_HRC,
> +       .regs.cntr = PWM_CTRL,
> +       .regs.ctrl = PWM_CNTR,

Did you really mean to flip CTRL and CNTR here?  If so, that's super
confusing and deserves a comment.  AKA, I think the above should not
be:

 +       .regs.cntr = PWM_CTRL,
 +       .regs.ctrl = PWM_CNTR,

...but should be

 +       .regs.cntr = PWM_CNTR,
 +       .regs.ctrl = PWM_CTRL,

If you didn't mean to flip CTRL and CNTR here, then just get rid of
pwm_data_vop and refer to pwm_data_v2.  In fact, I'd suggest that you
totally remove the "rockchip,vop-pwm" since there's nothing different
between "rockchip,rk3288-pwm" and "rockchip,vop-pwm".


Have you validated Thierry's suggestion to allow you to access your
memory range?

-Doug
