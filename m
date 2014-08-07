From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v4 2/2] pwm: rockchip: Added to support for RK3288 SoC
Date: Wed, 6 Aug 2014 19:16:51 -0700
Message-ID: <CAD=FV=Xw8tz2keCUtO+qYUmnuv=+DPGZjY9-j_2XmAcP3Luzjg@mail.gmail.com>
References: <1406197295-10604-1-git-send-email-caesar.wang@rock-chips.com>
	<1406197295-10604-3-git-send-email-caesar.wang@rock-chips.com>
	<CAD=FV=V4Kp-H3CcAKZPV1jBnYX+Ntwvxx6RB13TLxS5RRPHTWA@mail.gmail.com>
	<53E2D605.2000704@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <53E2D605.2000704@rock-chips.com>
Sender: linux-doc-owner@vger.kernel.org
To: caesar <caesar.wang@rock-chips.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, b.galvani@gmail.com, Rob Herring <robh+dt@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Randy Dunlap <rdunlap@infradead.org>, Kumar Gala <galak@codeaurora.org>, Eddie Cai <cf@rock-chips.com>, Tao Huang <huangtao@rock-chips.com>, Jianqun Xu <xjq@rock-chips.com>, Addy Ke <addy.ke@rock-chips.com>, =?UTF-8?B?6ZmI5riQ6aOe?= <cjf@rock-chips.com>, han jiang <hj@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pwm <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

Caesar,

On Wed, Aug 6, 2014 at 6:27 PM, caesar <caesar.wang@rock-chips.com> wro=
te:
> Doug,
>
> =E5=9C=A8 2014=E5=B9=B408=E6=9C=8807=E6=97=A5 06:46, Doug Anderson =E5=
=86=99=E9=81=93:
>
>> Caesar,
>>
>> On Thu, Jul 24, 2014 at 3:21 AM, Caesar Wang <caesar.wang@rock-chips=
=2Ecom>
>> wrote:
>>>
>>> +static const struct rockchip_pwm_data pwm_data_v1 =3D {
>>> +       .regs.duty =3D PWM_HRC,
>>> +       .regs.period =3D PWM_LRC,
>>> +       .regs.cntr =3D PWM_CNTR,
>>> +       .regs.ctrl =3D PWM_CTRL,
>>> +       .prescaler =3D PRESCALER,
>>> +       .set_enable =3D rockchip_pwm_set_enable_v1,
>>> +};
>>> +
>>> +static const struct rockchip_pwm_data pwm_data_v2 =3D {
>>> +       .regs.duty =3D PWM_LRC,
>>> +       .regs.period =3D PWM_HRC,
>>> +       .regs.cntr =3D PWM_CNTR,
>>> +       .regs.ctrl =3D PWM_CTRL,
>>> +       .prescaler =3D PRESCALER-1,
>>> +       .set_enable =3D rockchip_pwm_set_enable_v2,
>>> +};
>>> +
>>> +static const struct rockchip_pwm_data pwm_data_vop =3D {
>>> +       .regs.duty =3D PWM_LRC,
>>> +       .regs.period =3D PWM_HRC,
>>> +       .regs.cntr =3D PWM_CTRL,
>>> +       .regs.ctrl =3D PWM_CNTR,
>>
>> Did you really mean to flip CTRL and CNTR here?  If so, that's super
>> confusing and deserves a comment.  AKA, I think the above should not
>> be:
>>
>>   +       .regs.cntr =3D PWM_CTRL,
>>   +       .regs.ctrl =3D PWM_CNTR,
>>
>> ...but should be
>>
>>   +       .regs.cntr =3D PWM_CNTR,
>>   +       .regs.ctrl =3D PWM_CTRL,
>>
>> If you didn't mean to flip CTRL and CNTR here, then just get rid of
>> pwm_data_vop and refer to pwm_data_v2.  In fact, I'd suggest that yo=
u
>> totally remove the "rockchip,vop-pwm" since there's nothing differen=
t
>> between "rockchip,rk3288-pwm" and "rockchip,vop-pwm".
>
>
> Sorry,I think it's no problem. the  "rockchip,rk3288-pwm" and
> "rockchip,vop-pwm" are seperate PWM controllers.
> They are just different registers address between CNTR and CTRL .

OK, I looked up in the TRM.  Right, the CNTR and CTRL are flipped on
the vop.  So I think that the only change you need is to add:

#define PWM_VOP_CTRL  0x00
#define PWM_VOP_CNTR  0x0c

=2E..then use these new #defines for the vop structure.


As you have the code written right now it's very confusing.  The new
#defines will fix this.


>> Have you validated Thierry's suggestion to allow you to access your
>> memory range?
>
> Yes,we have solve it in lcdc driver.
> The Mark Yao have the  submission in [0].
>
> [0]: https://lkml.org/lkml/2014/8/4/20

Excellent!  Then we should be able to land after you fix the above.

-Doug
