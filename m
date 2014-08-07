From: caesar <caesar.wang@rock-chips.com>
Subject: Re: [PATCH v4 2/2] pwm: rockchip: Added to support for RK3288 SoC
Date: Thu, 07 Aug 2014 09:27:33 +0800
Message-ID: <53E2D605.2000704@rock-chips.com>
References: <1406197295-10604-1-git-send-email-caesar.wang@rock-chips.com>	<1406197295-10604-3-git-send-email-caesar.wang@rock-chips.com> <CAD=FV=V4Kp-H3CcAKZPV1jBnYX+Ntwvxx6RB13TLxS5RRPHTWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.133]:37642 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366AbaHGB1l (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 6 Aug 2014 21:27:41 -0400
In-Reply-To: <CAD=FV=V4Kp-H3CcAKZPV1jBnYX+Ntwvxx6RB13TLxS5RRPHTWA@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?B?SGVpa28gU3TDvGJu?= =?UTF-8?B?ZXI=?= <heiko@sntech.de>, b.galvani@gmail.com, Rob Herring <robh+dt@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Randy Dunlap <rdunlap@infradead.org>, Kumar Gala <galak@codeaurora.org>, Eddie Cai <cf@rock-chips.com>, Tao Huang <huangtao@rock-chips.com>, Jianqun Xu <xjq@rock-chips.com>, Addy Ke <addy.ke@rock-chips.com>, =?UTF-8?B?6ZmI5riQ6aOe?= <cjf@rock-chips.com>, han jiang <hj@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pwm <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>

Doug,

=E5=9C=A8 2014=E5=B9=B408=E6=9C=8807=E6=97=A5 06:46, Doug Anderson =E5=86=
=99=E9=81=93:
> Caesar,
>
> On Thu, Jul 24, 2014 at 3:21 AM, Caesar Wang <caesar.wang@rock-chips.=
com> wrote:
>> +static const struct rockchip_pwm_data pwm_data_v1 =3D {
>> +       .regs.duty =3D PWM_HRC,
>> +       .regs.period =3D PWM_LRC,
>> +       .regs.cntr =3D PWM_CNTR,
>> +       .regs.ctrl =3D PWM_CTRL,
>> +       .prescaler =3D PRESCALER,
>> +       .set_enable =3D rockchip_pwm_set_enable_v1,
>> +};
>> +
>> +static const struct rockchip_pwm_data pwm_data_v2 =3D {
>> +       .regs.duty =3D PWM_LRC,
>> +       .regs.period =3D PWM_HRC,
>> +       .regs.cntr =3D PWM_CNTR,
>> +       .regs.ctrl =3D PWM_CTRL,
>> +       .prescaler =3D PRESCALER-1,
>> +       .set_enable =3D rockchip_pwm_set_enable_v2,
>> +};
>> +
>> +static const struct rockchip_pwm_data pwm_data_vop =3D {
>> +       .regs.duty =3D PWM_LRC,
>> +       .regs.period =3D PWM_HRC,
>> +       .regs.cntr =3D PWM_CTRL,
>> +       .regs.ctrl =3D PWM_CNTR,
> Did you really mean to flip CTRL and CNTR here?  If so, that's super
> confusing and deserves a comment.  AKA, I think the above should not
> be:
>
>   +       .regs.cntr =3D PWM_CTRL,
>   +       .regs.ctrl =3D PWM_CNTR,
>
> ...but should be
>
>   +       .regs.cntr =3D PWM_CNTR,
>   +       .regs.ctrl =3D PWM_CTRL,
>
> If you didn't mean to flip CTRL and CNTR here, then just get rid of
> pwm_data_vop and refer to pwm_data_v2.  In fact, I'd suggest that you
> totally remove the "rockchip,vop-pwm" since there's nothing different
> between "rockchip,rk3288-pwm" and "rockchip,vop-pwm".

Sorry,I think it's no problem. the  "rockchip,rk3288-pwm" and=20
"rockchip,vop-pwm" are seperate PWM controllers.
They are just different registers address between CNTR and CTRL .

>
> Have you validated Thierry's suggestion to allow you to access your
> memory range?
Yes,we have solve it in lcdc driver.
The Mark Yao have the  submission in [0].

[0]: https://lkml.org/lkml/2014/8/4/20
>
> -Doug
>
>
>


